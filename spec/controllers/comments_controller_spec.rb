# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  login_user

  let(:user) { subject.current_user }
  let(:post) { create :post, user: user }
  let(:comment) { create :comment, post: post, user: user }
  let(:user1) { create :user }
  let(:post1) { create :post, user: user1 }
  let(:comment1) { create :comment, post: post1, user: user1 }

  context 'Methods' do
    context 'Create Comment' do
      it 'should create comment' do
        expect { create :comment }.to change(Comment, :count).by(1)
      end

      it 'should save created comment' do
        expect(comment).to be_persisted
      end

      it 'should not create empty comment' do
        expect { create(:comment, body: ' ') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'Edit Comment' do
      it 'should render edit page for valid comment' do
        get :edit, params: { post_id: post.id, id: comment.id }
        expect(response).to render_template('edit')
      end

      it 'should not render edit page for invalid comment' do
        get :edit, params: { post_id: post.id, id: 'no' }
        expect(response).to_not render_template('edit')
      end

      it 'should not render edit page for comment of another user' do
        get :edit, params: { post_id: post1.id, id: comment1.id }
        expect(response).to_not render_template('edit')
      end
    end

    context 'Update Comment' do
      it 'should update comment' do
        put :update, params: { post_id: post.id, id: comment.id, comment: { body: 'Updated comment!' } }
        expect(flash[:notice]).to be_present
      end

      it 'should not update post of another user' do
        put :update, params: { post_id: post1.id, id: comment1.id, comment: { body: 'Updated comment!' } }
        expect(flash[:alert]).to be_present
      end
    end

    context 'Delete Comment' do
      it 'should delete comment' do
        # delete :destroy, params: { post_id: post.id ,id: comment.id }
        delete :destroy, params: { post_id: post.id, id: comment.id }, format: :js
        response.should be_success
      end

      it 'should not delete post of another user' do
        delete :destroy, params: { post_id: post1.id, id: comment1.id }, format: :js
        response.should_not be_success
      end
    end
  end
end
