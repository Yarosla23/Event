# app/components/ui/multiselect_component.rb
class Ui::MultiselectComponent < ViewComponent::Base
  attr_reader :tags, :selected_tags, :form

  def initialize(form:, tags:, selected_tags: [], label: nil)
    @form = form
    @tags = tags
    @selected_tags = selected_tags
    @label = label

  end
end
