require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'with validations' do
    before do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, user: @user1)
      @comment = @user2.comments.build(post_id: @post.id, content: 'Lorem ipsum dolor')
      @comment.save
    end

    context 'liking a post with invalid attributes' do
      before do
        @like = Like.new
      end

      it 'should be invalid without a any attribute' do
        @like.save
        expect(@like).to_not be_valid
      end

      it 'should be invalid without a post' do
        @like.post = @post
        @like.save
        expect(@like).to_not be_valid
      end

      it 'should be invalid without a user' do
        @like.user = @user2
        @like.save
        expect(@like).to_not be_valid
      end
    end

    context 'liking a post with valid attributes' do
      before do
        @like = Like.new
        @like.user = @user2
        @like.post = @post
      end

      it 'should be valid with all attributes provided and all valid' do
        @like.save
        expect(@like).to be_valid
      end

      it 'should increment like count by 1' do
        expect { @like.save }.to change { Like.count }.by(1)
      end
    end

    describe 'with user/post associations' do
      before do
        @like = @user2.likes.build(post_id: @post.id)
        @like.save
      end

      it 'should be valid' do
        expect(@like).to be_valid
      end

      it 'should destroy like when the associated user is deleted' do
        expect { User.find(@user2.id).destroy }.to change { Like.count }.by(-1)
      end

      it 'should destroy like when the associated post is deleted' do
        expect { Post.find(@post.id).destroy }.to change { Like.count }.by(-1)
      end
    end
  end
end
