import UIKit

// MARK: - .map
// Loops over a collection and applies the same operation to each element in the collection.
var myWords = ["Some", "Chick", "Turn", "Around"]
var math = [1, 4, 5, 10]
var compactZoo = [["🐵", "🐵", "🐵"], ["🦊", "🦊"], ["🦁", "🦁"], nil]

let sentence = myWords.map { $0 + " 1" }
let sentence4 = myWords.map { value in value + " 4" }

print("""
    \(sentence)
    \(sentence4)
    """)

// MARK: - .filter
// Loops over a collection and returns an array that contains elements that meet a condition.
let fileteredSentence = myWords.filter { $0 == "Chick" || $0 == "Around" }
print(fileteredSentence)

// MARK: - .reduce
// Loops over a collection and Combines all items in a collection to create a single value. aka Glue
let calculation = math.reduce(0, +)
print(calculation)

let glue = myWords.reduce("", { $0 + $1 })
print(glue)

// MARK: - .flatMap & .compactMap
// Arrays within an array that we would like to combine into a single array.
let noNilArray = compactZoo.compactMap { $0 } // Skip nil
let merge = compactZoo.compactMap { $0?.joined() } // Merge
print(noNilArray)
print(merge)
