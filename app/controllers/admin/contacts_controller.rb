class Admin::ContactsController < Admin::BaseController
  before_action :set_contact, only: [ :show, :edit, :update, :destroy ]

  def index
    scope = Contact.order(created_at: :desc)
    scope = scope.by_stage(params[:stage]) if params[:stage].present?
    @pagy, @contacts = pagy(scope)
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to admin_contact_path(@contact), notice: "Contact created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to admin_contact_path(@contact), notice: "Contact updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to admin_contacts_path, notice: "Contact deleted."
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(
      :first_name, :last_name, :email, :phone, :company_name,
      :title, :stage, :source, :website_url, :notes
    )
  end
end
