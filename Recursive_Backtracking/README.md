# Requirement: #
Read from the keyboard the values of n, m, and 3 · n. These values can be either 0 or in the range from 1 to n, inclusive, satisfying the condition 1 ≤ n, m ≤ 30. Generate the smallest lexicographically ordered permutation of the set {1, ..., n}, where each element appears exactly 3 times, with a minimum distance of m elements between any two equal elements. The starting points are already specified.

For example, for n = 5, m = 1, and a sequence of 15 elements:

1 0 0 0 0 0 3 0 0 0 0 0 0 4 5

Each element from the set {1, 2, 3, 4, 5} appears 3 times, and there should be at least m = 1 element distance between any two equal elements. In this case, the smallest lexicographically ordered permutation, preserving the fixed points, is as follows:

1 2 1 2 1 2 3 4 3 5 3 4 5 4 5

Print to the standard output, as appropriate:

The permutation in the above format if it exists. Display the elements with spaces between them on the screen, and at the end, it is recommended to display a backslash n instead of using fflush;
Or -1 if there is no permutation that satisfies all the conditions.