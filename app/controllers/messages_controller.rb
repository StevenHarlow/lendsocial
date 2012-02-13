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
	 	        @messages = case params[:message][:posted_to_type]
 	          when "User"
  	 	        Message.postings.for_user(current_user).page(1)
	 	        when "Business"
	 	          business = Business.find(params[:message][:posted_to_id])
	 	          Message.postings.for_business(business).page(1)
 	          else
 	            Message.statuses.page(1) # temp solution
            end
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