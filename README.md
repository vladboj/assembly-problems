# Requirement 1: #
Given an input hexadecimal string, the task is to display the assembly instruction to be executed on the standard output.

For example, for the input A78801C00A7890EC04, the output on the standard output will be x 1 let x -14 div.

# Requirement 2: #
Given as input an instruction in the assembly language of the considered arithmetic processor, the task is to display on the standard output the evaluation of the instruction. For this requirement, there are no variables in the instruction; it is formed only by integers and operations.

For example, an instruction could be given like "2 10 mul 5 div 7 6 sub add." The result should follow the algorithm below:

* Add 2 to the stack.
* Add 10 to the stack.
* Identify the multiplication operation (mul), apply the multiplication between 2 and 10, resulting in 20. Remove 2 and 10 from the stack, keeping only 20.
* Add 5 to the stack.
* Identify the division operation (div), which performs 20 div 5, resulting in 4. Remove 20 and 5 from the stack, keeping only 4.
* Add 7 to the stack.
* Add 6 to the stack.
* Identify the subtraction operation (sub), which calculates the difference between 7 and 6, resulting in 1. Remove 7 and 6 from the stack, adding 1 to the stack. Note that at this point, the stack contains 4 at the bottom and 1 at the top because the subtraction is a binary operation and worked only with the arguments 7 and 6, not with the 4 that was already at the bottom of the stack.
* Identify the addition operation (add), which calculates the sum between 1 and 4, resulting in 5. Remove 1 and 4 from the stack, adding 5.
After traversing the entire sequence, the obtained result is now at the top of the stack. In this example, the result is 5.

# Requirement 3: #
Given an input instruction in the assembly language of the considered arithmetic processor, the task is to display the evaluation of the instruction on the standard output. Unlike requirement 2, this task involves the use of variables introduced by "let."

An example of input could be "x 1 let 2 x add y 3 let x y add mul." The evaluation proceeds as follows:

* Add x and 1 to the stack; when "let" is encountered, it is understood that x = 1 throughout the arithmetic expression. Remove x and 1 from the stack.
* Add 2 and 1 to the stack (since x is now 1).
* When "add" is encountered, calculate the sum, resulting in 3. Remove 2 and 1 from the stack, keeping only 3.
* Add y and 3 to the stack; when "let" is encountered, it is understood that y = 3 throughout the arithmetic expression. Remove y and 3 from the stack.
* Add 1 and 3 to the stack (representing x and y).
* Perform the addition; the result is 4. Remove 1 and 3 from the stack, adding 4.
* Identify "mul"; the stack already contains 3 (from the third bullet point in the current explanation) and 4 (from the previous bullet point). Calculate the result, which is 12. Remove 3 and 4 from the stack and add 12.
Since there are no more elements in the sequence, the final result is 12.
Similar to requirement 2, it is guaranteed that all operations will be applied to unsigned integers.

*The given information isn't enough to be able to solve the requirements. I posted them to give a general idea of the tasks.*