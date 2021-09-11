//: [Previous](@previous)

import Foundation

let MINSTUDENTSINFRACTIONCOUNT = 6
let MAXSTUDENTSINFRACTIONCOUNT = 8

struct Weapon {
    
    let name: String
    let damage: Int
    private var _ammo: Int
    var ammo: Int {
        return _ammo
    }
    
    init(named name: String, damage: Int, ammo: Int) {
        self.name = name
        self.damage = damage
        self._ammo = ammo
    }
    
    mutating func shoot() -> Int {
        if _ammo > 0 {
            _ammo -= 1
            return damage
        } else {
            return 0
        }
    }
}

enum FractionName: String, CaseIterable {
    //TODO: - проверить, можно ли не писать литералы
    case Gryffindor = "Gryffindor"
    case Slytherin = "Slytherin"
    case Ravenclaw
    case Hufflepuff
}

protocol Student {
    
    var name: String { get }
    var healthPoints: Int { get }
    var damage: Int! { get }
    var battleCry: String! { get }
    
    var fractionName: FractionName { get }
    var weapons: [Weapon] { get }
    var currentWeapon: Weapon! { get }
    var damageBonus: Int? { get set }
    var healthPointsBonus: Int? { get set }
    var isAlive: Bool { get }
    
    func attack(to enemy: Student)
    func takeDamage(sized damageSize: Int)
}

class Shooter: Student {
    
    var name: String
    var healthPoints: Int = 100
    var damage: Int!
    var battleCry: String!
    
    var fractionName: FractionName
    var weapons: [Weapon] = []
    var currentWeapon: Weapon!
    var damageBonus: Int? {
        willSet {
            guard let damageBonus = newValue else { return }
            damage += damageBonus
        }
    }
    var healthPointsBonus: Int? {
        willSet {
            guard let healthPointsBonus = newValue else { return }
            damage += healthPointsBonus
        }
    }
    var isAlive: Bool {
        return healthPoints > 0
    }
    
    init(name: String, fractionName: FractionName) {
        self.name = name
        self.fractionName = fractionName
    }
    
    func attack(to enemy: Student) {
        print("🗣\(name) (\(fractionName)) - \(battleCry!)")
        if currentWeapon.ammo == 0 {
            if weapons.count > 0 {
                weapons.removeFirst()
            }
            if weapons.count > 0 {
                currentWeapon = weapons[0]
            }
        }
        print("🔫\(name) (\(fractionName)) attacks \(enemy.name) (\(enemy.fractionName)) using \(currentWeapon.name)")
        enemy.takeDamage(sized: currentWeapon.shoot())
        if !enemy.isAlive {
            weapons.append(enemy.currentWeapon)
            print("\(enemy.name) (\(enemy.fractionName)) is down!")
        }
    }
    
    func takeDamage(sized damageSize: Int) {
        healthPoints -= damageSize
    }
}

class Freshman: Shooter {
    
    override init(name: String, fractionName: FractionName) {
        super.init(name: name, fractionName: fractionName)
        damage = 15
        battleCry = "Let's go get 'em!"
        weapons.append(Weapon(named: "Desert Eagle", damage: damage, ammo: 3))
        currentWeapon = weapons[0]
    }
}

class Sophomore: Shooter {
    
    override init(name: String, fractionName: FractionName) {
        super.init(name: name, fractionName: fractionName)
        damage = 25
        battleCry = "Watch out, here I come!"
        weapons.append(Weapon(named: "MAC-10", damage: damage, ammo: 5))
        currentWeapon = weapons[0]
    }
}

class Junior: Shooter {
    
    override init(name: String, fractionName: FractionName) {
        super.init(name: name, fractionName: fractionName)
        damage = 35
        battleCry = "Don't mess with me!"
        weapons.append(Weapon(named: "AK-47", damage: damage, ammo: 8))
        currentWeapon = weapons[0]
    }
}

class Senior: Shooter {
    
    override init(name: String, fractionName: FractionName) {
        super.init(name: name, fractionName: fractionName)
        damage = 45
        battleCry = "I fight for my ancestors!"
        weapons.append(Weapon(named: "AWP", damage: damage, ammo: 10))
        currentWeapon = weapons[0]
    }
}

class Fraction {
    
    let fractionName: FractionName
    var students: [Student]
    var isAlive: Bool {
        return students.filter({ $0.isAlive }).count > 0
    }
    
    init(named fractionName: FractionName,
         with students: [Student]?) {
        self.fractionName = fractionName
        self.students = students ?? []
    }
    
    func randomStudent() -> Student? {
        return students.filter({ $0.isAlive }).randomElement()
    }
    
    func addStudent(_ student: Student) {
        students.append(student)
    }
    
    func attack(to enemyFraction: Fraction) {
        for student in students.filter({ $0.isAlive }) {
            guard enemyFraction.isAlive else { break }
            student.attack(to: enemyFraction.randomStudent()!)
        }
    }
    
    func addBonusesForStudents(damageBonus: Int,
                               healthPointsBonus: Int) {
        for var student in students {
            student.damageBonus = damageBonus
            student.healthPointsBonus = healthPointsBonus
        }
    }
    
    func stats() -> String {
        let deadStudentsCount = students.filter({ !$0.isAlive }).count
        let stats = "\(fractionName) lost \(deadStudentsCount) students out of \(students.count)"
        students = students.filter({ $0.isAlive })
        return stats
    }
}

protocol Arena {
    
    var fractions: [Fraction] { get set }
    
    init(for fraction1: Fraction, and fraction2: Fraction)
    mutating func startBattle()
    mutating func addArenaFeatures()
}

extension Arena {
    
    mutating func startBattle() {
        print("\nStarting battle between \(fractions[0].fractionName) and \(fractions[1].fractionName):")
        while fractions[0].isAlive, fractions[1].isAlive {
            fractions.shuffle()
            fractions[0].attack(to: fractions[1])
            fractions[1].attack(to: fractions[0])
        }
        let aliveFraction = fractions.filter({ $0.isAlive })[0]
        print("\n🎊Fraction \(aliveFraction.fractionName) wins🎉")
        print("📊Casualties: \(fractions[0].stats())")
        print("              \(fractions[1].stats())")
//        let fraction0DeadStudentsCount = fractions[0].students.filter({ !$0.isAlive }).count
//        print("📊Casualties: \(fractions[0].fractionName) lost \(fraction0DeadStudentsCount) students out of \(fractions[0].students.count)")
//        let fraction1DeadStudentsCount = fractions[1].students.filter({ !$0.isAlive }).count
//        print("              \(fractions[1].fractionName) lost \(fraction1DeadStudentsCount) students out of \(fractions[1].students.count)")
    }
}

class PlainArena: Arena {
    
    var fractions: [Fraction] = []
    
    required init(for fraction1: Fraction, and fraction2: Fraction) {
        fractions = [fraction1, fraction2]
        addArenaFeatures()
    }
    
    func addArenaFeatures() {
        for fraction in fractions {
            switch fraction.fractionName {
            case .Gryffindor:
                fraction.addBonusesForStudents(damageBonus: 10, healthPointsBonus: 0)
            case .Slytherin:
                fraction.addBonusesForStudents(damageBonus: 5, healthPointsBonus: 5)
            default:
                continue
            }
        }
    }
}

class ForestArena: Arena {
    
    var fractions: [Fraction] = []
    
    required init(for fraction1: Fraction, and fraction2: Fraction) {
        fractions = [fraction1, fraction2]
        addArenaFeatures()
    }
    
    func addArenaFeatures() {
        for fraction in fractions {
            switch fraction.fractionName {
            case .Hufflepuff:
                fraction.addBonusesForStudents(damageBonus: 5, healthPointsBonus: 0)
            case .Ravenclaw:
                fraction.addBonusesForStudents(damageBonus: 5, healthPointsBonus: 10)
            default:
                continue
            }
        }
    }
}

class MountainArena: Arena {
    
    var fractions: [Fraction] = []
    
    required init(for fraction1: Fraction, and fraction2: Fraction) {
        fractions = [fraction1, fraction2]
        addArenaFeatures()
    }
    
    func addArenaFeatures() {
        for fraction in fractions {
            switch fraction.fractionName {
            case .Gryffindor:
                fraction.addBonusesForStudents(damageBonus: 5, healthPointsBonus: 5)
            case .Hufflepuff:
                fraction.addBonusesForStudents(damageBonus: 0, healthPointsBonus: 10)
            default:
                continue
            }
        }
    }
}

class PavedArena: Arena {
    
    var fractions: [Fraction] = []
    
    required init(for fraction1: Fraction, and fraction2: Fraction) {
        fractions = [fraction1, fraction2]
        addArenaFeatures()
    }
    
    func addArenaFeatures() {
        for fraction in fractions {
            switch fraction.fractionName {
            case .Slytherin:
                fraction.addBonusesForStudents(damageBonus: 0, healthPointsBonus: 5)
            case .Ravenclaw:
                fraction.addBonusesForStudents(damageBonus: 5, healthPointsBonus: 0)
            default:
                continue
            }
        }
    }
}

func generateStudentsForFraction(named fractionName: FractionName) -> [Student] {
    var fractionStudents: [Student] = []
    let leftBound = MINSTUDENTSINFRACTIONCOUNT,
        rightBound = MAXSTUDENTSINFRACTIONCOUNT
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

func main() {
    var fractions: [Fraction] = []
    for name in FractionName.allCases {
        let students = generateStudentsForFraction(named: name)
        fractions.append(Fraction(named: name, with: students))
    }
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
