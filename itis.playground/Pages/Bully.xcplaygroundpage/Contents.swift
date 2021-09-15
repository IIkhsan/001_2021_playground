//: [Previous](@previous)

import Foundation

protocol Student {
    var name: String { get set }
    var battleCry: String { get set }
    var hp: Double { get set }
    var armor: Double { get set }
    var resistance: Double { get set }
    var damage: Double { get set }
    //var feature: String { get set }
    
    func attack(enemy: Student)
    func loseHP(damage: Double)
}
//: [Next](@next)
protocol Fraction {
    var fractionName: String { get set }
    var fractionArenaBuff: String { get set }
    var fractionArenaDebuff: String { get set }
    var students: [RandomStudent] { get set }
    
    func arenaBuff()
    func arenaDebuff()
    func kickStudent(student: RandomStudent)
}

protocol Arena {
    var helper: Helper { get set }
    var fractions: [Fraction] { get set }
    
    func startBattle()
}

class RandomStudent: Student {
    
    internal var name: String
    internal var battleCry: String
    var hp: Double
    var armor: Double
    var resistance: Double
    var damage: Double
    //var feature: String
    
    func isAlive() -> Bool {
        if self.hp <= 0 {
            return false
        }
        return true
    }
    
    func getName(name: String) {
        self.name = name
    }
    
    func getBattleCry(battlecry: String) {
        self.battleCry = battlecry
    }
    
    func attack(enemy: Student) {
        enemy.loseHP(damage: self.damage)
    }
    
    func loseHP(damage: Double) {
        self.hp -= damage
    }
    
    init() {
        self.name = ""
        self.battleCry = ""
        
        var random = Int.random(in: 90...110)
        self.hp = Double(random)
        
        random = Int.random(in: 0...20)
        self.armor = Double(random)
        
        self.resistance = 0
        
        self.damage = 10
    }
}

class Helper {
    var names: [String] =
               ["Edison", "Xayvion", "Forrest", "Quinnton", "Nash", "Cruz", "Bronson", "Lorenzo",
                "Vincent", "Xeno", "Quennel", "Miles" , "Isidro", "Luis", "Zakary", "Zechariah",
                "Roberto", "Frederick", "Nelson", "Zain", "Justin", "Xanthos", "Patrick",
                "Rodrigo", "Issac"]
    var battleCries: [String] =
                     ["Кавабанга!", "Мы русские, с нами Бог!", "Я люблю пиццу!", "Fus Ro Dah!",
                      "Juggernaaaaaaaut!", "Лок’тар огар!", "За Императора!", "Джеронимо!",
                      "Твоя душа будет моей!", "Навались!"]
    var fractions: [String] =
                   ["Athletes", "Bullies", "Nerds", "GoodGuys"]
    var areas: [String] =
                   ["SportsGround", "Library", "Backyard", "Cabinet"]
    
    func randomFraction() -> Fraction {
        let random = Int.random(in: 0...fractions.count - 1)
        let fraction = fractions[random]
        self.fractions.remove(at: random)
        
        switch fraction {
        case "Athletes":
            return Athletes()
        case "Bullies":
            return Bullies()
        case "Nerds":
            return Nerds()
        case "GoodGuys":
            return GoodGuys()
        default:
            return Athletes()
        }
    }
    
    func randomArea() -> String {
        return areas[Int.random(in: 0...3)]
    }
    
    func createStudentArray() -> [RandomStudent] {
        var students: [RandomStudent] = []
        
        for _ in 0...Int.random(in: 2...4) {
            let student: RandomStudent = RandomStudent()
            
            var random = Int.random(in: 0...names.count - 1)
            student.getName(name: names[random])
            names.remove(at: random)
            
            random = Int.random(in: 0...battleCries.count - 1)
            student.getBattleCry(battlecry: battleCries[random])
            battleCries.remove(at: random)
            
            students.append(student)
        }
        
        return students
    }
    
    func end(fraction: Fraction) {
        print("Победила \(fraction.fractionName)")
    }
}

class Athletes: Fraction {
    var fractionName: String = "Athletes"
    var fractionArenaBuff: String = "SportsGround"
    var fractionArenaDebuff: String = "Library"
    
    var students: [RandomStudent] = []
    
    func arenaBuff() {
        for student in students {
            student.hp += 10
            student.armor += 10
            student.resistance += 10
        }
    }
    
    func arenaDebuff() {
        for student in students {
            student.resistance = 0
            student.armor = 0
        }
    }
    
    func kickStudent(student: RandomStudent) {
        for i in 0...students.count - 1 {
            if student.name == students[i].name {
                students.remove(at: i)
                break
            }
        }
    }
}

class Bullies: Fraction {
    var fractionName: String = "Bullies"
    var fractionArenaBuff: String = "Backyard"
    var fractionArenaDebuff: String = "Cabinet"
    
    var students: [RandomStudent] = []
    
    func arenaBuff() {
        for student in students {
            student.damage += 7
        }
    }
    
    func arenaDebuff() {
        for student in students {
            student.hp -= 20
            student.armor = 0
            student.damage -= 5
        }
    }
    
    func kickStudent(student: RandomStudent) {
        for i in 0...students.count - 1 {
            if student.name == students[i].name {
                students.remove(at: i)
                break
            }
        }
    }
}

class Nerds: Fraction {
    var fractionName: String = "Nerds"
    var fractionArenaBuff: String = "Library"
    var fractionArenaDebuff: String = "Backyard"
    
    var students: [RandomStudent] = []
    
    func arenaBuff() {
        for student in students {
            student.hp += 50
            student.armor += 20
            student.resistance += 20
        }
    }
    
    func arenaDebuff() {
        for student in students {
            student.resistance = 0
            student.armor = 0
            student.hp -= 30
        }
    }
    
    func kickStudent(student: RandomStudent) {
        for i in 0...students.count - 1 {
            if student.name == students[i].name {
                students.remove(at: i)
                break
            }
        }
    }
}

class GoodGuys: Fraction {
    var fractionName: String = "GoodGuys"
    var fractionArenaBuff: String = "Cabinet"
    var fractionArenaDebuff: String = "SportsGround"
    
    var students: [RandomStudent] = []
    
    func arenaBuff() {
        for student in students {
            student.damage += 5
            student.resistance += 30
        }
    }
    
    func arenaDebuff() {
        for student in students {
            student.hp -= 10
            student.armor = 0
            student.resistance = 0
            student.damage -= 3
        }
    }
    
    func kickStudent(student: RandomStudent) {
        for i in 0...students.count - 1 {
            if student.name == students[i].name {
                students.remove(at: i)
                break
            }
        }
    }
}

class BattleArena: Arena {
    var helper: Helper = Helper()
    var fractions: [Fraction] = []
    
    func startBattle() {
        fractions.append(helper.randomFraction())
        fractions.append(helper.randomFraction())
        
        let area = helper.randomArea()
        
        print("Будет будет на локации - \(area)")
        print()
        print("Сражаются \(fractions[0].fractionName) и \(fractions[1].fractionName)")

        for i in 0...1 {
            fractions[i].students = helper.createStudentArray()
            if fractions[i].fractionArenaBuff == area {
                fractions[i].arenaBuff()
            }
            else if fractions[i].fractionArenaDebuff == area {
                fractions[i].arenaDebuff()
            }
        }
        while true {
            fight(fraction1: fractions[0], fraction2: fractions[1])
            if !fractions[1].students.isEmpty {
                fight(fraction1: fractions[1], fraction2: fractions[0])
            }
            
            if fractions[1].students.isEmpty {
                helper.end(fraction: fractions[0])
                break
            }
            else if fractions[0].students.isEmpty {
                helper.end(fraction: fractions[1])
                break
            }
        }
    }
    
    func fight(fraction1: Fraction, fraction2: Fraction) {
        let fraction1Count = fraction1.students.count - 1
        let fraction2Count = fraction2.students.count - 1
        
        for i in 0...fraction1Count {
            let random = Int.random(in: 0...fraction2Count)
            print()
            print("\(fraction1.students[i].name) кричит '\(fraction1.students[i].battleCry)'")
            print("Он бьет \(fraction2.students[random].name) и наносит \(fraction1.students[i].damage) урона")
            print()
            fraction1.students[i].attack(enemy: fraction2.students[random])
        }
        
        for student in fraction2.students {
            if !student.isAlive() {
                print("\(student.name) погиб")
                print()
                fraction2.kickStudent(student: student)
            }
        }
    }
}

var a: BattleArena = BattleArena()
a.startBattle()

