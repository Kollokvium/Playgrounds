import UIKit
import Foundation

// ============================ *** ============================

// Zip for Arrays
let orcs = ["Orc", "Orc 1", "Orc 2", "Orc 3", "Orc 4"]
let weapons = ["Mace", "Club", "BFG", "Rapier", "Scythe"]

let army = Array(zip(orcs, weapons))
army.map { "Unit: \($0.0) with \($0.1)" }
print(army.map { "Unit: \($0.0) Weapon: \($0.1)" })

// ============================ *** ============================

// Sort Array With Multiple Optional Criteria
struct Place {
    var rating: Int?
    var distance: Double?
}

func sortPlacesByRatingAndDistance(_ places: [Place]) -> [Place] {
    return places.sorted { filterOne, filterTwo in
        if filterOne.rating == filterTwo.rating {
            guard let distanceOne = filterOne.distance, let distanceTwo = filterTwo.distance else {
                return false
            }
            return distanceOne < distanceTwo
        }
        guard let ratingOne = filterOne.rating, let ratingTwo = filterTwo.rating else {
            return false
        }
        return ratingOne > ratingTwo
    }
}

var places = [Place(rating: 3, distance: 127),
              Place(rating: 4, distance: 423),
              Place(rating: 5, distance: nil),
              Place(rating: nil, distance: 100),
              Place(rating: nil, distance: 34),
              Place(rating: nil, distance: 34),
              Place(rating: nil, distance: nil)]

let sortedPlaces = sortPlacesByRatingAndDistance(places)

// ============================ *** ============================

// Remove first collection element that is equal to the given object
extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

// ============================ *** ============================

// Return the unique list of objects based on a given key
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set: Set<T> = []
        var arrayOrdered: [Element] = []
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}

// ============================ *** ============================

// Split String in to Words
extension String {
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter{!$0.isEmpty}
    }
}

let someLetter = "Here is Some letter, that I wrote to a girl."
print(someLetter.words)

// ============================ *** ============================

// Two Optionals Comparison
extension Optional: Comparable where Wrapped: Comparable {
    public static func < (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool {
        switch(lhs, rhs) {
        case (.some(let left), .some(let right)): return left < right
        case (.some, .none): return false
        case (.none, .some): return true
        case (nil, nil): return false
        }
    }
}

// ============================ *** ============================

// Two Optionals Comparison
extension Array where Element: Hashable {
    func after(item: Element) -> Element? {
        if let index = self.index(of: item), index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }
}

let araU = [1, 1, 2, 3, 4]
araU.after(item: 1)
