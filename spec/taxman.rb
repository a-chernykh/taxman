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
			Taxman.tax(18201).must_equal 273.205
			Taxman.tax(20000).must_equal 642
			Taxman.tax(37000).must_equal 4127
		end

		it "should properly calculate taxes for $37,001-$80,000 income" do
			Taxman.tax(37001).must_equal 4127.34
			Taxman.tax(50000).must_equal 8547
			Taxman.tax(80000).must_equal 18747
		end

		it "should properly calculate taxes for $80,001-$180,000 income" do
			Taxman.tax(80001).must_equal 18747.385
			Taxman.tax(100000).must_equal 26447
			Taxman.tax(180000).must_equal 57247
		end

		it "should properly calculate taxes for $180,001 and over income" do
			Taxman.tax(1800001).must_equal 810547.465
			Taxman.tax(2000000).must_equal 903547.0
		end
	end

	describe 'client parsing' do
		it 'should raise an error if name is missing' do
			lambda { Taxman.parse('John Smith') }.must_raise Exception
		end

		it 'should parse client and return name and income' do
			Taxman.parse('John Smith, 15000').must_equal ['John Smith', 15000]
		end
	end

	describe 'process client' do
		it 'should return how much taxex client should pay and how many money client will have after tax' do
			Taxman.process('John Smith, 15000').must_equal 'John Smith, 0, 15000'
			Taxman.process('John Doe, 20000').must_equal 'John Doe, 642, 19358'
			Taxman.process('Joe Doe, 200000').must_equal 'Joe Doe, 66547, 133453'
		end
	end
end