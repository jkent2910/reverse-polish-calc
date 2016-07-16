require './Calculator.rb'
require './ui'
require 'rspec'

RSpec.describe Calculator do

  before(:each) do
    @calculator = Calculator.new
  end

  describe "initialize" do
    it "should start with an empty array" do
      @calculator = Calculator.new
      expect(@calculator.calculator_stack).to be_empty
    end
  end

  describe "enter_number_or_operator" do

    it "should accept string numbers" do
      @calculator.enter_number_or_operator("1")
      expect(@calculator.calculator_stack.length).to eq(1)
    end

    it "should not accept number strings greater than 5" do
      @calculator.enter_number_or_operator("123456")
      expect(@calculator.calculator_stack.length).to eq(0)
    end

    it "should not accept decimals" do
      @calculator.enter_number_or_operator("5.2")
      expect(@calculator.calculator_stack.length).to eq(0)
    end

    it "should not accept characters" do
      @calculator.enter_number_or_operator("a")
      expect(@calculator.calculator_stack.length).to eq(0)
    end

    it "should ensure there are at least two numbers in the stack before an operation can be added" do
      @calculator.calculator_stack = ['1']
      @calculator.enter_number_or_operator("+")
      expect(@calculator.calculator_stack.length).to eq(1)
    end

    it "should allow an operator if the stack has at least two numbers in it" do
      @calculator.calculator_stack = ['1', '2', '3']
      @calculator.enter_number_or_operator("+")
      expect(@calculator.calculator_stack.length).to eq(4)
    end
  end

  describe "check_size_of_calculator_stack" do

    it "should respond to error_message if the stack is less than or equal to 2" do
      stack = @calculator.calculator_stack = ['1']
      expect(@calculator).to respond_to(:error_message)
      @calculator.check_size_of_calculator_stack(stack)
    end

    it "should respond to perform operation if the stack is greater than 2" do
      stack = @calculator.calculator_stack = ['1', '2', '3']
      expect(@calculator).to respond_to(:perform_operation)
      @calculator.check_size_of_calculator_stack(stack)
    end
  end

  describe "perform_operation" do

    it "should send the operator & the last two stack elements to the do_math method" do
      stack = @calculator.calculator_stack = ['3', '4', '+']
      expect(@calculator).to receive(:do_math).with([3, 4], '+')
      @calculator.perform_operation(stack)
    end

    it "should call the error message method if the operator was not recognized" do
      stack = @calculator.calculator_stack = ['1', '2', '^']
      expect(@calculator).to respond_to(:error_message)
      @calculator.perform_operation(stack)
    end

  end

  describe "remove_operator_from_stack" do

    it "should remove the operator from the stack" do
      stack = @calculator.calculator_stack = ['1', '2', '+']
      @calculator.remove_operator_from_stack(stack)
      expect(@calculator.calculator_stack).not_to include('+')
    end

  end

  describe "remove_last_two_elements_from_stack" do

    it "should remove the last two elements from the stack" do
      stack = @calculator.calculator_stack = ['1', '2', '+']
      @calculator.remove_last_two_elements_from_stack(stack)
      expect(@calculator.calculator_stack.length).to eq(1)
    end

  end

  describe "get_numbers_from_array" do

    it "should assign instance variables to the two elements in the array" do
      @calculator.get_numbers_from_array([1, 2])
      expect(@calculator.first_number).to eq(1)
      expect(@calculator.second_number).to eq(2)
    end
  end

  describe "do_math" do

    it "should add two numbers if operator is plus sign" do
      @calculator.do_math([1, 2], '+')
      expect(@calculator.total).to eq(3)
    end

    it "should subtract two numbers if operator is minus sign" do
      @calculator.do_math([10, 5], '-')
      expect(@calculator.total).to eq(5)
    end

    it "should multiply two numbers if operator is * sign" do
      @calculator.do_math([5, 2], '*')
      expect(@calculator.total).to eq(10)
    end

    it "should divide two numbers if operator is / sign" do
      @calculator.do_math([10, 2], '/')
      expect(@calculator.total).to eq(5)
    end

    it "should puts an error message if operator doesn't match + - * or /" do
      @calculator.do_math([11, 2], '$')
      expect(@calculator).to respond_to(:error_message)
    end
  end

end