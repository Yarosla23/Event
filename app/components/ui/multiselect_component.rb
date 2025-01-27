class Ui::MultiselectComponent < ViewComponent::Base
  attr_reader :tags, :selected_tags, :form, :label, :errors

  def initialize(form:, tags:, selected_tags: [], label: nil, errors: nil)
    @form = form
    @tags = tags
    @selected_tags = selected_tags
    @label = label
    @errors = errors || (form.object.errors if form.object) || {} # Handle errors gracefully
  end
end
