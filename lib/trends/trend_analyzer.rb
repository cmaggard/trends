module Trends
  class TrendAnalyzer
    @@stop_words = open(File.join("data", "stopwords.txt")).readlines.map(&:strip)

    def initialize
      @trend_dict = Hash.new(0)
    end

    # Split tweet into array of arrays, each one containing trendable words
    def preprocess(tweet)
      idx = 0
      arr = [[]]
      tweet.split.each do |word|
        if reject(word)
          idx = idx + 1
          arr[idx] = []
          next
        end
        arr[idx] << word.gsub(/[^a-zA-Z0-9#]/, '')
      end
      arr.reject &:empty?
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
    def reject(word)
       word[0] == '@' or @@stop_words.member?(word)
    end
  end
end

