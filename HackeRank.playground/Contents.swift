import UIKit
import Foundation

func plusMinus(arr: [Int]) -> Void {
    print(Double( (arr.filter({ $0 > 0 }) ).count) / Double(arr.count) )
    print(Double( (arr.filter({ $0 < 0 }) ).count) / Double(arr.count) )
    print(Double( (arr.filter({ $0 == 0 }) ).count) / Double(arr.count) )
}

plusMinus(arr: [1, -2, 3, -4, 0, 2, 0])

func birthdayCakeCandles(ar: [Int]) -> Int {
    return ar.filter { $0 == ar.max() ?? 0 }.count
}

birthdayCakeCandles(ar: [4, 4, 3, 2, 1])

func timeConversion(s: String) -> String {
    let dateFormatter = DateFormatter()
    let newDateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "hh:mm:ssa"
    newDateFormatter.dateFormat = "HH:mm:ss"
    
    guard let actualTime = dateFormatter.date(from: s) else { return "" }
    return newDateFormatter.string(from: actualTime)
}

timeConversion(s: "07:05:45PM")

func compareTriplets(a: [Int], b: [Int]) -> [Int] {
    var aPoints = 0
    var bPoints = 0
    
    for i in 0..<a.count {
        if a[i] == b[i] {
            aPoints += 0
            bPoints += 0
        } else {
            a[i] > b[i] ? (aPoints += 1) : (bPoints += 1)
        }
    }
    return [aPoints, bPoints]
}

compareTriplets(a: [10, 11, 1], b: [9, 10, 2])
