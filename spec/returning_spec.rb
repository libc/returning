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

    context 'with query cache' do
      it 'works' do
        PostQueryCache.first.update_attributes :name => 'cached'
      end
    end

    context 'when validate => false specified' do
      it 'passes it further' do
        post = PostWithValidation.first
        post.name = 'validated name'
        post.author = nil
        post.save(:returning => "name", :validate => false).should be_true
      end
    end
  end

  describe '#destroy' do
    it 'returns the column passed to returning' do
      post = Post.first
      post.name = 'hello world'
      post.destroy(:returning => 'name').name.should == 'hello world'
    end

    context 'with query cache' do
      it 'works' do
        expect { PostQueryCache.first.destroy }.not_to raise_error
      end
    end
  end
end