require 'rails_helper'

describe Comment, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      comment = Comment.new

      comment.valid?

      expect(comment.errors[:body]).to include('não pode ficar em branco')
    end
  end
end
  
