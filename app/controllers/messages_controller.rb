class MessagesController < ApplicationController  
  def new
    @message = Message.new
  end

	def create
	  params[:message][:author_id] ||= current_user.id
	 	@message = Message.new(params[:message])

	 	respond_to do |format|
	 	  format.html do
	 	    if @message.save
	 	      if request.xhr?
	 	        @messages = Message.statuses.for_user(current_user).page(1)
	 	        render template: 'messages/list', layout: false
 	        else
 	          redirect_to root_path
          end
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end
	  end
	  
  end
end