import UIKit

protocol BattleStrategy {
    func makeShout(shout: String) -> String
}

final class Battle {
    var battle: BattleStrategy?
    
    func makeShout(shout: String) {
        battle?.makeShout(shout: shout)
    }
}

final class ForestBattle: BattleStrategy {
    func makeShout(shout: String) -> String {
        return "For The Elvin Forest"
    }
}

final class SeaBattle: BattleStrategy {
    func makeShout(shout: String) -> String {
        return "Is that a shark?"
    }
}

final class DesertBattle: BattleStrategy {
    func makeShout(shout: String) -> String {
        return "For Vol`Dun"
    }
}

let someBattle = Battle()

someBattle.battle = ForestBattle()
someBattle.battle = DesertBattle()
someBattle.battle = SeaBattle()

// Make some Shout at battle
//someBattle.makeShout(shout: "12")
