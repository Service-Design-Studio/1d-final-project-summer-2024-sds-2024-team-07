class PagesController < ApplicationController
  layout "application_cardoptionspage", only: [:cardoptions]
  layout "application_applypage", only: [:apply]
  layout "application_documentuploadpage", only: [:documentupload]
  layout "application_applicationformpage", only: [:applicationform]

  def cardoptions
  end

  def apply
  end

  def documentupload
  end

  def applicationform
  end
end
