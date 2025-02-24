module Ui
  class SelectFieldComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, options:, include_blank: "", input_class: "")
      @form = form
      @field_name = field_name
      @label = label
      @options = options
      @include_blank = include_blank
      @input_class = input_class
    end

    def call
      content_tag(:div, class: "field px-3") do
        label_tag = tag.label(@label, for: @field_name, class: "block text-sm mb-2 font-medium text-gray-700 dark:text-white")
        select_input = select_field

        error_tag = error_message
        label_tag + select_input + error_tag
      end
    end

    def select_field
      select_classes = "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      select_classes += " #{@input_class}" unless @input_class.empty?

      @form.select(@field_name, @options, { include_blank: @include_blank }, class: select_classes)
    end

    def error_message
      return unless error.present?

      tag.span error, class: "text-red-500 text-sm"
    end

    def error
      return nil if @form.object.nil?
      @form.object.errors[@field_name].first
    end
  end
end
