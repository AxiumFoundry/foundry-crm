class AiResponseGenerator
  def initialize(conversation)
    @conversation = conversation
  end

  def generate
    messages = @conversation.chat_messages.ordered.to_a
    current_message = messages.pop
    return "" unless current_message

    documents = DocumentFinder.new(current_message.content).find_relevant
    context = format_context(documents)

    chat = RubyLLM.chat(model: "gpt-4o-mini")
    chat.with_instructions(system_prompt_with_context(context))

    messages.each do |msg|
      chat.add_message(role: msg.role.to_sym, content: msg.content)
    end

    response = chat.ask(current_message.content)
    response.content
  end

  private

  def format_context(documents)
    return "" if documents.empty?

    documents.map { |doc| "#{doc.title}:\n#{doc.content}" }.join("\n\n---\n\n")
  end

  def system_prompt_with_context(context)
    prompt = SiteSetting.current.text("chat_system_prompt")
    return prompt if context.blank?

    "#{prompt}\n\nRelevant information from our knowledge base:\n#{context}"
  end
end
