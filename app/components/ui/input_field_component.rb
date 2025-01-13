module Ui
  class InputFieldComponent < ViewComponent::Base
    def initialize(form:, field_name:, label:, type: "text", placeholder: "", step: nil, input_class: "")
      @form = form
      @field_name = field_name
      @label = label
      @type = type
      @placeholder = placeholder
      @step = step
      @input_class = input_class
    end

    def call
      content_tag(:div, class: "field px-3") do
        # Рендерим метку для поля
        label_tag = tag.label(@label, for: @field_name, class: "block text-sm mb-2 font-medium text-gray-700 dark:text-white")

        # Рендерим поле ввода с возможной ошибкой
        input = input_field

        # Рендерим сообщение об ошибке, если оно есть
        error_tag = error_message

        # Объединяем все элементы
        label_tag + input + error_tag
      end
    end

    # Метод для рендеринга поля ввода
    def input_field
      # Общие классы для поля ввода
      input_classes = "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"

      # Добавляем кастомные классы, если они переданы
      input_classes += " #{@input_class}" unless @input_class.empty?

      # Используем send для динамического вызова подходящего хелпера поля ввода
      @form.send(@type.to_sym, @field_name, 
        placeholder: @placeholder,
        class: input_classes,
        step: @step)
    rescue NoMethodError
      # Fallback в случае, если @type некорректен
      @form.text_field(@field_name, placeholder: @placeholder, class: input_classes)
    end

    # Метод для получения ошибки для данного поля
    def error
      return nil if @form.object.nil?
      @form.object.errors[@field_name].first
    end
    
    # Метод для рендеринга сообщения об ошибке
    def error_message
      return unless error.present?  # Если ошибка есть, рендерим её

      tag.span error, class: "text-red-500 text-sm"  # Сообщение об ошибке
    end
  end
end
