if ActiveRecord::Base.connection.table_exists? 'components'
  ADMIN_PAGE_COMPONENTS = {
    'App' => [
      'app:banner:banner_a'
    ]}

  ADMIN_PAGE_COMPONENTS.each_pair do |page_name, component_keys|
    ActiveAdmin.register_page page_name do
      menu priority: ADMIN_PAGE_COMPONENTS.keys.index(page_name)
    end

    component_keys.each_with_index do |component_key, i|
      ActiveAdmin.register_page component_key do
        component = Component[component_key]

        next if component.nil? # Skip when component exist yet

        menu parent: page_name, priority: i, label: component.decorate.title

        content title: component.decorate.title do
          columns do
            column do
              render component.to_form_path, component: component
            end
          end
        end
      end
    end
  end
end
