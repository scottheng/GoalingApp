require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it "should render the new template" do
      get :new, link: {}

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    before(:each) do
      user = User.create(
        username: "Dallas",
        password: "secret"
      )
      allow(controller)
        .to receive(:current_user)
        .and_return(user)
    end

    context 'with valid params' do
      it 'should redirect to the user home page' do
        post :create, link: {
          username: "Dallas",
          password: "secret"
        }

        expect(:response).to redirect_to(
          user_url(User.last)
        )
      end

      it 'login the user' do
        post :create, link: {
          username: "Dallas",
          password: "secret"
        }

        expect(session[:session_token]).to eq(User.last.session_token)
      end
    end

    context 'with invalid params' do
      it 'should re-render the sign in page and flashes errors' do
        post :create, link: {
          username: "Dallas",
          password: "bad"
        }

        expect(response).to render_template(:new)
        expect(flash[:errors]).to include("Invalid credentials")
      end

      it 'doesn\'t log in the user' do
        post :create, link: {
          username: "Dallas",
          password: "bad"
        }

        expect(session[:session_token]).to be_nil
      end
    end
  end

  # describe 'DELETE #destroy' do
  #   it 'should redirect to the sign in page' do
  #
  #   end
  #
  #   it 'should logout the user'
  # end
end
