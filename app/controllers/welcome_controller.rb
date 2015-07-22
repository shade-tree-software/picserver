class WelcomeController < ApplicationController

  def upload
    uploaded_io = params[:picture]
    dir = Rails.root.join('public', 'uploads')
    Dir.mkdir(dir) unless Dir.exists?(dir)
    tempfile = File.new File.join(dir, uploaded_io.original_filename), 'w', :encoding => 'binary'
    tempfile.write uploaded_io.read
    tempfile.flush
  end

end
