class LoansController < ApplicationController


  def index
  	@loans = Loan.find( :all, :conditions => { :publishedDate => Date.today-1..Date.today+1 } )
  		
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loans }
    end 
  end
  
  def publish
  
  	@loan = Loan.find( params[:loan][:id] )
  	@loan.publishedDate = Date.today
  	
  	respond_to do |format|
      if @loan.save
        format.html { render :partial => "published", :locals => { :loan => @loan } }
        format.json { render json: @loan, status: :published, location: @loan }
      else
        format.html { render action: "published" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def unpublish
  
  	@loan = Loan.find( params[:loan][:id] )
  	@loan.publishedDate = nil
  	
  	respond_to do |format|
      if @loan.save
        format.html { render :partial => "not_published", :locals => { :loan => @loan } }
        format.json { render json: @loan, status: :published, location: @loan }
      else
        format.html { render action: "published" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def show
    @loan = Loan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end
  
  # GET /loans/apply
  # GET /loans/apply.json
  def apply
    @loan = Loan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan }
    end
  end

  # GET /loans/1/edit
  def edit
    @loan = Loan.find(params[:id])
    @loan[:loan_purpose_description] = @loan.loan_purpose.description
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(params[:loan])
    @loan.user_id = current_user.id

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render json: @loan, status: :created, location: @loan }
      else
        format.html { render action: "new" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loans/1
  # PUT /loans/1.json
  def update
    @loan = Loan.find(params[:id])

    respond_to do |format|
      if @loan.update_attributes(params[:loan]) && @loan.loan_purpose.update_attributes( {:description => params[:loan][:loan_purpose_description]} )
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end
end
