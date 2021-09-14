//: [Previous](@previous)

import Foundation

/// Mark: - Constants

struct StudentsBonuses {
    
    let damageBonus: Int
    let healthPointsBonus: Int
}

struct Constants {
    
    struct StudentsCount {
        
        static let minStudentsInFractionCount = 6
        static let maxStudentsInFractionCount = 8
    }
    
    static let ArenaBonuses: [String: [String: StudentsBonuses]] = [
        "PlainArena": [
            "Gryffindor": StudentsBonuses(damageBonus: 10,
                                          healthPointsBonus: 0),
            "Slytherin": StudentsBonuses(damageBonus: 5,
                                         healthPointsBonus: 5)
        ],
        "ForestArena": [
            "Hufflepuff": StudentsBonuses(damageBonus: 5,
                                          healthPointsBonus: 0),
            "Ravenclaw": StudentsBonuses(damageBonus: 5,
                                          healthPointsBonus: 10)
        ],
        "MountainArena": [
            "Gryffindor": StudentsBonuses(damageBonus: 5,
                                          healthPointsBonus: 5),
            "Hufflepuff": StudentsBonuses(damageBonus: 0,
                                          healthPointsBonus: 10)
        ],
        "PavedArena": [
            "Slytherin": StudentsBonuses(damageBonus: 0,
                                         healthPointsBonus: 5),
            "Ravenclaw": StudentsBonuses(damageBonus: 5,
                                         healthPointsBonus: 0)
        ]
    ]
}

/// Mark: - Weapons

protocol Weapon {
    
    var name: String { get }
    var damage: Int { get set }
    var _ammo: Int { get set }
    var ammo: Int { get }
    
    init(named name: String)
    
    mutating func shoot() -> Int
    
    mutating func addDamageBonus(valued damageBonus: Int)
}

extension Weapon {
    
    var ammo: Int {
        return _ammo
    }
    
    mutating func shoot() -> Int {
        if _ammo > 0 {
            _ammo -= 1
            return damage
        } else {
            return 0
        }
    }
    
    mutating func addDamageBonus(valued damageBonus: Int) {
        if damageBonus > 0 {
            damage += damageBonus
        }
    }
}

struct Pistol: Weapon {
    
    var name: String
    var damage: Int = 15
    var _ammo: Int = 3
    
    init(named name: String) {
        self.name = name
    }
}

struct SubmachineGun: Weapon {
    
    var name: String
    var damage: Int = 25
    var _ammo: Int = 5
    
    init(named name: String) {
        self.name = name
    }
}

struct MachineGun: Weapon {
    
    var name: String
    var damage: Int = 35
    var _ammo: Int = 8
    
    init(named name: String) {
        self.name = name
    }
}

struct Rifle: Weapon {
    
    var name: String
    var damage: Int = 45
    var _ammo: Int = 10
    
    init(named name: String) {
        self.name = name
    }
}

/// Mark: - Students

protocol Student {
    
    var name: String { get }
    var healthPoints: Int { get }
    var battleCry: String { get }
    
    var fractionName: String { get }
    var weapons: [Weapon] { get }
    var currentWeapon: Weapon? { get }
    var damageBonus: Int? { get set }
    var healthPointsBonus: Int? { get set }
    var isAlive: Bool { get }
    
    func attack(to enemy: Student)
    func takeDamage(sized damageSize: Int)
}

class Shooter: Student {
    
    var name: String
    var healthPoints: Int = 100
    var battleCry: String = "Let's go!"
    
    var fractionName: String
    var weapons: [Weapon] = []
    var currentWeapon: Weapon?
    var damageBonus: Int? {
        willSet {
            guard let damageBonus = newValue else { return }
            currentWeapon?.damage += damageBonus
        }
    }
    var healthPointsBonus: Int? {
        willSet {
            guard let healthPointsBonus = newValue else { return }
            healthPoints += healthPointsBonus
        }
    }
    var isAlive: Bool {
        return healthPoints > 0
    }
    
    init(name: String, fractionName: String) {
        self.name = name
        self.fractionName = fractionName
        currentWeapon = weapons.first
    }
    
    func attack(to enemyStudent: Student) {
        if currentWeapon?.ammo == 0 {
            if !weapons.isEmpty {
                weapons.removeFirst()
            }
            currentWeapon = weapons.first
        }
        if currentWeapon != nil {
            print("🗣\(name) (\(fractionName)) - \(battleCry)")
            print("🔫\(name) (\(fractionName)) attacks \(enemyStudent.name) (\(enemyStudent.fractionName)) using \(currentWeapon!.name)")
            enemyStudent.takeDamage(sized: currentWeapon!.shoot())
        } else {
            currentWeapon = weapons.first
        }
        if !enemyStudent.isAlive {
            if let enemyWeapon = enemyStudent.currentWeapon {
                weapons.append(enemyWeapon)
            }
            print("\(enemyStudent.name) (\(enemyStudent.fractionName)) is down!")
        }
    }
    
    func takeDamage(sized damageSize: Int) {
        healthPoints -= damageSize
    }
}

class Freshman: Shooter {
    
    override init(name: String, fractionName: String) {
        super.init(name: name, fractionName: fractionName)
        battleCry = "Let's go get 'em!"
        weapons.append(Pistol(named: "Desert Eagle"))
    }
}

class Sophomore: Shooter {
    
    override init(name: String, fractionName: String) {
        super.init(name: name, fractionName: fractionName)
        battleCry = "Watch out, here I come!"
        weapons.append(SubmachineGun(named: "MAC-10"))
    }
}

class Junior: Shooter {
    
    override init(name: String, fractionName: String) {
        super.init(name: name, fractionName: fractionName)
        battleCry = "Don't mess with me!"
        weapons.append(MachineGun(named: "AK-47"))
    }
}

class Senior: Shooter {
    
    override init(name: String, fractionName: String) {
        super.init(name: name, fractionName: fractionName)
        battleCry = "I fight for my ancestors!"
        weapons.append(Rifle(named: "AWP"))
    }
}

/// Mark: - Fractions

protocol Fraction {
    
    var fractionName: String { get }
    var students: [Student] { get set }
    var isAlive: Bool { get }
    
    init(with students: [Student]?)
    
    func randomStudent() -> Student?
    func attack(to enemyFraction: Fraction)
    func addBonusesForStudents(in arena: Arena)
    mutating func stats() -> String
}

extension Fraction {
    
    var fractionName: String {
        return String(describing: type(of: self))
    }
    var isAlive: Bool {
        return !students.filter({ $0.isAlive }).isEmpty
    }
    
    func randomStudent() -> Student? {
        return students.filter({ $0.isAlive }).randomElement()
    }
    
    func attack(to enemyFraction: Fraction) {
        for student in students.filter({ $0.isAlive }) {
            guard enemyFraction.isAlive else { break }
            student.attack(to: enemyFraction.randomStudent()!)
        }
    }
    
    func addBonusesForStudents(in arena: Arena) {
        let arenaName = String(describing: type(of: arena))
        let fractionName = String(describing: type(of: self))
        let damageBonus: Int = Constants.ArenaBonuses[arenaName]?[fractionName]?.damageBonus ?? 0
        let healthPointsBonus: Int = Constants.ArenaBonuses[arenaName]?[fractionName]?.healthPointsBonus ?? 0
        for var student in students {
            student.damageBonus = damageBonus
            student.healthPointsBonus = healthPointsBonus
        }
    }
    
    mutating func stats() -> String {
        let deadStudentsCount = students.filter({ !$0.isAlive }).count
        let stats = "\(fractionName) lost \(deadStudentsCount) students out of \(students.count)"
        students = students.filter({ $0.isAlive })
        return stats
    }
}

class HogwartsHouse: Fraction {
    
    var students: [Student] = []
    
    required init(with students: [Student]?) {
        if let students = students {
            self.students = students
        } else {
            self.students = generateStudentsForFraction(named: String(describing: type(of: self)))
        }
    }
}

class Gryffindor: HogwartsHouse {}

class Slytherin: HogwartsHouse {}

class Ravenclaw: HogwartsHouse {}

class Hufflepuff: HogwartsHouse {}

/// Mark: - Arenas

protocol Arena {
    
    var fractions: [Fraction] { get set }
    
    init(for fraction1: Fraction, and fraction2: Fraction)
    mutating func startBattle()
    mutating func addArenaFeatures()
}

extension Arena {
    
    mutating func startBattle() {
        print("""
        \nStarting battle between \(fractions[0].fractionName) \
        and \(fractions[1].fractionName) on \
        \(String(describing: type(of: self))):
        """)
        while fractions[0].isAlive, fractions[1].isAlive {
            fractions.shuffle()
            fractions[0].attack(to: fractions[1])
            fractions[1].attack(to: fractions[0])
        }
        let aliveFraction = fractions.filter({ $0.isAlive })[0]
        print("\n🎊Fraction \(aliveFraction.fractionName) wins🎉")
        print("📊Casualties: \(fractions[0].stats())")
        print("              \(fractions[1].stats())")
    }
    
    func addArenaFeatures() {
        for fraction in fractions {
            fraction.addBonusesForStudents(in: self)
        }
    }
}

class BattleArena: Arena {
    
    var fractions: [Fraction] = []
    
    required init(for fraction1: Fraction, and fraction2: Fraction) {
        fractions = [fraction1, fraction2]
        addArenaFeatures()
    }
}

class PlainArena: BattleArena {}

class ForestArena: BattleArena {}

class MountainArena: BattleArena {}

class PavedArena: BattleArena {}

/// Mark: - Helper function

func generateStudentsForFraction(named fractionName: String) -> [Student] {
    var fractionStudents: [Student] = []
    let leftBound = Constants.StudentsCount.minStudentsInFractionCount,
        rightBound = Constants.StudentsCount.maxStudentsInFractionCount
    for i in 0..<Int.random(in: leftBound...rightBound) {
        if i % 4 == 0 {
            let name = "Freshman" + String(i / 4 + 1)
            fractionStudents.append(Freshman(name: name, fractionName: fractionName))
        } else if i % 4 == 1 {
            let name = "Sophomore" + String(i / 4 + 1)
            fractionStudents.append(Sophomore(name: name, fractionName: fractionName))
        } else if i % 4 == 2 {
            let name = "Junior" + String(i / 4 + 1)
            fractionStudents.append(Junior(name: name, fractionName: fractionName))
        } else if i % 4 == 3 {
            let name = "Senior" + String(i / 4 + 1)
            fractionStudents.append(Senior(name: name, fractionName: fractionName))
        }
    }
    return fractionStudents
}

/// Mark: - Entry point

func main() {
    var fractions: [Fraction] = [Gryffindor(with: nil), Slytherin(with: nil),
                                 Ravenclaw(with: nil), Hufflepuff(with: nil)]
    fractions.shuffle()
    
    var arenaTypes = [PlainArena.self, ForestArena.self, MountainArena.self, PavedArena.self] as [Arena.Type]
    
    let arena1Index = Int.random(in: 0...3)
    var arena1 = arenaTypes[arena1Index].init(for: fractions[0], and: fractions[1])
    arena1.startBattle()
    arenaTypes.remove(at: arena1Index)
    
    let arena2Index = Int.random(in: 0...2)
    var arena2 = arenaTypes[arena2Index].init(for: fractions[2], and: fractions[3])
    arena2.startBattle()
    arenaTypes.remove(at: arena2Index)
    
    fractions = fractions.filter({ $0.isAlive })
    let arena3Index = Int.random(in: 0...1)
    var arena3 = arenaTypes[arena3Index].init(for: fractions[0], and: fractions[1])
    arena3.startBattle()
    
    print("\n🦾WINNER: \(fractions[0].isAlive ? fractions[0].fractionName : fractions[1].fractionName)")
}

main()

//: [Next](@next)
