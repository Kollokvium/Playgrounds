import UIKit

// Core Component
protocol Character {
    func getHealth() -> Int
}

// Personolize Component
struct Kollokvium: Character {
    func getHealth() -> Int {
        return 100
    }
}

// Concrete Components
struct Orc: Character {
    func getHealth() -> Int {
        return 10
    }
}

struct Elf: Character {
    func getHealth() -> Int {
        return 5
    }
}

// Decorator -  implementation of Decorator
protocol CharacterType: Character {
    var base: Character { get }
}

// Concrete Decorators
struct Warlord: CharacterType {
    let base: Character
    
    func getHealth() -> Int {
        return 50 + base.getHealth()
    }
    
    // New responsibility
    func battleCry() {
        print("RAWR")
    }
}

struct Epic: CharacterType {
    let base: Character
    
    func getHealth() -> Int {
        return 30 + base.getHealth()
    }
}

let orc = Orc()
let orcHP = orc.getHealth()

let orcWarlord = Warlord(base: orc)
let orcWarlordHP = orcWarlord.getHealth()

let epicOrcWarlord = Epic(base: orcWarlord)
let epicOrcWarlordHP = epicOrcWarlord.getHealth()

let doubleEpicOrcWarlord = Epic(base: epicOrcWarlord)
let doubleEpicOrcWarlordHP = doubleEpicOrcWarlord.getHealth()

let elf = Elf()
let elfHP = elf.getHealth()

let elfWarlord = Warlord(base: elf)
let elfWarlordHP = elfWarlord.getHealth()

elfWarlord.battleCry()
