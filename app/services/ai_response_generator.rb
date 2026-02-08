class AiResponseGenerator
  SYSTEM_PROMPT = <<~PROMPT.freeze
    You are a helpful AI assistant for Axium Foundry, a technical consultancy that helps startups ship faster. Based in NYC, available everywhere.

    About Axium Foundry:
    - Expert technical consultancy for ambitious startups
    - Services: Fractional CTO, technical leadership, full-stack engineering, AI integration
    - Capabilities: Ship faster without hiring senior developers, rescue & modernize legacy systems, deploy & scale infrastructure, integrate & extend systems, build AI agents
    - Tech expertise: Ruby on Rails, React, PostgreSQL, AWS, Docker, and modern web technologies
    - Focus on startups that need senior engineering talent without the full-time commitment

    Your role:
    - Answer questions about Axium Foundry's services, capabilities, and expertise
    - Be professional, concise, and genuinely helpful
    - If you have relevant context from our knowledge base, use it to give accurate answers
    - When visitors seem interested in working together, suggest they use the "Get Started" button or email hello@axiumfoundry.com
    - If you don't have specific information, say so honestly and offer to connect them with the team
    - Keep responses conversational and under 150 words unless more detail is needed
    - Do not discuss topics unrelated to Axium Foundry's business
  PROMPT

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
    return SYSTEM_PROMPT if context.blank?

    "#{SYSTEM_PROMPT}\n\nRelevant information from our knowledge base:\n#{context}"
  end
end
