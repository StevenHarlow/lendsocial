class LoansController < ApplicationController
  before_filter :authorize, :only => [:edit, :update]

  def index
    @loans = Loan.find( :all, :conditions => { :published_date => Date.today-1..Date.today+1 } )

  	respond_to do |format|
      format.html
      format.json { render json: @loans }
    end
  end

  def publish
  	@loan = Loan.find(params[:loan][:id])
  	@loan.published_date = Date.today

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
     @loan.published_date = nil

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
      format.html
      format.json { render json: @loan }
    end
  end

  def apply
    @loan = Loan.new

    respond_to do |format|
      format.html
      format.json { render json: @loan }
    end
  end

  def create
    @loan = Loan.new(params[:loan])
    @loan.user_id = current_user.id
    @loan[:funding_deadline] = Date.strptime(params[:datepicker], '%m/%d/%Y')
    @loan[:request_date] = DateTime.current

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

  def edit
    @loan[:loan_purpose_description] = @loan.loan_purpose.description
    @loan[:funding_deadline] = @loan[:funding_deadline].to_date
  end

  def update
    @loan.published_date = DateTime.current
    @loan[:funding_deadline] = Date.strptime(params[:datepicker], '%m/%d/%Y')

    respond_to do |format|
      if @loan.update_attributes(params[:loan])
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end
 	
  protected

  def authorize
    @loan = Loan.find(params[:id])
    if @loan.user.id != current_user.id
      redirect_to @loan, notice: 'Permission denied'
    end
  end
end