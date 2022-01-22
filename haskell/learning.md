1 Installing Haskell
	.1 Try Haskell official page with the command 
		`curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`
		Did not succeed due to MacOS authority issue.
	.2 Search on SO and use Homebrew, it worked.

2 Look at how to run Haskell
	.1 ghci for the repl, ghc is the compiler (ghc -o output_binary sourcefile.hs)
	.2 helloWorld.hs (camel-cased idiom as it seems...)
		`>>> ghc -o hello helloWorld.hs`
		`>>> ./hello`
		and it worked.	

	Last Element of the List
	.1 Solution 1: define function by pattern matching
	.2 Solution 2: `myLast = foldr1 (const id)`
		This solution is very unintuitive. Basically `const` make its second argument disappear, so its first argument `id` is applied to the third one. Fold(r/l) is just reduce in other languages.
	
	But Last Element of ths List
	.1 Solved by pattern matching.
		Difficulty when testing:
			`print (myButLast [])` does not work because `[]` has an undetermined type parameter. Instead use `print (myButLast [] :: [Int])` as a work-around. But it would be an error anyway, really, why bother Haskell?
	.2 `=>` typeclass syntax (almost an interface)

	Element At
	.1 Difficulty when trying to test my solution `print (elementAt []::[Int] 5)` gives an illegal type error on the number `5`. Googling yields not many relevant result. 
		Maybe I am doing something wrong? But this seems very unintuitive. 
		It turns out (thanks to SO and in particular Willem Van Onsem) I should do 
			`print (elementAt ([] :: [Int]) 5)`
		instead. 
	.2 Dollar sign `$` "prompt" application of the function right after it
	.3 Quoting operator to escape it. (like `($)`)


	Length of List
	.1 Solved by Pattern Matching recursive
		Tail recursive solution would be better: how to define a function within a function:
			```myOuter x y z = myInnerFunction x y z 0
				where
					myInnerFunction _ _ z 0 = ...
					myInnerFunction _ 1 z 0 = ...
					...```
	.2 lambda `\x y -> ...`

	IsPalindrome Stuck by Not Being Able to Passing the Compilation

 
