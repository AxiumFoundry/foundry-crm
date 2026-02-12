class ChatMailer < ApplicationMailer
  def human_contact_requested(conversation)
    @conversation = conversation
    @messages = conversation.chat_messages.ordered

    mail(
      to: NOTIFICATION_EMAIL,
      subject: "Chat Visitor Wants to Talk to a Human"
    )
  end

  def conversation_transcript(conversation)
    @conversation = conversation
    @messages = conversation.chat_messages.ordered

    mail(
      to: NOTIFICATION_EMAIL,
      subject: "Chat Conversation Transcript - #{conversation.created_at.strftime('%b %d')}"
    )
  end

  def daily_digest(conversations)
    @conversations = conversations
    @total_messages = ChatMessage.where(chat_conversation: conversations).count

    mail(
      to: NOTIFICATION_EMAIL,
      subject: "Daily Chat Digest - #{Date.current.strftime('%b %d, %Y')}"
    )
  end
end
