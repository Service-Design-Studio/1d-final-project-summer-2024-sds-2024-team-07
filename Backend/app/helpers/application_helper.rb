module ApplicationHelper
  def step_class(step)
    case step
    when 1
      'active' if current_page?(pages_documentupload_path)
    when 2
      'active' if current_page?(pages_applicationform_path)
    when 3
      'active' if current_page?(verify_details_path)
    when 4
      'active' if current_page?(create_pin_path)
    when 5
      'active' if current_page?(create_pin_path)
    else
      ''
    end
  end

  def relevant_page?(path)
    current_page?(path)
  end
  
end
