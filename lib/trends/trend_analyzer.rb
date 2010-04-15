module Trends
  class TrendAnalyzer
    @@stop_words = open(File.join("data", "stopwords.txt")).readlines.map(&:strip)

    def initialize
      @trend_dict = Hash.new(0)
    end

    def process(tweet)
      temp_hash = {}
      tweet.split.each do |w|
        res = add(w)
        temp_hash[res] = true unless res.nil?
      end
      temp_hash.keys.each do |k|
        @trend_dict[k] = @trend_dict[k] + 1
      end
    end

    private
    def add(word)
      return if word[0] == '@'
      w = word.gsub(/[^a-zA-Z0-9#]/, '')
      @@stop_words.member?(w) ? nil : w
      #@trend_dict[w] = @trend_dict[w] + 1
    end
  end
end

