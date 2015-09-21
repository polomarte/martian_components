module MartianComponents
  module ComponentsHelper
    def component_tag_for component
      options = {
        id:    component.anchor_name,
        class: dom_class(component, 'component'),
        data:  {
          component_key: component.key,
          options: component.options}}

      content_tag :article, options do
        yield
      end
    end

    def component key, options={}, &block
      component = Component[key]

      if component.present?
        cache_key = ['v1', component, Digest::MD5.hexdigest(
          [options, block.try(:call)].join)]

        Rails.cache.fetch cache_key do
          if block_given?
            render component, options: options, block: block
          else
            render component, options: options
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
        params = [
          'showinfo=0'
        ].join('&')

        content_tag :iframe, nil,
          src: "//www.youtube.com/v/#{video_id}?#{params}",
          frameborder: 0,
          allowfullscreen: true
      end
    end
  end
end

