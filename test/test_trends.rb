require 'helper'

module Trends
  class TrendAnalyzer
    attr_accessor :trend_dict
  end
end

class TestTrends < Test::Unit::TestCase
  context "A Trend" do
    setup do
      @trend = Trends::TrendAnalyzer.new
    end

    should "start empty" do
      assert_empty @trend.trend_dict
    end

    context "when processing" do
      should "only contain 'derp' for a tweet that says 'derp'" do
        @trend.process("derp")
        assert_equal ['derp'], @trend.trend_dict.keys
      end
      
      should "ignore @ replies" do
        @trend.process("@cmaggard derp")
        assert_equal ['derp'], @trend.trend_dict.keys
      end

      should "ignore punctuation" do
        @trend.process("derp,")
        assert_equal ['derp'], @trend.trend_dict.keys
      end

      should "not count a word more than once in the same tweet" do
        @trend.process("derp derp a derp derp derp")
        assert_equal 1, @trend.trend_dict['derp']
      end
    end

  end
end
