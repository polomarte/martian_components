module MartianComponents
  module ComponentsHelper
    def component_tag_for component
      options = {
        id:    dom_class(component, 'component'),
        class: dom_class(component, 'component'),
        name:  component.anchor_name,
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
        if block_given?
          render component, options: options, block: block
        else
          render component, options: options
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
  end
end

