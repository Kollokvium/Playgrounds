import Foundation
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class SumOperation: Operation {
    let inputPair: (Int, Int)
    var output: Int?
    
    init(input: (Int, Int)) {
        inputPair = input
        super.init()
    }
    
    override func main() {
        if isCancelled { return }
        output = slowAdd(inputPair)
    }
}

class GroupAdd {
    private let queue = OperationQueue()
    private let appendQueue = OperationQueue()
    var outputArray = [(Int, Int, Int)]()
    
    init(input: [(Int, Int)]) {
        queue.isSuspended = true
        queue.maxConcurrentOperationCount = 2
        appendQueue.maxConcurrentOperationCount = 1
        generateOperations(input)
    }
    
    private func generateOperations(_ numberArray: [(Int, Int)]) {
        for pair in numberArray {
            let operation = SumOperation(input: pair)
            operation.completionBlock = {
                
                // Заметьте: добавляем в массив на очереди операций appendQueue.
                guard let result = operation.output else { return }
                self.appendQueue.addOperation {
                    self.outputArray.append((pair.0, pair.1, result))
                }
            }
            queue.addOperation(operation)
        }
    }
    
    func start() {
        queue.isSuspended = false
    }
    
    func cancel() {
        queue.cancelAllOperations()
    }
    
    func wait() {
        queue.waitUntilAllOperationsAreFinished()
    }
}

// Input Data

let numberArray = [(1,2), (3,4), (5,6), (7,8), (9,10)]
let groupAdd = GroupAdd(input: numberArray)

// Start
startClock()
groupAdd.start()

// Pause before cancel
sleep(1)
groupAdd.cancel()

// Should not use `wait` on main queue, only playground
groupAdd.wait()
stopClock()

// Check Result
groupAdd.outputArray
