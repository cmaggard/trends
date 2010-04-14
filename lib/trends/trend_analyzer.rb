module Trends
  class TrendAnalyzer
    attr_accessor :trend_dict
    def initialize
      @trend_dict = Hash.new(0)
    end

    def add(tweet)
      @trend_dict[tweet] = @trend_dict[tweet] + 1
    end

  end
end

