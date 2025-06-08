module Ui
  class MultiSelectFieldComponent < ViewComponent::Base
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
        label_tag + select_input + error_message
      end
    end

    private

    def label_tag
      tag.label(@label, for: @field_name, class: "block text-lg font-semibold text-gray-600 dark:text-gray-300 mb-2")
    end

    def select_input
      select_classes = "mt-1 block w-full text-lg rounded-lg border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 shadow-sm focus:border-blue-500 focus:ring focus:ring-blue-500 focus:ring-opacity-50"
      select_classes += " #{@input_class}" unless @input_class.empty?

      @form.select(
        @field_name,
        @options,
        { include_blank: @include_blank, multiple: true },
        { class: select_classes, name: "#{@form.object_name}[#{@field_name}][]" }
      )
    end

    def error_message
      return unless error.present?

      tag.span error, class: "text-red-500 text-sm mt-2"
    end

    def error
      return nil if @form.object.nil?
      @form.object.errors[@field_name].first
    end
  end
end
