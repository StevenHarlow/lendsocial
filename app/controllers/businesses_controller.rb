class BusinessesController < ApplicationController
  
  before_filter :find_business, :only => [:show, :follow, :unfollow, :comments]
	
	def show
	  @post = @business.postings.build(message_type_id: 2, author_id: current_user.id)
	  logger.debug @post.inspect
		respond_to do |format|
		  format.html
		end
	end
	
	def new
		@business = Business.new

		respond_to do |format|
		  format.html # apply.html.erb
		  format.json { render json: @business }
		end
	end
	
	def create
	 	@business = Business.new(params[:business])
    @business.users << current_user 

		respond_to do |format|
		  if @business.save
			format.html { redirect_to @business, notice: 'Business was successfully created.' }
			format.json { render json: @business, status: :created, location: @business }
		  else
			format.html { render action: "new" }
			format.json { render json: @business.errors, status: :unprocessable_entity }
		  end
		end
	end
	
	def follow
	  current_user.follow(@business)
	  render partial: 'widgets/follow'
  end
  
  def unfollow
    current_user.unfollow(@business)
    render partial: 'widgets/follow'
  end
  
  def comments
    @messages = Message.postings.for_business(@business).page(params[:page] || 1)
    respond_to_xhr
  end
	
	def edit
	
	end
	
	
	def update
	
	end
	
	private
	
	def find_business
	  @business = Business.find(params[:id])
  end
  
  def respond_to_xhr
    if request.xhr?
      respond_to do |format|
        format.html {render template: 'messages/list', layout: false}
      end
    else
      redirect_to url_for(@business)
    end
  end

end