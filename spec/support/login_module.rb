module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button('ログイン')
  end
  def admin_login(admin)
    visit new_admin_session_path
    fill_in 'user_email', with: admin.email
    fill_in 'user_password', with: admin.password
    click_button('ログイン')
  end
end