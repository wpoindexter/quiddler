module WordVerificationsHelper
  def last_word_verification
    word_verifications = WordVerification.where(valid_word: true).order('created_at')
    return 'Never' if word_verifications.empty?
    "#{distance_of_time_in_words word_verifications.last.created_at, Time.zone.now} ago"
  end
end
