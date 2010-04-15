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

    context "and its trend terms" do
      should "start empty" do
        assert_empty @trend.trend_dict
      end

      should "only contain 'derp' for a tweet that says 'derp'" do
        @trend.add("derp")
        assert_equal ['derp'], @trend.trend_dict.keys
      end
    end
  end
end
