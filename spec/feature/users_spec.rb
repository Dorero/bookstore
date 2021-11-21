RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user) }

  describe '#new' do
    context 'registration new user' do
      before do
        visit(new_user_registration_path)
        fill_in('email', with: 'example@gmail.com')
        fill_in('password', with: '123456')
        fill_in('confirm', with: '123456')
        click_button('Back to Store')
      end

      it { expect(User.all.find_by(email: 'example@gmail.com')).to be_a User }
      it { expect(page).to have_current_path(root_path) }
    end

    context 'login user' do
      before do
        visit(new_user_session_path)
        fill_in('email', with: user.email)
        fill_in('password', with: user.password)
        click_button('Back to Store')
      end

      it { expect(page).to have_current_path(root_path) }
    end

    context 'forget password' do

      before do
        visit(new_user_password_path)
        fill_in('email', with: user.email)
        click_button('Email Instructions')
      end

      it { expect(ActionMailer::Base.deliveries.count).to eq(1)}
      it { expect(ActionMailer::Base.deliveries.first.to.join).to eq(user.email)}
      it { expect(page).to have_current_path(new_user_session_path) }
    end
  end
end
