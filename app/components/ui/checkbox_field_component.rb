class Ui::CheckboxFieldComponent < ViewComponent::Base
  attr_reader :form, :field_name, :label, :input_class, :checked_value

  def initialize(form:, field_name:, label:, input_class: '')
    @form = form
    @field_name = field_name
    @label = label
    @input_class = input_class
    # Преобразуем значение в булево при инициализации
    @checked_value = ActiveModel::Type::Boolean.new.cast(form.object.send(field_name))
  end

  def render?
    field_name.present? && label.present?
  end
end
