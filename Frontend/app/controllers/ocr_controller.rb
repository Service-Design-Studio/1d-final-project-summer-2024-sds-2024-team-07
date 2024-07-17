class OcrController < ApplicationController
  def new
  end

  def create
    # Path to your Python script
    script_path = Rails.root.join('../Backend/scripts/ocr_script.py').to_s

    # Call the Python script
    output, status = Open3.capture2e("python3 #{script_path}")

    if status.success?
      render plain: output
    else
      render plain: output, status: :unprocessable_entity
    end
  end
end
