module WordsHelper
  def last_points_given
    words = Word.order('created_at')
    return 'Never' if words.empty?
    "#{distance_of_time_in_words words.last.created_at, Time.zone.now} ago"
  end
end
