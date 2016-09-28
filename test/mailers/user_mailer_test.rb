require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome email data is correct" do
    # Send the email, then test that it got queued
    email = UserMailer.welcome_email(users(:testuser)).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['tubefedzt@gmail.com'], email.from
    assert_equal [users(:testuser).email], email.to
    assert_equal 'Welcome to Tubefedzt', email.subject
  end

  test "mail_all data is correct" do
    # Send the email, then test that it got queued
    message = "Message insert here, such a cool message right?"
    subject = "This is a subject"
    email = UserMailer.mail_all(users(:testuser), subject, message).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['tubefedzt@gmail.com'], email.from
    assert_equal [users(:testuser).email], email.to
    assert_equal subject, email.subject
    assert email.body.to_s.include? message
  end

end
