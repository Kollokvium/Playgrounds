import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// Casual Debounce func
func debounce(interval: Int, queue: DispatchQueue, action: @escaping (() -> Void)) -> () -> Void {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)
    
    return {
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            if now.rawValue >= when.rawValue {
                action()
            }
        }
    }
}

// Debounce func with Params
typealias Debounce<T> = (_ : T) -> Void
func debounce<T>(interval: Int, queue: DispatchQueue, action: @escaping Debounce<T>) -> Debounce<T> {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)
    
    return { param in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            
            if now.rawValue >= when.rawValue {
                action(param)
            }
        }
    }
}

let debouncedFunction = debounce(interval: 200, queue: DispatchQueue.main, action: { (identifier: String) in
    print("interval >= 200 in \(identifier)")
})

DispatchQueue.global(qos: .background).async {
    debouncedFunction("1")
    usleep(100 * 1000)
    debouncedFunction("2")
    usleep(100 * 1000)
    debouncedFunction("3")
    usleep(100 * 1000)
    debouncedFunction("4")
    usleep(500 * 1000) // <-- 500 ms
    debouncedFunction("5")
    usleep(100 * 1000)
    debouncedFunction("6")
    usleep(100 * 1000)
    debouncedFunction("7")
    usleep(300 * 1000) // <-- 300 ms
    debouncedFunction("8")
    usleep(100 * 1000)
    debouncedFunction("9")
    usleep(100 * 1000)
    debouncedFunction("10")
    usleep(100 * 1000)
    debouncedFunction("11")
    usleep(100 * 1000)
    debouncedFunction("12")
}
