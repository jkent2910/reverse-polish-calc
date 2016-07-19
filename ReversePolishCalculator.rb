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
        remove_elements_from_array(calculator_array, 1)
        numeric_array = calculator_array.map(&:to_i)

        until numeric_array.length == 2 do
          second_to_last_element = (numeric_array.length - 2)
          new_total = numeric_array.last - numeric_array[second_to_last_element]
          remove_elements_from_array(numeric_array, 2)
          numeric_array << new_total
        end

        new_total = numeric_array.last - numeric_array.first

        remove_elements_from_array(calculator_array, calculator_array.length)
        calculator_array << new_total
      elsif calculator_array.last == "*"
        remove_elements_from_array(calculator_array, 1)
        numeric_array = calculator_array.map(&:to_i)

        until numeric_array.length == 2 do
          second_to_last_element = (numeric_array.length - 2)
          new_total = numeric_array.last * numeric_array[second_to_last_element]
          remove_elements_from_array(numeric_array, 2)
          numeric_array << new_total
        end

        new_total = numeric_array.last * numeric_array.first
        remove_elements_from_array(calculator_array, calculator_array.length)

        calculator_array << new_total

      elsif calculator_array.last == "/"
        remove_elements_from_array(calculator_array, 1)
        numeric_array = calculator_array.map(&:to_i)

        until numeric_array.length == 2 do
          second_to_last_element = (numeric_array.length - 2)
          new_total = numeric_array.last.to_f / numeric_array[second_to_last_element].to_f
          remove_elements_from_array(numeric_array, 2)
          numeric_array << new_total
        end

        new_total = numeric_array.last.to_f / numeric_array.first.to_f
        remove_elements_from_array(calculator_array, calculator_array.length)

        calculator_array << new_total
      else
        raise ArgumentError, 'At least three elements are needed with an operator as the last element'
      end
  end
  
  def remove_elements_from_array(calculator_array, num_elements)
    calculator_array.pop(num_elements)
  end

end
