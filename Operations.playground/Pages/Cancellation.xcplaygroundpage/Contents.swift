import Foundation
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class ArraySumOperation: Operation {
    let inputArray: [(Int, Int)]
    var outputArray = [Int]()
    
    init(input: [(Int, Int)]) {
        inputArray = input
        super.init()
    }
    
    override func main() {
        for pair in inputArray {
            if isCancelled { return }
            outputArray.append (slowAdd(pair))
        }
    }
}

class AnotherArraySumOperation: Operation {
    let inputArray: [(Int, Int)]
    var outputArray: [Int]?
    
    init(input: [(Int, Int)]) {
        inputArray = input
        super.init()
    }
    
    override func main() {
        // DONE: Fill this in
        outputArray = slowAddArray(inputArray) {
            progress in
            print("\(progress*100)% of the array processed")
            return !self.isCancelled
        }
    }
}

let numberArray = [(1,2), (3,4), (5,6), (7,8), (9,10)]

let sumOperation = AnotherArraySumOperation(input: numberArray)
let queue = OperationQueue()

startClock()
queue.addOperation(sumOperation)

sleep(4)
sumOperation.cancel()

sumOperation.completionBlock = {
    stopClock()
    sumOperation.outputArray
    PlaygroundPage.current.finishExecution()
}
