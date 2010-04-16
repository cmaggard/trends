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
      assert_equal Hash.new, @trend.trend_dict
    end

    context "when preprocessing" do# {{{
      should "split on @ replies into separate arrays" do
        res = @trend.preprocess("durb @cmaggard twerp")
        assert_same_elements [['durb'], ['twerp']], res
      end

      should "split on stop words" do
        res = @trend.preprocess("durb likely to twerp")
        assert_same_elements [['durb'], ['twerp']], res
      end

      should "ignore punctuation" do
        res = @trend.preprocess("derp,")
        assert_equal [['derp']], res
      end

      should "only contain 'derp' for a tweet that says 'derp'" do
        res = @trend.preprocess("derp")
        assert_equal [['derp']], res
      end
    end# }}}

    context "when processing" do
      should "not count a word more than once in the same tweet" do
        @trend.process("derp derp a derp derp derp")
        assert_equal 1, @trend.trend_dict['derp']
      end
      
      should "account for all different ordered combinations of terms" do
        @trend.process("goodbye world")
        assert_same_elements ['goodbye', 'world', 'goodbye world'], @trend.trend_dict.keys 
      end
    end

  end
end
