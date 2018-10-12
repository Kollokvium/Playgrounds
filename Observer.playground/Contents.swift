import UIKit

protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var id: String { get set }
    func update(value: String?)
}

final class Barraks: Observable {
    
    var value: String? {
        didSet {
            notifyObservers()
        }
    }
    
    private var observers: [Observer] = []
    
    func add(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let index = observers.enumerated().first(where: { $0.element.id == observer.id })?.offset else { return }
        observers.remove(at: index)
    }
    
    func notifyObservers() {
        observers.forEach { $0.update(value: value)}
    }
}

final class Hive: Observer {
    var id = "hive"
    
    func update(value: String?) {
        guard let value = value else { return }
        print("Produced: \(value)")
    }
}

final class Farm: Observer {
    var id = "farm"
    
    func update(value: String?) {
        guard let value = value else { return }
        print("Produced: \(value)")
    }
}

final class Ziggurat: Observer {
    var id = "ziggurat"
    
    func update(value: String?) {
        guard let value = value else { return }
        print("Produced: \(value)")
    }
}

let unitProducer = Barraks()

let hive = Hive()
let farm = Farm()
let ziggurat = Ziggurat()

unitProducer.add(observer: hive)
unitProducer.add(observer: ziggurat)

unitProducer.value = "100 Units Total"

unitProducer.add(observer: farm)

unitProducer.value = "+100 Units for Farm"
unitProducer.remove(observer: farm)

unitProducer.value = "101 Units Total"
unitProducer.value = "102 Units Total"
