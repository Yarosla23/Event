module Ui
  class InputFieldComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, type: "text", placeholder: "", step: nil, input_class: "", options: {})
      @form = form
      @field_name = field_name
      @label = label
      @type = type
      @placeholder = placeholder
      @step = step
      @input_class = input_class
      @options = options # Для передачи дополнительных параметров, таких как значения радиокнопок
    end

    def call
      content_tag(:div, class: "field px-3") do
        if @type == "radio"
          render_radio_buttons
        else
          label_tag = tag.label(@label, for: @field_name, class: "block text-sm mb-2 font-medium ")
          input = input_field
          error_tag = error_message
          label_tag + input + error_tag
        end
      end
    end

    def render_radio_buttons
      content_tag(:div, class: "flex flex-col space-y-2") do
        @options.fetch(:values, []).map do |value, label|
          tag.div(class: "flex items-center space-x-2") do
            radio_button = @form.radio_button(@field_name, value, id: "#{@field_name}_#{value}", class: radio_button_classes)
            label_tag = tag.label(label, for: "#{@field_name}_#{value}", class: "text-sm font-medium text-gray-900 dark:text-gray-300")
            radio_button + label_tag
          end
        end.join.html_safe + error_message
      end
    end

    def input_field
      input_classes = "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"

      if @type == "text_area"
        input_classes += " !whitespace-pre-wrap !resize-none"
      end

      input_classes += " #{@input_class}" unless @input_class.empty?

      @form.send(@type.to_sym, @field_name, 
        placeholder: @placeholder,
        class: input_classes,
        step: @step)
    rescue NoMethodError
      @form.text_field(@field_name, placeholder: @placeholder, class: input_classes)
    end

    def radio_button_classes
      "w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"
    end

    def error
      return nil if @form.object.nil?
      @form.object.errors[@field_name].first
    end

    def error_message
      return unless error.present? 

      tag.span error, class: "text-red-500 text-sm" 
    end
  end
end
