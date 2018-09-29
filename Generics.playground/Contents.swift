import UIKit

// String and Int Comparable
let stringArray = ["a", "b", "c", "d", "e", "f", "g", "h"]
let integerArray = [2, 42, 3, 4, 7, 101]

fileprivate func findInputIndex (_ array: [String], letter: String) -> Int? {
    for (index, element) in array.enumerated() {
        if element == letter {
            return index
        }
    }
    
    return nil
}

// Comparable
fileprivate func findWithgeneric<T:Comparable> (_ array:[T], key:T) -> Int? {
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
fileprivate func anyNumberSum<E: Numeric>(lhs: E, rhs: E) -> E {
    return lhs + rhs
}

anyNumberSum(lhs: 5, rhs: 2.34)
anyNumberSum(lhs: -6, rhs: 10)
anyNumberSum(lhs: 0.0000005, rhs: 1)

// Decodable protocol
struct GoogleResponse: Decodable {
    let google: String
}

fileprivate func dataFetch<T: Decodable>(url: String, completion: @escaping (T) -> ()) {
    guard let url = URL(string: url) else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            // Do some stuff 🤔
            print(error.localizedDescription)
        }
        guard let data = data else { return }
        do {
            let fetchedObject = try JSONDecoder().decode(T.self, from: data)
            // Enjoy ❤️
            completion(fetchedObject)
        } catch(let jsonError) {
            // Do some stuff 🤔
            print(jsonError)
        }
        }.resume()
}

dataFetch(url: "google.com") { (google: GoogleResponse) in
    print(google.google)
}

