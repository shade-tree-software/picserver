require 'securerandom'

class PictureController < ApplicationController

  def new

  end

  def create
    uploaded_io = params[:picture]
    dir = Rails.root.join('public', 'uploads')
    Dir.mkdir(dir) unless Dir.exists?(dir)
    uid = SecureRandom.urlsafe_base64
    filename = File.join dir, "#{uid}#{File.extname uploaded_io.original_filename}"
    puts "Writing #{filename}"
    tempfile = File.new filename, 'w', :encoding => 'binary'
    tempfile.write uploaded_io.read
    tempfile.flush
    @pic = Picture.create(original_filename: uploaded_io.original_filename,
                          uid: uid)
  end

  def show
    @picture = Picture.find_by_uid(params[:id])
  end

  def raw
    @picture = Picture.find_by_uid(params[:id])
    dir = Rails.root.join('public', 'uploads')
    filename = File.join dir, "#{@picture.uid}#{File.extname(@picture.original_filename)}"
    image_data = File.read filename
    send_data image_data
  end

end
