import UIKit

// Important to have Class instead of Struct
final class Singleton {
    static let shared = Singleton()
    
    // Important to make `private` init
    private init() { }
    
    var value: Int = 0
    func printMyValue() {
        print("Doing something with value \(value)")
    }
}

var object = Singleton.shared
object.value = 1000
print(object.value)

var secondObject = Singleton.shared
secondObject.value = 2000
print(secondObject.value)

object.printMyValue()
secondObject.printMyValue()

print(object === secondObject)
