require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  it 'ログインページにアクセスできる' do
    visit new_user_session_path
    expect(page).to have_content('ログイン')
  end
end