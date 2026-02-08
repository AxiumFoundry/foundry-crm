require "test_helper"

class ChatMailerTest < ActionMailer::TestCase
  test "human_contact_requested" do
    conversation = chat_conversations(:human_requested)
    email = ChatMailer.human_contact_requested(conversation)

    assert_equal [ "hello@axiumfoundry.com" ], email.to
    assert_equal "Chat Visitor Wants to Talk to a Human", email.subject
    assert_match "requested to talk to a human", email.body.encoded
    assert_match "John Contact", email.body.encoded
    assert_match "john@example.com", email.body.encoded
  end

  test "conversation_transcript" do
    conversation = chat_conversations(:active_conversation)
    email = ChatMailer.conversation_transcript(conversation)

    assert_equal [ "dmitry.sychev@me.com" ], email.to
    assert_match "Chat Conversation Transcript", email.subject
    assert_match "Transcript", email.body.encoded
  end

  test "daily_digest" do
    conversations = ChatConversation.recent
    email = ChatMailer.daily_digest(conversations)

    assert_equal [ "dmitry.sychev@me.com" ], email.to
    assert_match "Daily Chat Digest", email.subject
  end
end
