# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  login_user

  let(:user) { subject.current_user }
  let(:post) { create :post, user: user }
  let(:user1) { create :user }
  let(:post1) { create :post, user: user1 }

  context 'Methods' do
    context 'Create Post' do
      it 'should create post' do
        expect { create :post }.to change(Post, :count).by(1)
      end

      it 'should save created post' do
        expect(post).to be_persisted
      end
    end

    context 'Edit Post' do
      it 'should render edit page for valid post' do
        get :edit, params: { id: post.id }
        expect(response).to render_template('edit')
      end

      it 'should not render edit page for invalid post' do
        get :edit, params: { id: '0' }
        expect(response).to_not render_template('edit')
      end

      it 'should not render edit page for post of another user' do
        get :edit, params: { id: post1.id }
        expect(response).to_not render_template('edit')
      end
    end

    context 'Update Post' do
      it 'should update post' do
        put :update, params: { id: post.id, post: { content: 'Updated content!' } }
        expect(flash[:notice]).to be_present
      end

      it 'should not update post of another user' do
        put :update, params: { id: post1.id, post: { content: 'Updated content!' } }
        expect(flash[:alert]).to be_present
      end
    end

    context 'Show Post' do
      it 'should show post' do
        put :show, params: { id: post.id }
        expect(response).to render_template('show')
      end
    end

    context 'Delete Post' do
      it 'should delete post' do
        delete :destroy, params: { id: post.id }
        expect(flash[:notice]).to be_present
      end

      it 'should not delete post of another user' do
        delete :destroy, params: { id: post1.id }
        expect(flash[:alert]).to be_present
      end
    end
  end
end
