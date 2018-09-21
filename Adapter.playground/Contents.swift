import UIKit

// Simple adapter [1]

// Adaptee
class Orc {
    func walk() {
        print("Orc is walking")
    }
}

// Target
protocol OrcSentinel {
    func march()
}

// Adapter
extension Orc: OrcSentinel {
    func march() {
        walk()
        walk()
    }
}

struct Orgrimar {
    init(guardians: [OrcSentinel]) {

    }
}

// More Complex Adapter [2]

// Adaptee
class Hobbit {
    open func walk() {
        print("Hobbit is walking")
    }
}

// Target
class GuardianOfTheCitadel {
    open func march() {
        print("Guardian is marching")
    }
}

// Adapter
class HobbitGuardian: GuardianOfTheCitadel {
    private let hobbit: Hobbit
    
    init(hobbit: Hobbit) {
        self.hobbit = hobbit
    }
    
    override func march() {
        hobbit.walk()
        print("Hobbit realizes he is few steps behind the formation!")
        hobbit.walk()
    }
}


// Mark: Object Adapter
protocol Target {
    func request()
}

class Adapter: Target {
    var adaptee: Adaptee
    
    init(adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    func request() {
        adaptee.specificRequest()
    }
}

class Adaptee {
    func specificRequest() {
        print("Specific request")
    }
}

// Usage
let adaptee = Adaptee()
let target = Adapter(adaptee: adaptee)
target.request()


// Mark: Class adapter
protocol AnotherTarget {
    func request()
}

class AnotherAdaptee {
    func specificRequest() {
        print("Specific request")
    }
}

class AnotherAdapter: AnotherAdaptee, AnotherTarget {
    func request() {
        specificRequest()
    }
}

// Usage
let anotherTarget = AnotherAdapter()
anotherTarget.request()
