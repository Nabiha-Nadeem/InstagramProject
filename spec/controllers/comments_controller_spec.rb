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
        expect(response).to have_http_status(200)
      end

      it 'should alert for comment with empty body' do
        put :create, params: { post_id: post.id, id: comment.id, comment: { body: ' ' } }
        expect(flash[:alert]).to eql('Cannot add empty comment!')
        expect(response).to have_http_status(302)
      end

      it 'should not create comment without body' do
        expect { create(:comment, body: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should not create comment without post_id' do
        expect { create(:comment, post_id: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should not create comment without user_id' do
        expect { create(:comment, user_id: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'Edit Comment' do
      it 'should render edit page for valid comment' do
        get :edit, params: { post_id: post.id, id: comment.id }
        expect(response).to render_template('edit')
        expect(response).to have_http_status(200)
      end

      it 'should not render edit page for comment when comment id not found' do
        get :edit, params: { post_id: post.id, id: 'no' }
        expect(response).to_not render_template('edit')
        expect(flash[:alert]).to eql('Comment not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not render edit page for comment when post id not found' do
        get :edit, params: { post_id: 'no', id: comment.id }
        expect(response).to_not render_template('edit')
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not render edit page for comment of another user' do
        get :edit, params: { post_id: post1.id, id: comment1.id }
        expect(response).to_not render_template('edit')
        expect(flash[:alert]).to eql('Not authorized to perform this action!')
        expect(response).to have_http_status(302)
      end
    end

    context 'Update Comment' do
      it 'should update valid comment' do
        put :update, params: { post_id: post.id, id: comment.id, comment: { body: 'Updated comment!' } }
        expect(flash[:notice]).to eql('Comment updated!')
        expect(response).to have_http_status(302)
      end

      it 'should not update comment when comment is empty' do
        get :update, params: { post_id: post.id, id: comment.id, comment: { body: ' ' } }
        expect(flash[:alert]).to eql('Error occurred while updating the comment!')
        expect(response).to have_http_status(302)
      end

      it 'should not update comment when comment id not found' do
        get :update, params: { post_id: post.id, id: 'no', comment: { body: 'Updated comment!' } }
        expect(flash[:alert]).to eql('Comment not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not update comment when post id not found' do
        get :update, params: { post_id: 'no', id: comment.id, comment: { body: 'Updated comment!' } }
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not update post of another user' do
        put :update, params: { post_id: post1.id, id: comment1.id, comment: { body: 'Updated comment!' } }
        expect(flash[:alert]).to eql('Not authorized to perform this action!')
        expect(response).to have_http_status(302)
      end
    end

    context 'Delete Comment' do
      it 'should delete comment' do
        delete :destroy, params: { post_id: post.id, id: comment.id }, format: :js
        response.should be_success
        expect(response).to have_http_status(200)
      end

      it 'should not delete comment when comment id not found' do
        delete :destroy, params: { post_id: post.id, id: 'no' }, format: :js
        response.should_not be_success
        expect(flash[:alert]).to eql('Comment not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not delete comment when post id not found' do
        delete :destroy, params: { post_id: 'no', id: comment.id }, format: :js
        response.should_not be_success
        expect(flash[:alert]).to eql('Post not found!')
        expect(response).to have_http_status(302)
      end

      it 'should not delete comment of another user' do
        delete :destroy, params: { post_id: post1.id, id: comment1.id }, format: :js
        response.should_not be_success
        expect(flash[:alert]).to eql('Not authorized to perform this action!')
        expect(response).to have_http_status(302)
      end
    end
  end
end
