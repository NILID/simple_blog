require 'rails_helper'

describe ContainersController do
  let!(:note)   { create(:note, :with_preview) }
  let!(:container) { create(:container, note: note) }

  describe 'admin activities should' do
    login_user(:admin)

    it 'edit' do
      expect(@ability.can? :edit, container).to be true
      expect(get :edit, params: { id: container, note_id: note }).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, container).to be true
      put :update, params: { id: container, note_id: note, container: attributes_for(:container) }
      expect(response).to redirect_to(assigns(:container).note)
    end

    it 'destroy' do
      expect(@ability.can? :destroy, container).to be true
      expect{ delete :destroy, params: { id: container, note_id: note }, xhr: true }.to change(Container, :count).by(-1)
    end
  end

  [:user].each do |role|
    describe "user with #{role} role activities should" do
      login_user(role)

      it 'edit' do
        expect(@ability.can? :edit, container).to be false
        expect{ get :edit, params: { id: container, note_id: note } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'update' do
        expect(@ability.can? :update, container).to be false
        expect{ put :update, params: { id: container, note_id: note, container: attributes_for(:container) } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not destroy' do
        expect(@ability.cannot? :destroy, container).to be true
        expect{ delete :destroy, params: { id: container, note_id: note }, xhr: true }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Container, :count).by(0)
      end
    end
  end

  describe 'unreg user activities should' do
    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).not_to be_nil
      end

      it('get new')  { get :new, params: { note_id: note } }
      it('create')   { expect{ post :create, params: { container: attributes_for(:container), note_id: note } }.to change(Container, :count).by(0) }
      it('get edit') { get :edit, params: { id: container, note_id: note } }
      it('update')   { put :update, params: { id: container, note_id: note, container: attributes_for(:container) } }
      it('destroy')  { expect{ delete :destroy, params: { id: container, note_id: note } }.to change(Container, :count).by(0) }
    end
  end
end
