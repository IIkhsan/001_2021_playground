protocol Student : AnyObject {
    var name: String { get set }
    var hp: Int { get set }
    var damage: Int { get set }
    var gun: Gun? { get set }
    var batteCry: String { get set }
}

class Fraction {
    var name: String
    var teammates: [Student]
    init(name: String, teammates: [Student]) {
        self.name = name
        self.teammates = teammates
    }
}

protocol Arena {
    var firstFraction: Fraction { get set }
    var secondFraction: Fraction { get set }
    func startBattle()
}

enum Gun: Int {
    case pencil = 8
    case rock = 10
    case knife = 12
}

func teamHP(fraction: Fraction) -> Int {
    var teamHP = 0
    for student in fraction.teammates {
        teamHP += student.hp
    }
    return teamHP
}
    
func teamDMG(fraction: Fraction) -> Int {
    var teamDMG = 0
    for student in fraction.teammates {
        teamDMG += student.damage
    }
    return teamDMG
}

class Rocking: Student {
    var hp: Int = 24
    var damage: Int = 7
    var batteCry = "My muscles are so irresistible"
    var name: String
    var gun: Gun? {
        didSet {
            guard let weaponDamage = gun?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

class Geek: Student {
    var hp: Int = 21
    var damage: Int = 5
    var batteCry = "For the Azeroth!!!!"
    var name: String
    var gun: Gun? {
        didSet {
            guard let weaponDamage = gun?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

class RegularStudent: Student {
    var hp: Int = 18
    var damage: Int = 4
    var batteCry = "Lok'tar Ogar"
    var name: String
    var gun: Gun? {
        didSet {
            guard let weaponDamage = gun?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    init(name: String) {
        self.name = name
    }
}

class Nerd: Student {
    var hp: Int = 15
    var damage: Int = 3
    var batteCry = "Mrgl mrgl"
    var name: String
    var gun: Gun? {
        didSet {
            guard let weaponDamage = gun?.rawValue else {return}
            damage = weaponDamage
        }
    }
    init(name: String) {
        self.name = name
    }
}

func findLoot(team: Fraction) {
    print("Team \(team.name) is trying to get some loot")
    print()
    for teammate in team.teammates {
        let lootCheck = Int.random(in: 1...100)
        if (lootCheck <= 25) {
            print("Student \(teammate.name) will fight without any gun. I will destroy them with my hands")
            teammate.gun = nil
        }
        else if (lootCheck > 25 && lootCheck <= 60) {
            print("Student \(teammate.name) will fight with pencil. \(teammate.batteCry)")
            teammate.gun = Gun.pencil
        }
        else if (lootCheck > 60 && lootCheck <= 85) {
            print("Student \(teammate.name) will fight with rock. \(teammate.batteCry)")
            teammate.gun = Gun.rock
        }
        else if (lootCheck > 85) {
            print("Student \(teammate.name) will fight with knife. \(teammate.batteCry)")
            teammate.gun = Gun.knife
        }
        if (lootCheck % 10 == 0) {
            print("Student \(teammate.name) find protein bar. I FEEEEL POOOOWER")
            teammate.hp = teammate.hp + 4
        }
    }
    print()
}

class Bully: Arena {
    var firstFraction: Fraction
    var secondFraction: Fraction
    
    init(firstFraction: Fraction, secondFraction: Fraction) {
        self.firstFraction = firstFraction
        self.secondFraction = secondFraction
    }
    
    func startBattle() {
        let firstTeamHP = teamHP(fraction: firstFraction)
        let firstTeamDamage = teamDMG(fraction: firstFraction)
        let secondTeamHP    = teamHP(fraction: secondFraction)
        let secondTeamDamage = teamDMG(fraction: secondFraction)
        print("Lets fight begin!!!!")
        print("Stage loot...")
        print()
        findLoot(team: firstFraction)
        findLoot(team: secondFraction)
        var defeatedTeam: Fraction? = nil
        print("Battle start with team: \(firstFraction.name) and \(secondFraction.name)")
        print()
        
        if (firstTeamHP > secondTeamHP && firstTeamDamage > secondTeamDamage ) {
            defeatedTeam = secondFraction
        }
        if (firstTeamHP < secondTeamHP && firstTeamDamage < secondTeamDamage ) {
            defeatedTeam = firstFraction
        }
        if (firstTeamHP == secondTeamHP && firstTeamDamage > secondTeamDamage ) {
            defeatedTeam = secondFraction
        }
        if (firstTeamHP == secondTeamHP && firstTeamDamage < secondTeamDamage ) {
            defeatedTeam = firstFraction
        }
        if (firstTeamHP > secondTeamHP && firstTeamDamage == secondTeamDamage ) {
            defeatedTeam = secondFraction
        }
        if (firstTeamHP < secondTeamHP && firstTeamDamage == secondTeamDamage ) {
            defeatedTeam = firstFraction
        }
        if (firstTeamHP > secondTeamHP && firstTeamDamage < secondTeamDamage ) {
            let checkWinner = Bool.random()
            if (checkWinner == true) {
            defeatedTeam = firstFraction
            } else {
                defeatedTeam = secondFraction
            }
        }
        if (firstTeamHP < secondTeamHP && firstTeamDamage > secondTeamDamage ) {
            let checkWinner = Bool.random()
            if (checkWinner == false) {
            defeatedTeam = firstFraction
            } else {
                defeatedTeam = secondFraction
            }
        }
        if (firstTeamHP == secondTeamHP && firstTeamDamage == secondTeamDamage ) {
            let checkWinner = Bool.random()
            if (checkWinner == true) {
            defeatedTeam = secondFraction
            } else {
                defeatedTeam = firstFraction
            }
        }
        print("\(defeatedTeam!.name) lost their fight. GG")
    }
}

var team1 = Fraction (name: "Gangsters", teammates: [Rocking(name: "1"), Geek(name:"3"), Nerd(name: "4"), RegularStudent(name: "5")])
var team2 = Fraction (name: "BugUsers", teammates: [Rocking(name: "6"), Geek(name:"7"), Nerd(name: "8"), RegularStudent(name: "9")])
Bully(firstFraction: team1, secondFraction: team2).startBattle()
