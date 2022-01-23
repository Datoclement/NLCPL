# Installing Haskell
1. Try Haskell official page with the command 
	`curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`
	Did not succeed due to MacOS authority issue.
2. Search on SO and use Homebrew, it worked.

# Look at how to run Haskell
1. ghci for the repl, ghc is the compiler (ghc -o output_binary sourcefile.hs)
2. helloWorld.hs (camel-cased idiom as it seems...)
	`>>> ghc -o hello helloWorld.hs`
	`>>> ./hello`
	and it worked.	

# Solving 99 problems

## Last Element of the List
1. Solution 1: define function by pattern matching
2. Solution 2: `myLast = foldr1 (const id)`
	This solution is very unintuitive. Basically `const` make its second argument disappear, so its first argument `id` is applied to the third one. Fold(r/l) is just reduce in other languages.

## But Last Element of ths List
1. Solved by pattern matching.
	Difficulty when testing:
		`print (myButLast [])` does not work because `[]` has an undetermined type parameter. Instead use `print (myButLast [] :: [Int])` as a work-around. But it would be an error anyway, really, why bother Haskell?
2. `=>` typeclass syntax (almost an interface)

## Element At
1. Difficulty when trying to test my solution `print (elementAt []::[Int] 5)` gives an illegal type error on the number `5`. Googling yields not many relevant result. 
	Maybe I am doing something wrong? But this seems very unintuitive. 
	It turns out (thanks to SO and in particular Willem Van Onsem) I should do 
		`print (elementAt ([] :: [Int]) 5)`
	instead. 
2. Dollar sign `$` "prompt" application of the function right after it
3. Quoting operator to escape it. (like `($)`)


## Length of List
1. Solved by Pattern Matching recursive
	Tail recursive solution would be better: how to define a function within a function:
		```myOuter x y z = myInnerFunction x y z 0
			where
				myInnerFunction _ _ z 0 = ...
				myInnerFunction _ 1 z 0 = ...
				...```
2. lambda `\x y -> ...`

## IsPalindrome Stuck by Not Being Able to Passing the Compilation
1. Solved with still pattern matching
2. `>>=` bind operation `>>= :: m a -> (a -> m b) -> m b`
	One solution being `isPalindrome = reverse >>= (==)`
	`>>=` is the first function to apply, with `m` substituted by the List monad(?), but what is the type `a` in `reverse`
	is unclear for me. `reverse` has type `List x -> List x`, I suppose then `a` should be `x -> x`. 
	But then for the right hand side `==` is of type `x -> x -> List b` does not seem to be correct as `==`
	expects a `Bool` as its return type. 
	After some Googling, [this StackOverflow question](https://stackoverflow.com/questions/69936614/haskell-monad-for-ispalindrome) 
	offers a great explanation of exactlyt this.
	We know `reverse` is of type `[c] -> [c]` and `m a` at the same time.
	We know `m b` is of type `[c] -> Bool`
	We know also `(==)` is of type `[c] -> [c] -> Bool` and `a -> m b` at the same time, the latter is equivalent to
	`a -> [c] -> Bool`. Thus, `a` is `[c]` and `m [c]` is `[c] -> [c]`.
	Since `m [c]` is `[c] -> [c]` and `m b` is `[c] -> Bool`, we have `b` is `Bool` and `m x` is `[c] -> x`.

## Flatten
1. `data` to create new data structure:
	`data NestedList a = Elem a | List [NestedList a]`

## MultiEncode
1. Problem that I encounter is that I need to print a custom `data` type `MultiElem` and thus I need to write
	a function for that. In my case, I solve it by adding `deriving Show` at the end of my type definition. It
	remains a question for me how to do this in general (how to write a `show` function by myself), but for now it works.

## First 20 Questions
1. Basically, solving questions about list can be done by solely using pattern matching.

 
