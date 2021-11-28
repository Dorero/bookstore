RSpec.describe 'User', type: :feature, js: true do
  let!(:user) { create(:user, password: 'QWEasdzxc123') }

  let(:user_data) { attributes_for(:user, password: '12345678Qw')}

  describe '#new' do
    context 'registration new user' do
      before do
        visit(new_user_registration_path)
        fill_in('user[email]', with: user_data[:email])
        fill_in('user[password]', with: user_data[:password])
        fill_in('user[password_confirmation]', with: user_data[:password])
        click_button(I18n.t(:back_to_store))
      end

      it { expect(page).to have_text(I18n.t(:'devise.registrations.signed_up_but_unconfirmed'))}
      it { expect(page).to have_current_path(root_path) }
    end

    context 'registration with error' do
      let(:user_with_bad_password) { attributes_for(:user, password: '123456Q')}

      before do
        visit(new_user_registration_path)
        fill_in('user[email]', with: user_with_bad_password[:email])
        fill_in('user[password]', with: user_with_bad_password[:password])
        fill_in('user[password_confirmation]', with: user_with_bad_password[:password])
        click_button(I18n.t(:back_to_store))
      end

      it { expect(page).to have_text("Password is invalid")}
      it { expect(page).to have_current_path(user_registration_path) }
    end

    context 'login user' do
      before do
        user.confirm
        visit(new_user_session_path)
        fill_in('user[email]', with: user.email)
        fill_in('user[password]', with: user.password)
        click_button(I18n.t(:back_to_store))
      end

      it { expect(page).to have_current_path(root_path) }
    end

    context 'forget password' do
      before do
        visit(new_user_password_path)
        fill_in('user[email]', with: user.email)
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
        fill_in('user[email]', with: user.email)
        click_button(I18n.t(:email_instruction))
        visit edit_user_password_path(reset_password_token: user.reset_password_token)
      end

      it { expect(page).to have_text(I18n.t(:set_new_password))}
      it { expect(page).to have_current_path(edit_user_password_path(reset_password_token: user.reset_password_token))}
    end
  end

  describe '#facebook' do
    context 'log in through facebook' do
      before do
        visit(new_user_session_path)
        OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({ :provider => 'facebook', :uid => '123545',
                                                                        :info => { :name => "#{user_data[:first_name]}#{user_data[:last_name]}",
                                                                                   :email => user_data[:email] } })
        click_link(class: 'general-login-icon')
      end

      it { expect(page).to have_content(I18n.t(:'devise.omniauth_callbacks.success', kind: 'Facebook'))}
      it { expect(page).to have_current_path(root_path) }
    end

    context 'register through facebook' do
      before do
        visit(new_user_registration_path)
        OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({ :provider => 'facebook', :uid => '123545',
                                                                        :info => { :name => "#{user_data[:first_name]}#{user_data[:last_name]}",
                                                                                   :email => user_data[:email] } })
        click_link(class: 'general-login-icon')
      end

      it { expect(page).to have_content(I18n.t(:'devise.omniauth_callbacks.success', kind: 'Facebook'))}
      it { expect(page).to have_current_path(root_path) }
    end
  end
end
