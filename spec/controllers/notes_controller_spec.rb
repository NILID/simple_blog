require 'rails_helper'

describe NotesController do
  let!(:user) { create(:user) }
  let!(:note) { create(:note, :with_preview, user: user) }

  let!(:other_user) { create(:user) }
  let!(:shown_note) { create(:note, :with_preview, user: other_user, hide: false) }


  describe 'admin activities should' do
    login_user(:admin)

    it 'new' do
      expect(@ability.can? :new, Note).to be true
      expect(get :new).to render_template(:new)
    end

    it 'create' do
      expect(@ability.can? :create, Note).to be true
      expect{ post :create, params: { note: attributes_for(:note, :with_preview) } }.to change(Note, :count).by(1)
      expect(response).to redirect_to(assigns(:note))
    end

    it 'edit' do
      expect(@ability.can? :edit, note).to be true
      expect(get :edit, params: { id: note }).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, note).to be true
      put :update, params: { id: note, note: attributes_for(:note) }
      expect(response).to redirect_to(assigns(:note))
    end

    it 'destroy' do
      expect(@ability.can? :destroy, note).to be true
      expect{ delete :destroy, params: { id: note } }.to change(Note, :count).by(-1)
      expect(response).to redirect_to(Note)
    end

    it 'index' do
      expect(@ability.can? :index, Note).to be true
      expect(get :index, params: { user_id: user }).to render_template(:index)
      expect(assigns(:notes)).not_to be_empty
    end
  end

  [:user].each do |role|
    describe "user with #{role} role activities for unowner should" do
      login_user(role)

      it 'new' do
        expect(@ability.can? :new, Note).to be true
        expect(get :new).to render_template(:new)
      end

      it 'not create' do
        expect(@ability.can? :create, Note).to be true
        expect{ post :create, params: { note: attributes_for(:note, :with_preview) } }.to change(Note, :count).by(1)
      end

      it 'not edit' do
        expect(@ability.can? :edit, note).to be false
        expect{ get :edit, params: { id: note } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not update' do
        expect(@ability.can? :update, note).to be false
        expect{ put :update, params: {  id: note, note: attributes_for(:note) } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not destroy' do
        expect(@ability.cannot? :destroy, note).to be true
        expect{ delete :destroy, params: { id: note } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Note, :count).by(0)
      end

      it 'can index' do
        expect(@ability.can? :index, Note).to be true
      end

      it 'index empty if not shown list' do
        expect(Note.all).not_to be_empty
        expect(user.notes.where(hide: false)).to be_empty
        expect(get :index, params: { user_id: user }).to render_template(:index)
        expect(assigns(:notes)).to be_empty
      end

      it('index with not list if ')  {
        expect(Note.all).not_to be_empty
        expect(other_user.notes.where(hide: false)).not_to be_empty
        expect(@ability.can? :index, Note).to be true
        expect(get :index, params: {user_id: other_user}).to render_template(:index)
        expect(assigns(:notes)).not_to be_empty
      }
    end
  end

  describe 'for author' do
    before(:each) do
      sign_in(user)
      @ability = Ability.new(user)
    end

    it 'edit' do
      expect(@ability.can? :edit, note).to be true
      expect(get :edit, params: { id: note }).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, note).to be true
      put :update, params: { id: note, note: attributes_for(:note) }
      expect(response).to redirect_to(assigns(:note))
    end

    it 'destroy' do
      expect(@ability.can? :destroy, note).to be true
      expect{ delete :destroy, params: { id: note } }.to change(Note, :count).by(-1)
      expect(response).to redirect_to(Note)
    end


  end


  describe 'unreg user activities should' do
    it('index with empty list if hide notes')  {
      expect(Note.all).not_to be_empty
      expect(user.notes.where(hide: false)).to be_empty
      expect(get :index, params: {user_id: user} ).to render_template(:index)
      expect(assigns(:notes)).to be_empty
    }

    it('index with not list if ')  {
      expect(Note.all).not_to be_empty
      expect(Note.where(hide: false)).not_to be_empty
      expect(get :index, params: { user_id: user }).to render_template(:index)
      expect(assigns(:notes)).not_to be_empty
    }

    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).not_to be_nil
      end

      it('get new')  { get :new }
      it('create')   { expect{ post :create, params: {  note: attributes_for(:note) } }.to change(Note, :count).by(0) }
      it('get edit') { get :edit, params: { id: note } }
      it('update')   { put :update, params: { id: note, note: attributes_for(:note) } }
      it('destroy')  { expect{ delete :destroy, params: { id: note } }.to change(Note, :count).by(0) }
    end
  end
end
