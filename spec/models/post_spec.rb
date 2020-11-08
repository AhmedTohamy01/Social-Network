require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'post validation' do
    before do
      @user = FactoryBot.create(:user)
      @post = FactoryBot.create(:post, user: @user)
    end

    context 'with invalid attributes' do
      it 'should not be valid when user is nil' do
        @post.user = nil
        @post.save
        expect(@post).to_not be_valid
      end

      it 'should not be valid when there is no content' do
        @post.content = ' '
        @post.save
        expect(@post).to_not be_valid
      end
    end

    context 'with valid attributes' do
      it 'should not be valid when user is nil' do
        @post.content = 'Lorem ipsum dolor'
        @post.save
        expect(@post).to be_valid
      end
    end
  end
end
