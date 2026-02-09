class CreateKnowledgeDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :knowledge_documents do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.vector :embedding, limit: 1536
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :knowledge_documents, :active
  end
end
