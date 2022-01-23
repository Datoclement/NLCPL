## First Impression
After finishing the 10 first 99 questions, my impression is that the syntax is clean and concise, except that in some cases the precedences are not intuitive, example of which is the type annotation `::`.

Some mistakes that I usually made are:
1. Forgetting to type annotate the empty list `[]`, e.g.:
    `myEncode []` instead of `myEncode []::[Int]`
2. Forgetting to embrace the type annotation, e.g.;
    `myEncode []::[Int]` instead of `myEncode ([] :: [Int])`

It seems like knowing what functions are "built-in" can greatly improve the productivity. As beginner I almost exclusively use pattern matching to solve the first ten questions as it comes as the most natural way to think in this functional paradigm. However, among the proposed solutions, there are many using compositions of built-in function (or should I say structures it does not look like they are all "functions").

Syntaxs-wise, as a guy coming from Python, space-sensitivity of Haskell is not a big disturbance (even though their space-sensitivity seems a little bit different). It is actually a minor plus, except that some precedence rules are not intuitive as I mentioned before.

One thing I wonder is how I can be lazy programmer in Haskell: while solving the 99 puzzles, I need to write test that will be called in my main function. I wonder if there is possibility that Haskell automatically executes all the functions that has name beginning with "test", so that I don't have to call the test function manually. This sounds a little bit dynamic and not something that Haskell is good at.