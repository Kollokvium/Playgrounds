import UIKit

// String and Int Comparable
let stringArray = ["a", "b", "c", "d", "e", "f", "g", "h"]
let integerArray = [2, 42, 3, 4, 7, 101]

func findInputIndex (_ array: [String], letter: String) -> Int? {
    for (index, element) in array.enumerated() {
        if element == letter {
            return index
        }
    }
    
    return nil
}

// Comparable
func findWithgeneric<T:Comparable> (_ array:[T], key:T) -> Int? {
    for (index, element) in array.enumerated() {
        if element == key {
            return index
        }
    }
    return nil
}

findInputIndex(stringArray, letter: "h")
findWithgeneric(stringArray, key: "h")
findWithgeneric(integerArray, key: 42)

// Numeric
func anyNumberSum<E: Numeric>(lhs: E, rhs: E) -> E {
    return lhs + rhs
}

anyNumberSum(lhs: 5, rhs: 2.34)
anyNumberSum(lhs: -6, rhs: 10)
anyNumberSum(lhs: 0.0000005, rhs: 1)
