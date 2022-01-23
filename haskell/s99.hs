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

isPalindrome :: Eq a => [a] -> Bool
isPalindrome x = isPalindrome_aux x $ reverse x
    where
        isPalindrome_aux [] [] = True
        isPalindrome_aux (y:ys) (z:zs) | y /= z = False
        isPalindrome_aux (y:ys) (z:zs) | y == z = isPalindrome_aux ys zs

testIsPalinDrome :: IO ()
testIsPalinDrome = do
    print "testIsPaLinDrome"
    print $ isPalindrome ([] :: [Int])
    print $ isPalindrome "121"
    print $ isPalindrome [1, 2, 3]
    print $ isPalindrome [1, 2, 3, 2, 1]
    print $ isPalindrome "123321"
    print $ isPalindrome "1"
    print $ isPalindrome "12345"
    putStr "\n"

data NestedList a = Elem a | List [NestedList a]

myFlatten :: NestedList a -> [a]
myFlatten = reverse . (myFlatten_aux [])
    where
        myFlatten_aux l (Elem y) = (y:l)
        myFlatten_aux l (List []) = l
        myFlatten_aux l (List (y:ys)) = myFlatten_aux (myFlatten_aux l y) (List ys) 

testMyFlatten :: IO ()
testMyFlatten = do
    print "testMyFlatten"
    print $ myFlatten (Elem 5)
    print $ myFlatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])
    print $ myFlatten (List ([] :: [NestedList Int]))
    putStr "\n"

compress :: Eq a => [a] -> [a]
compress = reverse . compress_aux []
    where
        compress_aux l [] = l
        compress_aux [] (x:xs) = compress_aux [x] xs
        compress_aux (x:xs) (y:ys) | x == y = compress_aux (x:xs) ys
        compress_aux (x:xs) (y:ys) | x /= y = compress_aux (y:x:xs) ys

testCompress :: IO ()
testCompress = do
    print "testCompress"
    print $ compress ([] :: [Int])
    print $ compress [1]
    print $ compress [1, 2]
    print $ compress [1, 2, 2]
    print $ compress [1, 2, 3, 3 ,3, 4, 4, 1, 1, 5, 5, 6, 7, 7]
    putStr "\n"

myPack :: Eq a => [a] -> [[a]]
myPack = reverse . myPack_aux []
    where
        myPack_aux l [] = l
        myPack_aux [] (x:xs) = myPack_aux [[x]] xs
        myPack_aux ((y:ys):xs) (z:zs) | y == z = myPack_aux ((z:y:ys):xs) zs
        myPack_aux ((y:ys):xs) (z:zs) | y /= z = myPack_aux ([z]:(y:ys):xs) zs

testMyPack :: IO ()
testMyPack = do
    print "testMyPack"
    print $ myPack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 
             'a', 'd', 'e', 'e', 'e', 'e']
    print $ myPack ([] :: [Char])
    print $ myPack "a"
    print $ myPack "aabbbaaaabbbbb"
    putStr "\n"

myEncode :: Eq a => [a] -> [(Int, a)]
myEncode = reverse . myEncode_aux []
    where
        myEncode_aux l [] = l
        myEncode_aux [] (x:xs) = myEncode_aux [(1, x)] xs
        myEncode_aux ((n, x):nxs) (y:ys) | x == y = myEncode_aux ((n+1, x):nxs) ys
        myEncode_aux ((n, x):nxs) (y:ys) | x /= y = myEncode_aux ((1, y):(n, x):nxs) ys

testMyEncode :: IO ()
testMyEncode = do
    print "testMyEncode"
    print $ myEncode "aaaabccaadeeee"
    print $ myEncode "aabbbbccaaddddd"
    print $ myEncode ""
    print $ myEncode "a"
    putStr "\n"

data MultiElem a = Plural (Int, a) | Singular a deriving Show

myMultiEncode :: Eq a => [a] -> [MultiElem a]
myMultiEncode = reverse . myMultiEncode_aux []
    where
        myMultiEncode_aux l [] = l
        myMultiEncode_aux [] (x:xs) = myMultiEncode_aux [(Singular x)] xs
        myMultiEncode_aux ((Singular x):xs) (y:ys) | x == y 
            = myMultiEncode_aux ((Plural (2, x)):xs) ys
        myMultiEncode_aux ((Singular x):xs) (y:ys) | x /= y 
            = myMultiEncode_aux ((Singular y):(Singular x):xs) ys
        myMultiEncode_aux ((Plural (n, x)):xs) (y:ys) | x == y 
            = myMultiEncode_aux ((Plural (n+1, x)):xs) ys
        myMultiEncode_aux ((Plural (n, x)):xs) (y:ys) | x /= y 
            = myMultiEncode_aux ((Singular y):(Plural (n, x)):xs) ys


testMyMultiEncode :: IO ()
testMyMultiEncode = do
    print "testMyMultiEncode"
    print $ myMultiEncode "aaaabccaadeeee"
    print $ myMultiEncode "aabbbbccaaddddd"
    print $ myMultiEncode ""
    print $ myMultiEncode "a"
    print $ myMultiEncode "aaaabccaadeeee"
    putStr "\n"

myMultiDecode :: [MultiElem a] -> [a]
myMultiDecode = reverse . myMultiDecode_aux []
    where
        myMultiDecode_aux l [] = l
        myMultiDecode_aux l ((Singular x):xs) = myMultiDecode_aux (x:l) xs
        myMultiDecode_aux l ((Plural (n, x)):xs) = myMultiDecode_aux ((replicate n x) ++ l) xs

testMyMultiDecode :: IO ()
testMyMultiDecode = do
    print "testMyMultiDecode"
    print $ myMultiDecode [Plural (4,'a'), Singular 'b',Plural (2,'c'),Plural (2,'a'),Singular 'd',Plural (4,'e')]
    print $ myMultiDecode [Plural (2,'a'),Plural (4,'b'),Plural (2,'c'),Plural (2,'a'),Plural (5,'d')]
    print $ myMultiDecode ([] :: [MultiElem Char])
    print $ myMultiDecode [Singular 'a']
    print $ myMultiDecode [Plural (4,'a'),Singular 'b',Plural (2,'c'),Plural (2,'a'),Singular 'd',Plural (4,'e')]
    putStr "\n"

myDuplicate :: [a] -> [a]
myDuplicate x = x >>= \y -> [y, y]

testMyDuplicate :: IO ()
testMyDuplicate = do
    print "testMyDuplicate"
    print $ myDuplicate ([] :: [Char])
    print $ myDuplicate [1]
    print $ myDuplicate "abcccba"
    print $ myDuplicate [1, 2, 3]
    putStr "\n"

myReplicate :: [a] -> Int -> [a]
myReplicate x n = x >>= \y -> replicate n y

testMyReplicate :: IO ()
testMyReplicate = do
    print "testMyDuplicate"
    print $ myReplicate ([] :: [Char]) 3
    print $ myReplicate [1] 4 
    print $ myReplicate "abcccba" 5
    print $ myReplicate [1, 2, 3] 6
    putStr "\n"

myDropEvery :: [a] -> Int -> Maybe [a]
myDropEvery x n = myDropEvery_aux [] x n
    where
        myDropEvery_aux _ _ m | m <= 0 = Nothing
        myDropEvery_aux l [] _ = Just $ reverse l
        myDropEvery_aux l (x:xs) 1 = myDropEvery_aux l xs n
        myDropEvery_aux l (x:xs) m | m > 1 = myDropEvery_aux (x:l) xs (m-1)

testMyDropEvery :: IO ()
testMyDropEvery = do
    print "testMyDropEvery"
    print $ myDropEvery ([] :: [Char]) 3
    print $ myDropEvery [1, 2, 3, 4, 5, 6, 7] 4 
    print $ myDropEvery "abcccba" 5
    print $ myDropEvery [1, 2, 3] 1
    putStr "\n"

mySplit :: [a] -> Int -> Maybe ([a], [a])
mySplit _ n | n < 0 = Nothing
mySplit xs n | n >= 0 = mySplit_aux [] xs n
    where
        mySplit_aux l [] _ = Just (reverse l, [])
        mySplit_aux l xs 0 = Just (reverse l, xs)
        mySplit_aux l (x:xs) n | n > 0 = mySplit_aux (x:l) xs (n-1)

testMySplit :: IO ()
testMySplit = do
    print "testMySplit"
    print $ mySplit [1, 2, 3, 4, 5] (-1)
    print $ mySplit [1, 2, 3, 4, 5] 3
    print $ mySplit ([] :: [Int]) 3
    print $ mySplit [1, 2, 3] 0
    print $ mySplit [1, 2, 3] 7
    putStr "\n"

mySlice :: [a] -> Int -> Int -> Maybe [a]
mySlice xs n m | n > m = Nothing
mySlice xs n m | n <= m = mySlice_aux [] xs n m
    where
        mySlice_aux l [] _ _ = Just (reverse l)
        mySlice_aux l xs n m | m < 1 = Just []
        mySlice_aux l xs n m | n < 1 = mySlice_aux l xs 1 m
        mySlice_aux l (x:xs) 1 1 = Just (reverse (x:l))
        mySlice_aux l (x:xs) 1 m | m > 1 = mySlice_aux (x:l) xs 1 (m-1)
        mySlice_aux l (x:xs) n m | m >= n && n > 1 = mySlice_aux l xs (n-1) (m-1)

testMySlice :: IO ()
testMySlice = do
    print "testMySlice"
    print $ mySlice ([] :: [Char]) 3 7
    print $ mySlice [1, 2, 3, 4, 5, 6] 2 4
    print $ mySlice [1, 2, 3, 4, 5, 6] (-1) 3
    print $ mySlice [1] 0 3
    print $ mySlice [1, 2, 3, 4, 5, 6] 3 (-1)
    print $ mySlice [1, 2, 3, 4, 5, 6] (-3) (-1)
    putStr "\n"

myRotate :: [a] -> Int -> [a]
myRotate [] _ = []
myRotate l n | n > (length l) = myRotate l (n `mod` (length l))
myRotate l n | n < 0 = let len = length l in myRotate l (n `mod` len + len) 
myRotate l n | n == (length l) || n == 0 = l
myRotate l n | otherwise = myRotate_aux [] l n
    where
        myRotate_aux x y 0 = y ++ (reverse x)
        myRotate_aux xs (y:ys) m = myRotate_aux (y:xs) ys (m-1)

testMyRotate :: IO ()
testMyRotate = do 
    print "testMyRotate"
    print $ myRotate ([] :: [Char]) 10
    print $ myRotate [1] 3
    print $ myRotate [1, 2, 3] (-8)
    print $ myRotate [1, 2, 3, 4, 5, 6, 7] 3
    putStr "\n"

myRemoveAt :: Int -> [a] -> (Maybe a, [a])
myRemoveAt _ [] = (Nothing, [])
myRemoveAt n l | n <= 0 || n > (length l) = (Nothing, l)
myRemoveAt n l | otherwise = myRemoveAt_aux [] n l
    where
        myRemoveAt_aux xs 1 (y:ys) = (Just y, reverse xs ++ ys)
        myRemoveAt_aux xs m (y:ys) | m > 1 = myRemoveAt_aux (y:xs) (m-1) ys

testMyRemoveAt :: IO ()
testMyRemoveAt = do
    print "testMyRemoveAt"
    print $ myRemoveAt 1 ([] :: [Char])
    print $ myRemoveAt 3 [1, 2, 3]
    print $ myRemoveAt (-1) [1, 2, 3]
    print $ myRemoveAt 8 [1, 2, 3]
    putStr "\n"

main :: IO ()
main = do
    testMyButLast
    testElementAt
    testMyLength
    testMyReverse
    testIsPalinDrome
    testMyFlatten
    testCompress
    testMyPack
    testMyEncode
    testMyMultiEncode
    testMyMultiDecode
    testMyDuplicate
    testMyReplicate
    testMyDropEvery
    testMySplit
    testMySlice
    testMyRotate
    testMyRemoveAt