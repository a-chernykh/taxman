require "rubygems"
require "bundler/setup"

class Taxman
	class <<self
		def tax(income)
			raise ArgumentError.new("income must be numeric") unless (Float(income) rescue false)
			raise ArgumentError.new("income must be positive") if income < 0

			tax = if income < 18201
				0
			elsif income < 37001
				(income - 18200) * 0.19
			elsif income < 80001
				3572 + (income - 37000) * 0.325
			elsif income < 180001
				17547 + (income - 80000) * 0.37
			else
				54547 + (income - 180000) * 0.45
			end

			tax += income.to_f * 0.015

			tax.to_f.round(3)
		end
	end
end