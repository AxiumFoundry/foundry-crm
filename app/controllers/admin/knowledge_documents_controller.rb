class Admin::KnowledgeDocumentsController < Admin::BaseController
  before_action :set_document, only: [ :edit, :update, :destroy ]

  def index
    @pagy, @documents = pagy(KnowledgeDocument.order(created_at: :desc))
  end

  def new
    @document = KnowledgeDocument.new
  end

  def create
    @document = KnowledgeDocument.new(document_params)

    if @document.save
      redirect_to admin_knowledge_documents_path, notice: "Document created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to admin_knowledge_documents_path, notice: "Document updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
    redirect_to admin_knowledge_documents_path, notice: "Document deleted."
  end

  private

  def set_document
    @document = KnowledgeDocument.find(params[:id])
  end

  def document_params
    params.require(:knowledge_document).permit(:title, :content, :active)
  end
end
