module Trends
  class TrendAnalyzer
    @@stop_words = open(File.join("data", "stopwords.txt")).readlines.map(&:strip)

    def initialize
      @trend_dict = Hash.new(0)
    end

    def process(tweet)
      temp_arr = []
      arrs = preprocess(tweet)
      arrs.each do |wordset|
        ws_size = wordset.size
        wordset.each_with_index do |item, idx|
          idx.upto(ws_size-1) do |i|
            words = wordset[idx..i].join(" ")
            temp_arr << words
            #temp_hash[words] = true
          end
        end
      end
      temp_arr.uniq.each do |w|
        @trend_dict[w] += 1
      end
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

    private
    def reject(word)
       word[0] == '@' or @@stop_words.member?(word)
    end
  end
end

