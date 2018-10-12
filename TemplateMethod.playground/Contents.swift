import UIKit

class HordeWarrior {
    func bornBattleUnit() {
        fatalError("This method must be overriden in subclass")
    }
    
    func provideWeapon() {
        print("Provide Weapon for UNit")
    }
    
    func provideArmor() {
        print("Provide Armor for UNit")
    }
    
    func provideSpell() {
        print("Provide Spell for UNit")
    }
    
    func deadBattleUnit() {
        fatalError("This method must be overriden in subclass")
    }
    
    final func getReadyForBattle() {
        bornBattleUnit()
        provideWeapon()
        provideArmor()
        provideSpell()
        deadBattleUnit()
    }
}

class TaurenMage: HordeWarrior {
    override func bornBattleUnit() {
        print("Tauren was born for battle")
    }
    
    override func deadBattleUnit() {
        print("Go to nearest Spirit Tauren\n")
    }
}


class UndeadRogue: HordeWarrior {
    override func bornBattleUnit() {
        print("Undead was born for battle")
    }
    
    override func deadBattleUnit() {
        print("Go back to grave")
    }
}

let mage = TaurenMage()
mage.bornBattleUnit()

let rogue = UndeadRogue()
rogue.bornBattleUnit()
