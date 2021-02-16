# Interview Prep Cheat Sheet

## Every question

- Read the question carefully
- Work it out on paper
- Test all edge cases
  - 0, 1, duplicates

## Problem Classifiers

### Hashing

```swift
// Given a array, determine if there are a pair of numbers that equal a given sum `B`.

func equalSumFast(_ A: [Int], B: Int) -> Bool {
    var hashA = [Int: Bool]()
    
    for a in A {
        hashA[a] = true
    }
    
    for a in A {
        if hashA[B - a] == true {
            return true
        }
    }
    
    return false
}

equalSumFast([1, 2, 3, 9], B: 8) // false
equalSumFast([1, 2, 4, 4], B: 8) // true
```

### Prefix Sums

Use prefix sums is a way of building an array consisting of all the sums at i, along with all the sums that come before it.

```swift
/*
    a0      a1      a2                  an
    a0  a0 + a1  a0 + a1 + a2     a0+a1+...+an-1
  */

func prefixSum(_ A: [Int]) -> [Int] {
    var prefix = Array<Int>(repeating: 0, count: A.count)
    prefix[0] = A[0]
    for i in 1..<A.count {
        prefix[i] = prefix[i - 1] + A[i]
    }
    
    return prefix
}

prefixSum([1, 2, 3])    // 1, 3, 6
```

Then once you have this, you can do calculations like calculate the total of any slice very quickly.

```swift
func countTotal(_ P: [Int], _ x: Int, _ y: Int) -> Int {
    return P[y] - P[x]
}

let prefix = prefixSum([1, 2, 3, 4])
let midTotal = countTotal(prefix, 1, 2) // 7 = 10 - 3
```

### Leader

The leader is the element whose value occurs more than n/2 times.

```swift
/*
 If the sequence is ordered, the identical values are adjacent to each other.
 Leader must be a n/2 - the central element.
 
 4 6 6 6 6 8 8
       *
 */

func fastLeader(_ A: [Int]) -> Int {
    var leader = -1
    
    let n = A.count
    let B = A.sorted()
    
    let candidate = B[n/2]
    
    var count = 0
    for i in 0..<B.count {
        if B[i] == candidate {
            count += 1
        }
    }
    
    if count > n / 2 {
        leader = candidate
    }
    
    return leader
}

fastLeader([4, 6, 6, 6, 6, 8, 8])
```

### Max Slice

This is a handy algorithnm for determining what the slice with the largest sum.

```swift
/*
 Maximum Slice Sum Problem
 https://app.codility.com/programmers/lessons/9-maximum_slice_problem/
 
 Find the slice with the largest sum.
 
 5 -7 3 5 -2 4 -1
      --------
 
 This is the maxium slice we can have. Notice how it contains a negative number?
 That's becaue the array element after it is so big it is worth including.
 
 Also we don't necessarily include all elements (like first element 5) because when we add
 it to the next slice -7 it makes the slice negative, so we drop both until we hit the
 next positive number 3, and then continue summing from there.
 
 Here is a fast performant algorithm for solving.
 */

func solution(_ A:[Int]) -> Int {
    var maxEnding = A[0]
    var maxSlice = A[0]
    for i in 1..<A.count {
        maxEnding = max(A[i], maxEnding + A[i])
        maxSlice = max(maxSlice, maxEnding)
    }
    return maxSlice
}

solution([5, -7, 3, 5, -2, 4, -1])
```

With this, you can then use it in questions that look for things like max profit.

### Prime & Composite Numbers

This algorithm is good for finding all the divisors in a number really fast.

```swift
func divisorsFast(_ n: Int) -> [Int] {
    var i = 1
    var result = Set<Int>()
    while i * i < n {
        if n % i == 0 {
            result.insert(i)
            result.insert(n/i)
        }
        i += 1
    }
    
    // perfect squares get an extra
    if i * i == n {
        result.insert(i*i)
    }
    return Array<Int>(result)
}
```

You can then use this technique to find the minimum permimeter of a recangle given a specific area (find all divisors of the area).

### Euclidean Algorithm - Greateset Common Divisor

Technique for finding the greatest common divisor (gcd) between two positive integers.

```swift
// Euclidean algorithm by subtraction: O(n)
func gcdSub(_ a: Int, _ b: Int) -> Int {
    if a == b { return a }
    if a > b {
        return gcdSub(a - b, b)
    } else {
        return gcdSub(a, b - a)
    }
}

// Euclidean algorithm by division: O(log(a+b))
func gcdDiv(_ a: Int, _ b: Int) -> Int {
    if a % b == 0 {
        return b
    } else {
        return gcdDiv(b, a % b)
    }
}

gcdSub(24, 18)
gcdDiv(24, 18)
```

### Caterpillar

Algorithm for crawling along and evaluating criteria each step of the way, before adjusting the front and back pointers of the caterpillar crawling the array.

```swift
func caterpillarSum(_ A: [Int], _ s: Int) -> Bool {
    let n = A.count
    var front = 0
    var back = 0
    var total = 0
    
    for _ in 0..<n {
        while front < n && total + A[front] <= s {
            total += A[front]
            front += 1
        }
        if total == s {
            return true
        }
        total -= A[back]
        back += 1
    }
    return false
}

caterpillarSum([6, 2, 7, 4, 1, 3, 6], 12)
caterpillarSum([6, 2, 7, 3, 1, 3, 6], 12)
caterpillarSum([1, 2, 1, 3, 1, 3, 6], 12)
```

### Misc

```swift
// Collections
let arr = [1, 2, 3]

var emptyDict = [String: String]()
emptyDict["key1"] = "value1"

var dictWithValues = ["key": "value1", "key2": "value2"]

let set = NSCountedSet(array: arr)
set.count(for: 1)

for i in 0..<arr.count {
    for j in i + 1..<arr.count {
        print("\(i) \(j)")
    }
}

// loop backwards
for i in stride(from: arr.count - 1, to: 0, by: -1) {
    print(i)
}


// Strings
var result = "a b 0123456789-"

// Split
"i am having a good time".components(separatedBy: " ")

// strip out spaces
result = result.replacingOccurrences(of: " ", with: "")

// strip off lingering dash
if result.last! == "-" {
    result = String(result.dropLast())
}

// Convert String into Array<Character>
var characters = Array(result)
var backToString = String(characters)

let noSpaceNoDash = "abc"
for c in noSpaceNoDash {
    result.append(c)
}

func isPalindrome(_ value: String) -> Bool
{
    return value == String(value.reversed())
}

// Range
let L = 44
let R = 60
let range = Array(L...R)

// Extensions
extension Int {
    func toArray() -> [Int] {
        let nStr = String(self)
        let nChars = Array<Character>(nStr)
        return nChars.compactMap { Int(String($0)) }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    var isAllLetters: Bool {
        for uni in self.unicodeScalars {
            if !CharacterSet.letters.contains(uni) {
                return false
            }
        }
        return true
    }
    var isAllNumbers: Bool {
        for uni in self.unicodeScalars {
            if !CharacterSet.decimalDigits.contains(uni) {
                return false
            }
        }
        return true
    }
}

extension Character {
    var isLetter: Bool {
        return CharacterSet.letters.contains(self.unicodeScalars.first!)
    }
    var isNumber: Bool {
        return CharacterSet.decimalDigits.contains(self.unicodeScalars.first!)
    }
}
```
