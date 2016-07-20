require 'rspec'

class ReversePolishCalculator

  attr_accessor :calculator_array

  def initialize(calculator_array = [])
    @calculator_array = calculator_array
  end

  def add_number_or_operator(num_or_op)
    if num_or_op.match('[(\)\+\-\*\/\.]') && calculator_array_length?(@calculator_array) && no_other_operators?(@calculator_array)
      @calculator_array << num_or_op
    end

    unless num_or_op.match('[^0-9.]') ||  num_or_op.match('[.]') || num_or_op.length > 5
      @calculator_array << num_or_op
    end
  end

  def calculator_array_length?(calculator_array)
    calculator_array.length >= 3
  end

  def no_other_operators?(calculator_array)
    true unless calculator_array.any? { |x| ['+', '-', '*', '/'].include?(x)}
  end

  def last_element_operator?(calculator_array)
    calculator_array.last.match('[(\)\+\-\*\/\.]')
  end

  def perform_calculation(calculator_array)
    raise ArgumentError, 'At least three elements are needed with an operator as the last element' unless calculator_array_length?(calculator_array) && last_element_operator?(calculator_array)
      if calculator_array.last == "+"
        remove_elements_from_array(calculator_array, 1)
        total = 0
        calculator_array.map(&:to_i).each do |int|
          total += int
        end
        remove_elements_from_array(calculator_array, calculator_array.length)
        calculator_array << total
      elsif calculator_array.last == "-"
        do_math(calculator_array, "-")
      elsif calculator_array.last == "*"
        do_math(calculator_array, "*")
      elsif calculator_array.last == "/"
        do_math(calculator_array, "/")
      else
        raise ArgumentError, 'At least three elements are needed with an operator as the last element'
      end
  end

  def do_math(array, operator)
    remove_elements_from_array(array, 1)
    numeric_array = calculator_array.map(&:to_i)

    until numeric_array.length == 2 do
      second_to_last_element = (numeric_array.length - 2)
      new_total = numeric_array.last.to_f.send(operator, numeric_array[second_to_last_element].to_f)
      remove_elements_from_array(numeric_array, 2)
      numeric_array << new_total
    end

    new_total = numeric_array.last.to_f.send(operator, numeric_array.first.to_f)

    remove_elements_from_array(array, array.length)
    array << new_total
  end
  
  def remove_elements_from_array(calculator_array, num_elements)
    calculator_array.pop(num_elements)
  end

end

def q
  exit
end


if __FILE__ == $PROGRAM_NAME
  puts "Hello!  Thanks for checking out my RPN Calculator.  To give you an idea of how it works, I'm going to walk you through an example."
  calculator = ReversePolishCalculator.new
  puts "I am going to add the numbers 5, 10, and 15 to my calculator stack which is currently empty: #{calculator.calculator_array}"
  calculator.add_number_or_operator("5")
  calculator.add_number_or_operator("10")
  calculator.add_number_or_operator("15")
  puts "Now my calculator stack is: #{calculator.calculator_array}"
  puts "Now I am going to add the '+' operator."
  calculator.add_number_or_operator("+")
  puts "See?  Check out my calculator stack now: #{calculator.calculator_array}"
  puts "Alright, now to do some math... RPN style!  I'm going to call the perform calculation method which should return 30"
  p calculator.perform_calculation(calculator.calculator_array)
  puts "COOL!  Let's add '10' and '15' to the stack......."
  calculator.add_number_or_operator('10')
  calculator.add_number_or_operator('15')
  puts "Calculator stack is now: #{calculator.calculator_array}"
  puts "Let's do some multiplication!  I'm going to add the '*' sign to the stack and then call perform_calculation again."
  calculator.add_number_or_operator('*')
  puts "We've got the '*' in there now!  Going to call the perform_calculation method now, cross your fingers that the output is 4,500."
  p calculator.perform_calculation(calculator.calculator_array)
  puts "Oh yeah!  Ready to give it a go yourself?  Start up an IRB session and have some fun!"
end
