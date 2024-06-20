class PagesController < ApplicationController
  layout "application_applypage", only: [:apply]
  layout "application_documentuploadpage", only: [:documentupload]

  def cardoptions
  end

  def apply
  end

  def documentupload
  end

  def applicationform
  end
end
