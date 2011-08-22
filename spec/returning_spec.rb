require 'spec_helper'

describe Returning do
  before do
    Post.create :name => "hello", :author => "josh"
  end

  describe '#save' do
    let(:post) { Post.first }
    context 'when called with :returning => name' do
      subject do
        post.name = 'hello world'
        post.save(:returning => 'name')
      end

      its('name') { should == 'hello world' }
      it { should be_readonly }
    end

    context 'when nothing changed' do
      it 'returns self' do
        post.save(:returning => 'name').should eql(post)
      end
    end
  end

  describe '#destroy' do
    it 'returns the column passed to returning' do
      post = Post.first
      post.name = 'hello world'
      post.destroy(:returning => 'name').name.should == 'hello world'
    end
  end
end