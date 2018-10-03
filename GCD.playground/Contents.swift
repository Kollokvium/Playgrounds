import UIKit
import PlaygroundSupport

let dispatchQueue = DispatchQueue(label: "testQueue")

func someAsync() {
    dispatchQueue.async {
        var sum = 0
        for i in 1...10 {
            sum += i
        }
        print(sum)
    }
}
//someAsync()

let queue = DispatchQueue(label: "first.queue")

func simpleSyncQueue() {
    print("*** simpleSyncQueue ***")
    queue.sync {
        (0...4).forEach { print("🍎 \($0)") }
        (0...4).forEach { print("🍏 \($0)") }
        (0...4).forEach { print("🌸 \($0)") }
    }
}

func simpleAsyncQueue() {
    print("*** simpleAsyncQueue ***")
    dispatchQueue.async {
        (0...5).forEach { print("  ⭐️ \($0)") }
        (0...5).forEach { print("  ✨ \($0)") }
    }
    
    dispatchQueue.async {
        (0...5).forEach { print("  ⭐️ \($0)") }
        (0...5).forEach { print("  ✨ \($0)") }
    }
}

simpleSyncQueue()
simpleAsyncQueue()
