require 'rspec'

class Calculator

  attr_accessor :calculator_stack, :total
  attr_reader :first_number, :second_number

  def initialize(calculator_stack = [])
    @calculator_stack = calculator_stack
  end

  def enter_number_or_operator(input)
    if input.match('[.]')
      error_message("Sorry, we're not accepting decimals yet")
    elsif input.length > 5
      error_message("Please enter a number with less than 5 digits")
    elsif input.match('[^0-9\+\-\*\/\.]')
      error_message("Oops, it looks like you didn't enter a valid number or operator.  Please try again.")
    elsif input.match('[(\)\+\-\*\/\.]')
      if @calculator_stack.length <= 1
        error_message("Oops, you must have at least two numbers before you enter an operator.  Please try again.")
      else
        @calculator_stack << input
      end
    else
      @calculator_stack << input
    end
  end

  def check_size_of_calculator_stack(stack)
    if stack.length <= 2
      error_message("Need at least one more number before calculator can be done.")
    else
      perform_operation(stack)
    end
  end

  def perform_operation(stack)
    if stack.last.match('[(\)\+\-\*\/\.]')
      @operator = stack.last
      remove_operator_from_stack(stack)
      @get_last_two_stack_elements = stack.last(2).map(&:to_i)
      do_math(@get_last_two_stack_elements, @operator)
    else
      error_message("Hmmm, we weren't able to match your input to one of our operations.  Try entering a number or an operator again.")
    end
  end

  def do_math(last_two_elements, operator)
    if operator == "+"
      @total = 0
      last_two_elements.each do |int|
        @total += int
      end
      clean_up_stack(@total)
    elsif operator == "-"
      get_numbers_from_array(last_two_elements)
      @total = @first_number - @second_number
      clean_up_stack(@total)
    elsif operator == "*"
      get_numbers_from_array(last_two_elements)
      @total = @first_number * @second_number
      clean_up_stack(@total)
    elsif operator == "/"
      get_numbers_from_array(last_two_elements)
      @total = @first_number.to_f / @second_number.to_f
      clean_up_stack(@total)
    else
      error_message("You didn't enter a valid operator")
    end
  end

  def remove_operator_from_stack(stack)
    stack.pop
  end

  def error_message(string)
    puts string
  end

  def get_numbers_from_array(last_two_elements)
    @second_number = last_two_elements.last
    @first_number = last_two_elements.first
  end

  def remove_last_two_elements_from_stack(stack)
    stack.pop(2)
  end

  def add_new_total_to_stack(total)
    @calculator_stack << total
  end

  def print_results(total)
    p "Total of your operation was #{total}"
    p "Stack now: #{@calculator_stack}"
  end

  def clean_up_stack(total)
    remove_last_two_elements_from_stack(@calculator_stack)
    add_new_total_to_stack(total)
    print_results(total)
  end

end