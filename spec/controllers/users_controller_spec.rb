require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user) { create(:user) }

  describe 'unreg user activities should' do
    it('get index') {
      expect(get :index).to render_template(:index)
      expect(assigns(:users)).not_to be_empty
    }

    it('get show') {
      expect(get :show, params: { id: user }).to render_template(:show)
    }

    describe 'not' do
      after(:each)    { expect(response).to redirect_to(root_path) }
    end
  end
end
