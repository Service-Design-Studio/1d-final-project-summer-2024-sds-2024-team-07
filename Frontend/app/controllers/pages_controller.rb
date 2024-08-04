class PagesController < ApplicationController
  layout :set_layout
  def set_layout
    case action_name
    when 'apply'
      'application_applypage'
    when 'documentupload'
      'application_documentuploadpage'
    when 'applicationform'
      'application_formpage'
    when 'applicationchecklist'
      'application_checklistpage'
    when 'verifydetails'
      'application_verifydetailspage'
    when 'createpin'
      'application_createpinpage'
    # else
    #   'application'
    end
  end

  # def cardoptions
  # end

  def apply
  end

  def documentupload
  end

  def applicationform
    @user = User.find_by(session_id: session[:user_id])
  end
end
