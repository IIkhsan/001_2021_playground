import Foundation

protocol Student {
    var name: String { get set }
    var hp: Int { get set }
    var damage: Int { get set }
    var slogan: String { get set }
    
    func attack(enemy: Student)
    func loseHP(damage: Int)
}

protocol Fraction {
    var teamname: String { get set }
    var arenaBuff: String { get set }
    var arenaDebuff: String { get set }
    var students: [RandomStudent] { get set }
    
    func Buff()
    func Debuff()
    func kick(student: RandomStudent)
}

protocol Arena {
    var pointer: Pointer { get set }
    var fractions: [Fraction] { get set }
        
    func startBattle()
}

class RandomStudent: Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var slogan: String
    
    func isAlive() -> Bool {
        if self.hp < 1 {
            return false
        }
        return true
    }
    
    func getName(name: String) {
        self.name = name
    }
    
    func attack(enemy: Student) {
        enemy.loseHP(damage: damage)
    }
        
    func loseHP(damage: Int) {
        self.hp -= damage
    }
    
    func getSlogan(slogan: String) {
            self.slogan = slogan
    }
        
    init() {
        self.name = ""
        self.slogan = ""
        self.hp = 100
        self.damage = 10
    }
}
    
class Nerds: FractionPointer, Fraction {
    
    var teamname: String = "Умники"
    var arenaBuff: String = "Библиотека"
    var arenaDebuff: String = "Задний двор"
    
    func Buff() {
        for student in students {
            student.hp += 10
            student.damage += 2
        }
    }
    
    func Debuff() {
        for student in students {
            student.damage -= 2
        }
    }
}

class Bullies: FractionPointer, Fraction {
    
    var teamname: String = "Задиры"
    var arenaBuff: String = "Задний двор"
    var arenaDebuff: String = "Библиотека"
    
    func Buff() {
        for student in students {
            student.hp += 10
            student.damage += 3
        }
    }
    
    func Debuff() {
        for student in students {
            student.damage -= 4
        }
    }
}

class Foodlovers: FractionPointer, Fraction {
    var teamname: String = "Любители покушать"
    var arenaBuff: String = "Столовая"
    var arenaDebuff: String = "Холл"
    
    func Buff() {
        for student in students {
            student.hp += 12
            student.damage += 3
        }
    }
    
    func Debuff() {
        for student in students {
            student.damage -= 3
        }
    }
}

class Activists: FractionPointer, Fraction {
    var teamname: String = "Активисты"
    var arenaBuff: String = "Холл"
    var arenaDebuff: String = "Столовая"
    
    func Buff() {
        for student in students {
            student.hp += 10
            student.damage += 3
        }
    }
    
    func Debuff() {
        for student in students {
            student.damage -= 4
        }
    }
}

class Pointer {
    var names: [String] = ["Mike", "Jack", "Michael", "Taylor", "John", "Trevor", "Travis", "Kevin",
                "Vincent", "Ben", "George", "Joseph" , "Frederico", "Robert", "Tom", "Chris",
                "Issac", "David", "Adam", "Alex", "Zack", "Loui", "Sam",
                "Casper", "Bill"]
    var fractions: [String] = ["Nerds", "Bullies", "Foodlovers", "Activists"]
    var areas: [String] = ["Библиотека", "Задний двор", "Столовая", "Холл"]
    var slogans: [String] = ["Мы победим, и это точно!", "Мы спортивны и сильны, да мы просто молодцы!", "Мы не ноем, и не стонем, даже тренера обгоним!", "Наша дружная команда, победить вас будет рада!", "Мы команда – лучше всех, нас поддерживает смех.", "Никого мы не боимся, и к победе мы стремимся!", "Начинай дрожать наш враг, победим мы – это факт!", "Мы обгоним хоть кого, мы команда О-ГО-ГО!", "То, что надо! Победит наша команда!", "Наша команда лучше всех! Сегодня ее ждет ее успех!", "Покорим мы всех, будет наш успех!"]
    
    func randomFraction() -> Fraction {
        let random = Int.random(in: 0...fractions.count - 1)
        let fraction = fractions[random]
        self.fractions.remove(at: random)
        
        switch fraction {
        case "Nerds":
            return Nerds()
        case "Bullies":
            return Bullies()
        case "Foodlovers":
            return Nerds()
        case "Activists":
            return Activists()
        default:
            return Foodlovers()
        }
    }
    func randomArea() -> String {
        return areas[Int.random(in: 0...3)]
    }
        
    func createStudentArray() -> [RandomStudent] {
        var students: [RandomStudent] = []
            
        for _ in 0...5 {
            let student: RandomStudent = RandomStudent()
            var random = Int.random(in: 0...names.count - 1)
            student.getName(name: names[random])
            names.remove(at: random)
            students.append(student)
            random = Int.random(in: 0...slogans.count - 1)
            student.getSlogan(slogan: slogans[random])
            slogans.remove(at: random)
        }
        return students
    }
    func end(fraction: Fraction) {
            print("Победила фракция \(fraction.teamname)")
    }
}
class FractionPointer {
    var students: [RandomStudent] = []
    
    func kick(student: RandomStudent) {
        for i in 0...students.count - 1 {
            if student.name == students[i].name {
                students.remove(at: i)
                break
            }
        }
    }
}

class GameProcess {
    var fractions: [Fraction] = []
    var pointer: Pointer = Pointer()
    
    func startGame() {
        fractions.append(pointer.randomFraction())
        fractions.append(pointer.randomFraction())
        let area = pointer.randomArea()
        print("----------")
        print("Начало боя")
        print("----------")
        print("Локация - \(area)")
        print("В бой вступают \(fractions[0].teamname) и \(fractions[1].teamname)\n")
        print("----------")
        
        for i in 0...1 {
                    fractions[i].students = pointer.createStudentArray()
                    if fractions[i].arenaBuff == area {
                        fractions[i].Buff()
                    }
                    else if fractions[i].arenaDebuff == area {
                        fractions[i].Debuff()
                    }
                }
        
        Process()
    }
    func fight(fraction1: Fraction, fraction2: Fraction) {
            let fraction1Count = fraction1.students.count - 1
            let fraction2Count = fraction2.students.count - 1
            
            print("Атакует команда - \(fraction1.teamname)\n")
            
            for i in 0...fraction1Count {
                let random = Int.random(in: 0...fraction2Count)
                print("\(fraction1.students[i].name) выкрикивает '\(fraction1.students[i].slogan)'")
                print("Он бьет \(fraction2.students[random].name) и наносит \(fraction1.students[i].damage) урона. У противника \(fraction2.students[random].name) теперь \(fraction2.students[random].hp) здоровья")
                fraction1.students[i].attack(enemy: fraction2.students[random])
            }
            
            for student in fraction2.students {
                if !student.isAlive() {
                    print("\(student.name) удаляется с арены\n")
                    fraction2.kick(student: student)
                }
            }
    }
        
    func Process() {
        var roundnumber = 1
        while true {
            print("Раунд - \(roundnumber)\n")
            fight(fraction1: fractions[0], fraction2: fractions[1])
            if !fractions[1].students.isEmpty {
                fight(fraction1: fractions[1], fraction2: fractions[0])
            }
            if fractions[1].students.isEmpty {
                pointer.end(fraction: fractions[0])
                break
            } else if fractions[0].students.isEmpty {
                pointer.end(fraction: fractions[1])
                break
            }
            roundnumber += 1
        }
    }
}
var game: GameProcess = GameProcess()
game.startGame()
