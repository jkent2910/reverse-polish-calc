require 'rspec'
require 'stringio'
require './ui'

class PolishCalculator
  attr_accessor :ui
  attr_reader :output, :user_input

  def initialize
    @calculator_stack = []
    @ui = UI.new
  end

  def start_calculator
    @ui.give("Welcome to Julie's Reverse Polish Calculator!  Type 'c' to continue or 'q' to exit.")
    user_input = @ui.receive
    if user_input == 'c'
      enter_number_or_operation
    elsif user_input == 'q'
      exit
    else
      @ui.give("Sorry, I didn't get that.  Type 'c' to continue or 'q' to exit.")
    end
  end

  def enter_number_or_operation
    @ui.give("Please enter a number with no more than 5 digits or an operator (+ - / or *).  Press 'q' to exit.")
    user_input = @ui.receive
    if user_input == 'q'
      exit
    else
      check_length_and_characters(user_input)
    end
  end

  def check_length_and_characters(user_input)
    if user_input.length > 5
      @ui.give("You entered more than five digits.  Please enter less than five digits")
      enter_number_or_operation
    elsif user_input.match('[^0-9\+\-\*\/\.]')
      @ui.give("Oops, it looks like you didn't enter a valid number or operator.  Please try again.")
      enter_number_or_operation
    elsif user_input.match('[(\)\+\-\*\/\.]')
      if @calculator_stack.length <= 1
        @ui.give("Oops, you must have at least two numbers before you enter an operator.  Please try again.")
        remove_operator_from_stack
        enter_number_or_operation
      else
        @calculator_stack << user_input
        check_size_of_calculator_stack
      end
    else
      @calculator_stack << user_input
      check_size_of_calculator_stack
    end
  end

  def check_size_of_calculator_stack
    if @calculator_stack.length <= 2
      enter_number_or_operation
    else
      perform_calculation
    end
  end

  def perform_calculation
    if @calculator_stack.last.match('[(\)\+\-\*\/\.]')
      @operator = @calculator_stack.last
      remove_operator_from_stack
      @get_last_two_stack_elements = @calculator_stack.last(2).map(&:to_i)
      do_math(@get_last_two_stack_elements, @operator)
    else
      enter_number_or_operation
    end
  end

  def remove_operator_from_stack
    @calculator_stack.pop
  end

  def remove_last_two_elements_from_stack
    @calculator_stack.pop(2)
  end

  def add_new_total_to_stack(total)
    @calculator_stack << total
  end

  def print_results(total)
    p "Total of your operation was #{total}"
    p "Stack now: #{@calculator_stack}"
  end

  def clean_up_stack(total)
    remove_last_two_elements_from_stack
    add_new_total_to_stack(total)
    print_results(total)
  end

  def get_numbers_from_array(last_two_elements)
    @second_number = last_two_elements.last
    @first_number = last_two_elements.first
  end

  def do_math(last_two_elements, operator)
    if operator == "+"
      total = 0
      last_two_elements.each do |int|
        total += int
      end
      clean_up_stack(total)
      enter_number_or_operation
    elsif operator == "-"
      get_numbers_from_array(last_two_elements)
      total = @first_number - @second_number
      clean_up_stack(total)
      enter_number_or_operation
    elsif operator == "*"
      get_numbers_from_array(last_two_elements)
      total = @first_number * @second_number
      clean_up_stack(total)
      enter_number_or_operation
    elsif operator == "/"
      get_numbers_from_array(last_two_elements)
      total = @first_number.to_f / @second_number.to_f
      clean_up_stack(total)
      enter_number_or_operation
    else
      @ui.give("You didn't enter a valid operator")
      enter_number_or_operation
    end
  end

end

RSpec.describe PolishCalculator do

  describe "start_calculator" do
    context 'when user inputs c' do
      it 'should move onto the enter_number_or_operation method' do
      end

    end
  end
end

