require 'securerandom'

class PictureController < ApplicationController

  def new
  end

  def create
    @pic = Picture.create(original_filename: params[:picture].original_filename,
                          uid: SecureRandom.urlsafe_base64,
                          data: params[:picture].read)
  end

  def show
    @picture = Picture.find_by_uid(params[:id])
  end

  def raw
    send_data Picture.find_by_uid(params[:id]).data
  end

  def delete
    Picture.find_by_uid(params[:id]).destroy
  end

end
