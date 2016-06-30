ActiveAdmin.register Component do
  menu false

  controller do
    actions :update

    def update
      resource.assign_attributes permitted_params

      update! do |success, failure|
        component_form = render_to_string(
          partial: resource.to_form_path, locals: {component: resource})

        success.json do
          render json: {resource: resource, component_form: component_form}
        end

        failure.json do
          render status: :unprocessable_entity, json: {
            errors: resource.errors, component_form: component_form}
        end
      end
    end

    def permitted_params
      params.require(:component).permit(resource.class.permitted_params)
    end

    def resource
      @component ||= Component[params[:component][:key]]
    end
  end
end
