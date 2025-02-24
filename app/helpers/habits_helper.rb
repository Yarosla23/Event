module HabitsHelper
  STATUS = ['Выполняется', 'Не выполняется', 'Выполнена']

  def nav_link_to(name, path)
    class_name = if current_page?(path)
                   'rounded-lg py-3 px-5 text-white block font-medium hover:text-blue-400 active:bg-blue-900 text-xl'
                 else
                   'rounded-lg py-3 px-5 text-gray-500 block font-medium hover:text-blue-400 active:bg-blue-900'
                 end
    link_to name, path, class: class_name
  end

  def status_svg_color(status)
    case status
    when 'Выполняется'
      'text-yellow-500'  
    when 'Не выполняется'
      'text-red-400'    
    when 'Выполнена'
      'text-green-500'   
    else
      'text-gray-500'   
    end
  end
  
  def status_color(status)
    case status
    when 'Выполняется'
      ['text-yellow-500', 'bg-yellow-100']  # Text color and background color
    when 'Не выполняется'
      ['text-red-400', 'bg-red-100']
    when 'Выполнена'
      ['text-green-500', 'bg-green-100']
    else
      ['text-gray-500', 'bg-gray-100']
    end
  end

  def tag_status(status)
    text_color, bg_color = status_color(status)
    content_tag(:span, status, class: "inline-block py-1 px-3 mb-4 rounded-lg #{bg_color} #{text_color} font-semibold border-2 border-#{text_color}")
  end
end
