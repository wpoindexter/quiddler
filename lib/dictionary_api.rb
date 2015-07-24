class DictionaryApi
  def self.word_exists?(word)
    Rails.logger.debug word
    !word.eql? 'fail'
  end
end
