
module Ui
  class MultiSelect2Component < ViewComponent::Base
    attr_reader :form, :field_name, :label, :options, :selected_values, :errors, :placeholder

    def initialize(form:, field_name:, label:, selected_values: [], options: [], errors: nil, placeholder: nil)
      @form = form
      @field_name = field_name
      @label = label
      @selected_values = Array(selected_values).flatten
      @options = options
      @errors = errors || (form.object.errors if form.object) || {} 
      @placeholder = placeholder
    end
  end
end

