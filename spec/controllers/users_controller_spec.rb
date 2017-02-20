require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context "with valid params" do
      it "redirects to user home page" do
        post :create, user: {username: "Dallas", password: "secret"}

        expect(response).to redirect_to(user_url(User.find_by(username: "Dallas")))
      end
    end

    context "with invalid params" do
      it "re-renders sign up page and flashes errors" do
        post :create, user: {username: "Dallas"}

        expect(response).to render_template(:new)
        expect(flash[:errors]).to include()
      end
    end
  end

  describe 'GET #show' do
    before(:each) {user = User.create(username: "Dallas", password: "secret")}
    it "redirects to user page" do
      get :show, id: User.last.id

      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end

  end
end
