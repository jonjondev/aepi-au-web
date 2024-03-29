class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
  	if params[:list] == 'brother list'
  		@contacts = policy_scope(Contact).search(params[:search]).where(is_brother: true)
  	elsif params[:list] == 'rush list'
  		@contacts = policy_scope(Contact).search(params[:search]).where(is_brother: false)
  	else
    	@contacts = policy_scope(Contact).search(params[:search])
  	end

  	@contacts = @contacts.sort_by{|c| c[:last_name]}
  end

  def show
    @contact = Contact.find(params[:id])
    @notes = Note.where(contact_id: @contact.id)
    @note = Note.new
  end

  def new
    @contact = Contact.new
    authorize @contact
    @unis = Uni.all
    @states = State.all
  end

  def edit
  	@contact = Contact.find(params[:id])
    authorize @contact
    @unis = Uni.all
    @states = State.all
  end

  def create
    @contact = Contact.new(contact_params)
    authorize @contact

    if @contact.save
        redirect_to :action => 'index'
    else
        render :action => 'new'
    end
  end

  def update
    @contact = Contact.find(params[:id])
    authorize @contact

    if @contact.update_attributes(contact_params)
        redirect_to :action => 'index'
    else
        render :action => 'edit'
    end
  end

  def destroy
  	authorize @contact
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def settings
  	authorize Contact
  	@unis = Uni.all
  	@states = State.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :mobile, :uni_id, :state_id, :high_school, :added_by, :degree, :rush_priority, :is_brother, :high_school_graduation_year, :uni_commencement_year)
    end
end
