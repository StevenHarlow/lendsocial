class BusinessesController < ApplicationController
	
	def show
		@business = Business.find(params[:id])
		
		@loans = Loan.find_all_by_business_id( @business.id )

		respond_to do |format|
		  format.html # show.html.erb
		  format.json { render json: @business }
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
	
	def edit
	
	end
	
	
	def update
	
	end
end
