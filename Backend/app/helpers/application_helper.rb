module ApplicationHelper
  def step_class(step)
    case step
    when 1
      'active' if current_page?(upload_documents_path)
    when 2
      'active' if current_page?(application_form_path)
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
end
