RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user, password: 'QWEasdzxc123') }

  let(:new_user) { build(:user, email: 'example@gmail.com', password: '12345678Qw')}

  describe '#new' do
    context 'registration new user' do
      before do
        visit(new_user_registration_path)
        fill_in('user_email', with: new_user.email)
        fill_in('user_password', with: new_user.password)
        fill_in('confirm', with: new_user.password)
        click_button(I18n.t(:back_to_store))
      end

      it { expect(page).to have_text(I18n.t(:'devise.registrations.signed_up'))}
      it { expect(page).to have_current_path(root_path) }
    end

    context 'registration with error' do
      let(:user_with_bad_password) { build(:user, password: '123456Q')}

      before do
        visit(new_user_registration_path)
        fill_in('user_email', with: user_with_bad_password.email)
        fill_in('user_password', with: user_with_bad_password.password)
        fill_in('confirm', with: user_with_bad_password.password)
        click_button(I18n.t(:back_to_store))
      end

      it { expect(page).to have_text("Password is invalid")}
      it { expect(page).to have_current_path('/users') }
    end

    context 'login user' do
      before do
        visit(new_user_session_path)
        fill_in('user_email', with: user.email)
        fill_in('user_password', with: user.password)
        click_button(I18n.t(:back_to_store))
      end

      it { expect(page).to have_current_path(root_path) }
    end

    context 'forget password' do
      before do
        visit(new_user_password_path)
        fill_in('user_email', with: user.email)
        click_button(I18n.t(:email_instruction))
      end

      it { expect(page).to have_current_path(new_user_session_path) }
    end
  end

  describe '#edit' do
    context 'edit password without send email' do
      before do
        visit(edit_user_password_path)
      end
      it { expect(page).to have_text(I18n.t(:'devise.passwords.no_token'))}
      it { expect(page).to have_current_path(new_user_session_path) }
    end

    context 'update password' do
      before do
        visit(new_user_password_path)
        fill_in('user_email', with: user.email)
        click_button(I18n.t(:email_instruction))
        visit '/users/password/edit?reset_password_token=' + user.reset_password_token
      end

      it { expect(page).to have_text(I18n.t(:set_new_password))}
      it { expect(page).to have_current_path('/users/password/edit?reset_password_token=' + user.reset_password_token)}
    end
  end
end
