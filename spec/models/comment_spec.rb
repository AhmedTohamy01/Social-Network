require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user1)
  end

  describe 'comment validation' do
    before do
      @comment = Comment.new(user_id: @user1.id, post_id: @post.id)
      @comment.save
    end

    context 'with invalid attributes' do
      it 'should be invalid without a content' do
        expect(@comment).to_not be_valid
      end

      it 'should be invalid without a user' do
        @comment.content = 'Lorem ipsum dolor'
        @comment.user = nil
        @comment.save
        expect(@comment).to_not be_valid
      end

      it 'should be invalid without a post' do
        @comment.content = 'Lorem ipsum dolor'
        @comment.post = nil
        @comment.save
        expect(@comment).to_not be_valid
      end
    end

    context 'with valid attributes' do
      it 'should be valid' do
        @comment.content = 'Lorem ipsum dolor'
        @comment.save
        expect(@comment).to be_valid
      end

      it 'should increment comment count by 1' do
        @comment.content = 'Lorem ipsum dolor'

        expect { @comment.save }.to change { Comment.count }.by(1)
      end
    end

    describe 'with user/post associations' do
      before do
        @comment = @user2.comments.build(post_id: @post.id, content: 'Lorem ipsum dolor')
        @comment.save
      end

      it 'should be valid' do
        expect(@comment).to be_valid
      end

      it 'should destroy comment when the associated user is deleted' do
        expect { User.find(@user2.id).destroy }.to change { Comment.count }.by(-1)
      end

      it 'should destroy comment when the associated post is deleted' do
        expect { Post.find(@post.id).destroy }.to change { Comment.count }.by(-1)
      end
    end
  end
end
