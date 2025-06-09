class MediaFilesController < ApplicationController
  def destroy
    @media_file = MediaFile.find(params[:id])
    @media_file.destroy
    
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end 