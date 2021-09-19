//: [Previous](@previous)

import Foundation

protocol Student {
    var name: String { get set }
    var battleCry: String { get set }
    var hp: Double { get set }
    var armor: Double { get set }
    var resistance: Double { get set }
    var damage: Double { get set }
    
    func attack(enemy: Student)
    func loseHP(damage: Double, enemyResistance: Double)
    func loseArmor(damage: Double)
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
    var fractions: [Fraction] { get set }
    
    func startBattle()
}

class FractionHelper {
    var students: [RandomStudent] = []
    
    func kickStudent(student: RandomStudent) {
        self.students.removeAll { $0.name == student.name}
    }
}

class RandomStudent: Student {
    
    internal var name: String
    internal var battleCry: String
    var hp: Double
    var armor: Double
    var resistance: Double
    var damage: Double
    
    init(name: String, battleCry: String) {
        self.name = name
        self.battleCry = battleCry
        
        var random = Int.random(in: 90...110)
        self.hp = Double(random)
        
        random = Int.random(in: 0...20)
        self.armor = Double(random)
        
        self.resistance = 0
        
        self.damage = 10
    }
    
    func isAlive() -> Bool {
        if self.hp <= 0 {
            return false
        }
        return true
    }
    
    func attack(enemy: Student) {
        if enemy.armor <= 0 {
            enemy.loseHP(damage: self.damage, enemyResistance: enemy.resistance)
        } else {
            enemy.loseArmor(damage: self.damage)
        }
    }
    
    func loseArmor(damage: Double) {
        self.armor -= damage
    }
    
    func loseHP(damage: Double, enemyResistance: Double) {
        self.hp -= damage * (1 - resistance)
    }
}

class Athletes: FractionHelper, Fraction {
    var fractionName: String = "Athletes"
    var fractionArenaBuff: String = "SportsGround"
    var fractionArenaDebuff: String = "Library"
    
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
}

class Bullies: FractionHelper, Fraction {
    var fractionName: String = "Bullies"
    var fractionArenaBuff: String = "Backyard"
    var fractionArenaDebuff: String = "Cabinet"
    
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
}

class Nerds: FractionHelper, Fraction {
    var fractionName: String = "Nerds"
    var fractionArenaBuff: String = "Library"
    var fractionArenaDebuff: String = "Backyard"
    
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
}

class GoodGuys: FractionHelper, Fraction {
    var fractionName: String = "GoodGuys"
    var fractionArenaBuff: String = "Cabinet"
    var fractionArenaDebuff: String = "SportsGround"
    
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
}

class BattleArena: Arena {
    var fractions: [Fraction] = []
    
    func startBattle() {
        var fractionNames = ["Athletes", "Bullies", "Nerds", "GoodGuys"]
        
        for _ in 0...1 {
            let random = Int.random(in: 0...fractionNames.count - 1)
            fractionNames.remove(at: random)
            
            switch random {
            case 0:
                fractions.append(Athletes())
            case 1:
                fractions.append(Bullies())
            case 2:
                fractions.append(Nerds())
            case 3:
                fractions.append(GoodGuys())
            default:
                break
            }
        }
        
        let areas: [String] = ["SportsGround", "Library", "Backyard", "Cabinet"]
        let area = areas[Int.random(in: 0...areas.count - 1)]
        
        print("Будет будет на локации - \(area)\n")
        print("Сражаются \(fractions[0].fractionName) и \(fractions[1].fractionName)\n")

        var names: [String] =
                   ["Edison", "Xayvion", "Forrest", "Quinnton", "Nash", "Cruz", "Bronson", "Lorenzo",
                    "Vincent", "Xeno", "Quennel", "Miles" , "Isidro", "Luis", "Zakary", "Zechariah",
                    "Roberto", "Frederick", "Nelson", "Zain", "Justin", "Xanthos", "Patrick",
                    "Rodrigo", "Issac"]
        var battleCries: [String] =
                         ["Кавабанга!", "Мы русские, с нами Бог!", "Я люблю пиццу!", "Fus Ro Dah!",
                          "Juggernaaaaaaaut!", "Лок’тар огар!", "За Императора!", "Джеронимо!",
                          "Твоя душа будет моей!", "Навались!"]
        
        for i in 0...1 {
            var students: [RandomStudent] = []
            
            for _ in 0...Int.random(in: 2...4) {
                let randomName = Int.random(in: 0...names.count - 1)
                let randomBC = Int.random(in: 0...battleCries.count - 1)
                
                let student: RandomStudent = RandomStudent(name: names[randomName],
                                                           battleCry: battleCries[randomBC])
                
                names.remove(at: randomName)
                battleCries.remove(at: randomBC)
                
                students.append(student)
            }
            
            fractions[i].students = students
        }
        
        var i: Int = 0
        
        while true {
            print("Раунд - \(i)\n")
            fight(fraction1: fractions[0], fraction2: fractions[1])
            if !fractions[1].students.isEmpty {
                fight(fraction1: fractions[1], fraction2: fractions[0])
            }
            
            if fractions[1].students.isEmpty {
                print("Победила \(fractions[0].fractionName)")
                break
            } else if fractions[0].students.isEmpty {
                print("Победила \(fractions[1].fractionName)")
                break
            }
            
            i += 1
        }
    }
    
    func fight(fraction1: Fraction, fraction2: Fraction) {
        let fraction1Count = fraction1.students.count - 1
        let fraction2Count = fraction2.students.count - 1
        
        print("Атакует команда - \(fraction1.fractionName)\n")
        
        for i in 0...fraction1Count {
            let random = Int.random(in: 0...fraction2Count)
            print("\(fraction1.students[i].name) кричит '\(fraction1.students[i].battleCry)'")
            print("Он бьет \(fraction2.students[random].name) и наносит \(fraction1.students[i].damage) урона. С учетом брони и сопротивления у игрока \(fraction2.students[random].name) стало \(fraction2.students[random].hp) здоровья\n")
            fraction1.students[i].attack(enemy: fraction2.students[random])
            
        }
        
        for student in fraction2.students {
            if !student.isAlive() {
                print("\(student.name) покинул бой\n")
                fraction2.kickStudent(student: student)
            }
        }
    }
}

var a: BattleArena = BattleArena()
a.startBattle()
