require 'securerandom'

class PictureController < ApplicationController

  def new
  end

  def create
    @pic = Picture.create(original_filename: params[:picture].original_filename,
                          uid: SecureRandom.urlsafe_base64,
                          data: params[:picture].read,
                          viewable: true)
  end

  def show
    @picture = Picture.find_by_uid params[:id]
  end

  def raw
    pic = Picture.find_by_uid params[:id]
    if pic && pic.viewable
      pic.viewable = false
      pic.save
      send_data pic.data
    else
      nil
    end
  end

  def delete
    Picture.find_by_uid(params[:id]).destroy
  end

end
