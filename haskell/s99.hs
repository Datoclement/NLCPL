myLast :: [a] -> a
myLast = last

myButLast :: [a] -> a
myButLast [] = error "Only list of length >= 2 has but last element."
myButLast [x] = myButLast []
myButLast [x, _] = x
myButLast (_: xs) = myButLast xs

elementAt :: [a] -> Int -> Maybe a
elementAt _ x | x <= 0 = Nothing
elementAt [] x | x > 0 = Nothing
elementAt (x: _) 1 = Just x
elementAt (_: xs) x | x > 1 = elementAt xs (x-1)

testElementAt :: IO ()
testElementAt = do
    print (elementAt ([]::[Int]) 5)
    print (elementAt ([]::[Int]) 0)
    print (elementAt [1, 2, 3] 2)
    print (elementAt [1, 2, 3] 5)
    print (elementAt [1, 2, 3] 1)
    print (elementAt [1, 2, 3] 0)

testMyButLast :: IO ()
testMyButLast = do
    print (myButLast [1, 2, 3])
    -- print (myButLast [] :: [Int])
    -- print (myButLast [1])
    print (myButLast [1, 2])

myLength :: [a] -> Int
myLength [] = 0
myLength (_: xs) = 1 + myLength xs

testMyLength :: IO ()
testMyLength = do
    print $ myLength []
    print $ myLength [1]
    print $ myLength [1, 2, 3]

myReverse :: [a] -> [a]
myReverse list = myReverse_aux list []
    where
        myReverse_aux [] l = l
        myReverse_aux (x:xs) l = myReverse_aux xs (x:l)


testMyReverse :: IO ()
testMyReverse = do
    print $ myReverse ([]::[Int])
    print $ myReverse [1]
    print $ myReverse [1, 2, 3, 4, 5]

-- isPalindrome :: [a] -> Bool
-- isPalindrome x = foldl (\z y -> z && y) True $ map (\z y -> z == y) $ zip x $ reverse x

-- testIsPalinDrome :: IO ()
-- testIsPalinDrome = do
--     print $ testIsPalinDrome []
--     print $ testIsPalinDrome "121"
--     print $ testIsPalinDrome [1, 2, 3]
--     print $ testIsPalinDrome [1, 2, 3, 2, 1]
--     print $ testIsPalinDrome "123321"
--     print $ testIsPalinDrome "1"
--     print $ testIsPalinDrome "12345"

main :: IO ()
main = do
    testMyButLast
    testElementAt
    testMyLength
    testMyReverse