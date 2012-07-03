require "rubygems"
require "bundler/setup"
require "minitest/autorun"

require_relative "../lib/taxman"

describe Taxman do
	describe "tax calculation" do
		it "should only accept numeric values" do
			lambda { Taxman.tax('blablabla') }.must_raise ArgumentError
		end

		it "should raise an error if income non-positive value" do
			lambda { Taxman.tax(-1) }.must_raise ArgumentError
		end

		it "should properly calculate taxes for $0-18,200 income" do
			Taxman.tax(0).must_equal 0
			Taxman.tax(10000).must_equal 0
			Taxman.tax(18200).must_equal 0
		end
		
		it "should properly calculate taxes for $18,201-$37,000 income" do
			Taxman.tax(18201).must_equal 0.19
			Taxman.tax(20000).must_equal 342
			Taxman.tax(37000).must_equal 3572
		end

		it "should properly calculate taxes for $37,001-$80,000 income" do
			Taxman.tax(37001).must_equal 3572.325
			Taxman.tax(50000).must_equal 7797
			Taxman.tax(80000).must_equal 17547
		end

		it "should properly calculate taxes for $80,001-$180,000 income" do
			Taxman.tax(80001).must_equal 17547.37
			Taxman.tax(100000).must_equal 24947.0
			Taxman.tax(180000).must_equal 54547.0
		end

		it "should properly calculate taxes for $180,001 and over income" do
			Taxman.tax(1800001).must_equal 783547.45
			Taxman.tax(2000000).must_equal 873547
		end
	end
end