class WordValidator < ActiveModel::Validator
  def validate(word)
    binding.pry
    word.errors[:text] << 'Must be a valid word according to the dictionary' if word.text.eql? 'fail'
  end
end
