import UIKit

// Some Classes Regarding Orc
class Weapon {
    func forgeWeapon() {
        print("Some Weapon")
    }
}

class UglyFace {
    func makeUglyFace() {
        print("Destroy Normal Face")
    }
}

class BattleRoar {
    func makeSomeRoar() {
        print("FOR THE HORDE!")
    }
}

// Make Orc
class OrcFactory {
    let forgeWeapon = Weapon()
    let makeUglyFace = UglyFace()
    let makeSomeRoar = BattleRoar()
    
    func orcProducer() {
        forgeWeapon.forgeWeapon()
        makeUglyFace.makeUglyFace()
        makeSomeRoar.makeSomeRoar()
    }
}

// Run Orc Factory
let orcFactory = OrcFactory()
orcFactory.orcProducer()
