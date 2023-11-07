require 'rails_helper'

RSpec.describe 'User sends a message', type: :system do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }

  describe 'when user sends a message' do
    it 'displays a successful message' do
      sign_in(sender)
      fill_in_form_and_submit
      expect(page).to have_text 'The message was sent.'
    end

    it 'displays message in recipient inbox' do
      sign_in(recipient)

      visit messages_path
      expect(page).to have_text('No messages')

      Capybara.using_session("Sender session") do
        sign_in(sender)
        fill_in_form_and_submit
        expect(page).to have_text 'The message was sent.'
      end

      expect(page).to have_text(sender.name)
      expect(page).to have_text('A message')
    end
  end

  private

  def fill_in_form_and_submit
    visit new_message_path

    select recipient.name, from: 'To'
    fill_in 'Body', with: 'A message'

    click_on 'Send message'
  end
end
