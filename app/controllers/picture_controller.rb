require 'securerandom'

class PictureController < ApplicationController

  def new
  end

  def create
    @pic = Picture.create(original_filename: params[:picture].original_filename,
                          uid: SecureRandom.urlsafe_base64,
                          data: params[:picture].read,
                          viewable: true,
                          content_type: params[:picture].content_type)
  end

  def show
    @picture = Picture.find_by_uid params[:id]
  end

  def raw
    pic = Picture.find_by_uid params[:id]
    if pic && pic.viewable
      if pic.expiry.nil?
        # pic exists, is viewable, and has no expiry date.  show pic once and never again.
        pic.viewable = false
        pic.save
        send_data pic.data, :disposition => :inline, :type => (pic.content_type || 'application/octet-stream')
      elsif pic.expiry <= Time.now.to_i
        # pic exists and is viewable, but expiry is in the past.  never show the pic.
        pic.viewable = false
        pic.save
        nil
      else
        # pic exists and expiry date is in the future.  show pic and keep it viewable.
        send_data pic.data, :disposition => :inline, :type => (pic.content_type || 'application/octet-stream')
      end
    else
      # pic does not exist or is no longer viewable.
      nil
    end
  end

  def delete
    Picture.find_by_uid(params[:id]).destroy
  end

  def viewable
    @picture = Picture.find_by_uid params[:id]
  end

end
