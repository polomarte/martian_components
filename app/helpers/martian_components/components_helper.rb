module MartianComponents
  module ComponentsHelper
    def component_tag_for component
      tag_options = {
        id:    component.anchor_name,
        class: [component.css_class] | [component.options[:class]],
        data:  {
          component_key: component.key,
          options: component.options[:data]}}

      content_tag :article, tag_options do
        yield
      end
    end

    def component key_or_object, options={}, &block
      component = key_or_object.is_a?(String) ? Component[key_or_object] : key_or_object
      component.options = component.options.deep_merge(options)

      if component.present?
        cache_key = ['v1', component,
          Digest::MD5.hexdigest([options, block_given? && capture(component, &block)].join)]

        Rails.cache.fetch cache_key do
          if block_given?
            render component, block: block
          else
            render component
          end
        end
      end
    end

    def affix_nav page
      content_tag :ul, class: 'nav nav-list component-affix_nav' do
        output = ""

        navegable_components = Component
          .where(affix_nav_navegable: true)
          .where("key LIKE ?", "#{page}:%").order(:id).map do |component|
            component.becomes component.subclass_based_on_key
          end

        navegable_components.each do |component|
          output << content_tag(:li) do
            link_to component.decorate.title, "##{component.anchor_name}"
          end
        end

        output.html_safe
      end
    end

    def embedded_video_player video_id
      content_tag :div, class: 'embedded-video-player-wrapper' do
        output = ''

        poster_content = capture do
          out = ''
          out << inline_svg('martian_components/embedded_video_player/player_play.svg', class: 'play-icon')
          out << image_tag('martian_components/embedded_video_player/loader.gif', class: 'loader')
          out.html_safe
        end

        output << (content_tag :div, poster_content,
          style: "background-image: url('http://img.youtube.com/vi/#{video_id}/hqdefault.jpg'",
          class: 'embedded-video-player-poster')

        output << content_tag(:div, nil,
          id: "embedded-video-#{video_id}",
          class: 'embedded-video-player-placeholder',
          data: {video_id: video_id})

        output.html_safe
      end
    end
  end
end

