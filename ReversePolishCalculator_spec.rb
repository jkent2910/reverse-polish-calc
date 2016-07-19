require './reversepolishcalculator'
require 'rspec'

RSpec.describe ReversePolishCalculator do

  let(:calculator) { ReversePolishCalculator.new }

  context "initialize" do
    context "when an initial array of numbers to evaluate is passed in" do
      it "should use the passed in array" do
        calculator_array = ['1', '2', '3', '4', '5']
        calculator = ReversePolishCalculator.new(calculator_array)
        expect(calculator.calculator_array.length).to eq(5)
      end
    end

    context "when no array is passed in" do
      it "should have an empty array" do
        expect(calculator.calculator_array.length).to eq(0)
      end
    end
  end

  context "add_number_or_operation" do
    it "should add a number to the calculator array" do
      calculator.add_number_or_operator('5')
      expect(calculator.calculator_array).to include('5')
    end

    it "does not allow characters" do
      calculator.add_number_or_operator('#')
      expect(calculator.calculator_array).not_to include('#')
    end

    it "does not allow decimals" do
      calculator.add_number_or_operator("5.2")
      expect(calculator.calculator_array).not_to include('5.2')
    end

    it "does not allow numbers with more than five digits" do
      calculator.add_number_or_operator("1000000")
      expect(calculator.calculator_array).not_to include('1000000')
    end

    context "it should know how to handle operators" do
      it "should allow +, -, % or / if the stack is greater than 2" do
        calculator.calculator_array = ['2', '3', '3']
        calculator.add_number_or_operator('+')
        expect(calculator.calculator_array).to include('+')
      end
    end

    context "calculator_array_length?" do
      it "should return false if array is less than or equal to 2" do
        expect(calculator.calculator_array_length?(calculator.calculator_array)).to be_falsey
      end

      it "should return true if array has at least 3 elements" do
        array = ['2', '3', '4']
        expect(calculator.calculator_array_length?(array)).to be_truthy
      end
    end

    context "last_element_operator?" do
      it "should return false if the last element is not an operator" do
        array = ['1']
        expect(calculator.last_element_operator?(array)).to be_falsey
      end

      it "should return true if array has at least 3 elements" do
        array = ['2', '3', '4', '+']
        expect(calculator.last_element_operator?(array)).to be_truthy
      end
    end

    context "perform_calculation" do
      context "the last element in the stack isn't an operator" do
        it "should raise an exception" do
          calculator_array = ['1', '2', '3', '4']
          calculator = ReversePolishCalculator.new(calculator_array)
          expect { calculator.perform_calculation(calculator.calculator_array)}.to raise_error(ArgumentError)
        end
      end

      context "there isn't more than three elements" do
        it "should raise an exception" do
          calculator_array = ['1', '+']
          calculator = ReversePolishCalculator.new(calculator_array)
          expect { calculator.perform_calculation(calculator.calculator_array)}.to raise_error(ArgumentError)
        end
      end

      context "the array is valid and the operator is a + sign" do
        it "should add the numbers and add the total as the last element of the stack" do
          calculator_array = ['1', '2', '3', '+']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.last).to eq(6)
        end

        it "should clear out the array except for the total" do
          calculator_array = ['1', '2', '3', '+']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.length).to eq(1)
        end
      end

      context "the array is valid and the operator is a - sign" do
        it "should subtract the numbers and add the total as the last element of the stack" do
          calculator_array = ['1', '2', '10', '-']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.last).to eq(7)
        end

        it "should clear out the array except for the total" do
          calculator_array = ['1', '2', '3', '-']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.length).to eq(1)
        end
      end

      context "the array is valid and the operator is a * sign" do
        it "should multiply the numbers and add the total as teh last element of the st ack" do
          calculator_array = ['1', '2', '10', '*']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.last).to eq(20)
        end

        it "should clear out the array except for the total" do
          calculator_array = ['1', '2', '3', '*']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.length).to eq(1)
        end
      end

      context "the array is valid and the operator is a / sign" do
        it "should divide the numbers and add the total as the last element of the st ack" do
          calculator_array = ['2', '10', '20', '/']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.last).to eq(1)
        end

        it "should clear out the array except for the total" do
          calculator_array = ['1', '2', '3', '/']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.length).to eq(1)
        end

        it "can will divide with precision" do
          calculator_array = ['5', '10', '20', '/']
          calculator = ReversePolishCalculator.new(calculator_array)
          calculator.perform_calculation(calculator.calculator_array)
          expect(calculator.calculator_array.last).to eq(0.4)
        end
      end

      context "something else goes wrong" do
        it "should raise an exception" do
            calculator_array = ['1', '2', '3', '^']
            calculator = ReversePolishCalculator.new(calculator_array)
            expect { calculator.perform_calculation(calculator.calculator_array)}.to raise_error(ArgumentError)
        end
      end

      context "no_other_operators" do
        it "should not allow more than one operator in the array" do
          calculator_array = ['1', '2', '3', '+', '-']
          calculator = ReversePolishCalculator.new(calculator_array)
          expect(calculator.no_other_operators?(calculator_array)).to be_falsey
        end
      end
    end
  end

end