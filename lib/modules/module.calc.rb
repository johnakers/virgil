module Calc

  # input is a string "1 + 1"
  # see Dentaku docs for more info
  def self.ulate(args)
    calculator = Dentaku::Calculator.new
    calculator.evaluate(args)
  end

end