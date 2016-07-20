# Reverse Reverse Polish Calculator
## Description: 
This simple command line calculator will prompt a user to enter numbers (up to 5 digits) and one of four operators (+, -, *, %) to perform Reverse Polish calculations.  If you'd like to learn more about how Reverse Polish calculators work, please see the Wikipedia page: https://en.wikipedia.org/wiki/Reverse_Polish_notation. 

## To Run Interactive Version: 
Simply start an IRB session from your terminal and create a new ReversePolishCalculator instance (for ex: r = ReversePolishCalculator.new)
Add numbers to your stack by calling the add_number_or_operator method on your instance (for ex: r.add_number_or_operator('5'))  You must have at least 2 numbers before you can then add an operator using the same method.  When you're ready to perform a calculation, just call p.perform_calculation(p.calculator_array).  You can then contiue to add more numbers and do more calculations.  

## To See An Example:
Just run ruby ReversePolishCalculator.rb from your terminal. 

## Tests:
To run the tests, run rspec ReversePolishCalculator_spec.rb

## Other notes: 
I would definitely research more into how to design a program to be implemented in different ways (WebSocket, TCP, file, etc.) if I were to spend additional time on this.  I would also try to make it more interactive vs. making the user call methods on their object.  Potentially move some methods into "private" too.

