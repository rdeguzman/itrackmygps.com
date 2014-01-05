shared_context 'login' do
  def login_user
    @user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password

    click_button 'Submit'
    #save_and_open_page
  end

  def logout
    click_link 'Logout'
  end
end