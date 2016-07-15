require './polishcalculator'
require './ui'
require 'rspec'

RSpec.describe PolishCalculator do

  describe "check_length_and_characters" do

    before(:each) do
      @calculator = PolishCalculator.new
      @ui = UI.new
    end

    context 'when user inputs more than five digits' do
      it 'should show the appropriate message if length is greater than 5' do
        # Pending
      end

      it 'should call the enter_number_or_operation method' do
        @input = StringIO.new("123456")
        @user_input = @ui.receive(input: @input)
        expect(@calculator).to receive(:enter_number_or_operation)
        @calculator.check_length_and_characters(@user_input)
      end
    end

    context "when user doesn't enter a valid number or operator" do
      it 'should show the appropriate message if invalid number or operator' do
        # Pending
      end

      it 'should call the enter_number_or_operation method' do
        @input = StringIO.new("abc")
        @user_input = @ui.receive(input: @input)
        expect(@calculator).to receive(:enter_number_or_operation)
        @calculator.check_length_and_characters(@user_input)
      end
    end

    context "when the user enters a valid operator but stack is less than or equal to 1" do
      it 'should call remove_operator_from_stack' do
        # Pending
      end

      it 'should call the enter_number_or_operation' do
        @input = StringIO.new("+")
        @calculator_stack = ['1']
        @user_input = @ui.receive(input: @input)
        expect(@calculator).to receive(:enter_number_or_operation)
        @calculator.check_length_and_characters(@user_input)
      end
    end

    context "when the user enters a valid number and the stack is greather than 1" do
      it 'should add the users input to the stack' do
        # Pending
      end

      it 'should call the check_size_of_calculator_stack method' do
        @input = StringIO.new("4")
        @calculator_stack = ['1', '2', '3']
        @user_input = @ui.receive(input: @input)
        expect(@calculator).to receive(:check_size_of_calculator_stack)
        @calculator.check_length_and_characters(@user_input)
      end
    end
  end

  describe "check_size_of_calculator_stack" do

    before(:each) do
      @calculator = PolishCalculator.new
      @ui = UI.new
    end

    context "when the stack is less than or equal to two" do
      it 'should call the enter_number_or_operation method' do
        @calculator_stack = ['1']
        @input = StringIO.new("123456")
        @user_input = @ui.receive(input: @input)
        expect(@calculator).to receive(:enter_number_or_operation)
        @calculator.check_size_of_calculator_stack
      end
    end
    context "when the stack is greater than two" do
      it 'should call the perform_calculation method' do
        # Pending
      end
    end
  end

  describe "perform_calculation" do

    context "when a number is entered" do
      it "should call the enter_number_or_operation method" do
         # Pending
      end
    end

    context "when an operator is entered" do
      it "should call the remove_operator_from_stack method" do
        # Pending
      end

      it "should call the do_math method with the last two elements and operator" do
        # Pending
      end
    end
  end

  describe "remove_operator_from_stack" do
    it "should remove the last element from the calculator stack" do
      # Pending
    end
  end

  describe "remove_last_two_elements_from_stack" do
    it "should remove the last two elements from the calculator stack" do
      # Pending
    end
  end

  describe "add_new_total_to_stack" do
    it "should add the total from the last operation to the stack" do
      # Pending
    end
  end

  describe "print_results" do
    it "should print the total of the last operation and the updated stack to the console" do

    end
  end

  describe "clean_up_stack" do
    it "should call the remove_last_two_elements_from_stack method" do

    end

    it "should call the add_new_total_to_stack method" do

    end

    it "should call the print_results method" do

    end
  end

  describe "get_numbers_from_array" do
    it "should create an instance variable @second_number with the last element from the array" do

    end

    it "should create an instance variable @first_number with the last element from the array" do

    end
  end

  describe "do_math" do
    context "when the user enters a plus sign" do
      it "should add the two numbers together" do

      end

      it "should call the clean_up_stack method" do

      end
      it "should call the enter_number_or_operation method" do

      end
    end

    context "when the user enters a minus" do
      it "should subtract the numbers" do

      end
      it "should call the clean_up_stack method" do

      end
      it "should call the enter_number_or_operation method" do

      end
    end

    context "when the user enters a *" do
      it "should multiply the numbers" do

      end
      it "should call the clean_up_stack method" do

      end
      it "should call the enter_number_or_operation method" do

      end
    end

    context "when the user enters a /" do
      it "should divide the numbers" do

      end
      it "should call the clean_up_stack method" do

      end
      it "should call the enter_number_or_operation method" do

      end
    end

    context "when the user doesnt enter a valid operator" do
      it "should call the enter_number_or_operation method" do

      end
    end
  end

end
