require 'securerandom'

class PictureController < ApplicationController

  def new

  end

  def create
    uploaded_io = params[:picture]
    dir = File.join 'public', 'uploads'
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

  def get_filename_by_uid(uid)
    picture = Picture.find_by_uid(uid)
    File.join 'public', 'uploads', "#{picture.uid}#{File.extname(picture.original_filename)}"
  end

  def raw
    send_data File.read(get_filename_by_uid params[:id])
  end

  def delete
    File.delete(get_filename_by_uid params[:id])
    Picture.find_by_uid(params[:id]).destroy
  end

end
