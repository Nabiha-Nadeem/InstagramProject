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
        expect(response).to have_http_status(200)
      end

      it 'should not create post without images' do
        put :create, params: { id: post.id, post: { content: 'New post!' } }
        expect(flash[:alert]).to eql('Please add images (at max 10)!')
        expect(response).to have_http_status(302)
      end

      it 'should not create post without user_id' do
        expect { create(:post, user_id: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'Edit Post' do
      it 'should render edit page for valid post' do
        get :edit, params: { id: post.id }
        expect(response).to render_template('edit')
        expect(response).to have_http_status(200)
      end

      it 'should not render edit page when post id not found' do
        get :edit, params: { id: '0' }
        expect(response).to_not render_template('edit')
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not render edit page for post of another user' do
        get :edit, params: { id: post1.id }
        expect(response).to_not render_template('edit')
        expect(flash[:alert]).to eql('Not authorized to perform this action!')
        expect(response).to have_http_status(302)
      end
    end

    context 'Update Post' do
      it 'should update post' do
        put :update, params: { id: post.id, post: { content: 'Updated content!' } }
        expect(flash[:notice]).to eql('Post updated!')
        expect(response).to have_http_status(302)
      end

      it 'should not update post when post id not found' do
        put :update, params: { id: 'no', post: { content: 'Updated content!' } }
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not update post of another user' do
        put :update, params: { id: post1.id, post: { content: 'Updated content!' } }
        expect(flash[:alert]).to eql('Not authorized to perform this action!')
        expect(response).to have_http_status(302)
      end
    end

    context 'Show Post' do
      it 'should show post' do
        put :show, params: { id: post.id }
        expect(response).to render_template('show')
        expect(response).to have_http_status(200)
      end

      it 'should not show post when post id not found' do
        put :show, params: { id: 'no' }
        expect(response).to_not render_template('show')
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end
    end

    context 'Delete Post' do
      it 'should delete post' do
        delete :destroy, params: { id: post.id }
        expect(flash[:notice]).to eql('Post deleted!')
        expect(response).to have_http_status(302)
      end

      it 'should not delete post when post id not found' do
        delete :destroy, params: { id: 'no' }
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not delete post of another user' do
        delete :destroy, params: { id: post1.id }
        expect(flash[:alert]).to eql('Not authorized to perform this action!')
        expect(response).to have_http_status(302)
      end
    end
  end
end
