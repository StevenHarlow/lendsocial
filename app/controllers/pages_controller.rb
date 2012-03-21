class PagesController < ApplicationController
  def show
    debugger
    render template: "pages/#{params[:id]}"
  end
end