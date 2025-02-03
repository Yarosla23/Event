class Ui::MultiselectComponent < ViewComponent::Base
  attr_reader :field_name, :value, :selected_values, :form, :label, :errors, :placeholder

  def initialize(form:, field_name: nil, value:, selected_values: [], label: nil, errors: nil, placeholder: nil)
    @form = form
    @field_name = field_name
    @field_names = [field_name]
    @value = value
    @selected_values = Array(selected_values).flatten || []
    @label = label
    @errors = errors || (form.object.errors if form.object) || {} # Handle errors gracefully
    @placeholder = placeholder
  end
end