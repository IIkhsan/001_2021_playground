import Foundation

// Third Task

protocol StudentProtocol {
    var health: Double { get set }
    var damage: Double { get set }
    var chant: String { get set }
    var name: String { get set }
    var fraction: Fraction { get set }
    
    func attack(enemy: Student, studentsOfFirstFraction: [Student], studentsOfSecondFraction: [Student], countOfStudentsInFractions: Int, temporary: Int, countOfFirstFractionWins: Int, countOfSecondFractionWins: Int)
}

protocol ArenaProtocol {
    var firstFraction: Fraction { get set }
    var secondFraction: Fraction { get set }
    
    func startBattle()
}

class Fraction {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Arena: ArenaProtocol {
    var firstFraction: Fraction
    var secondFraction: Fraction
    
    init(firstFraction: Fraction, secondFraction: Fraction) {
        self.firstFraction = firstFraction
        self.secondFraction = secondFraction
    }
    
    func startBattle() {
        print("Да начнется битва!")
        print("Давайте поприветствуем наши команды \(firstFraction.name), \(secondFraction.name)")
        
        let countOfStudentsInFractions = 3
        let countOfFirstFractionWins: Int = 0
        let countOfSecondFractionWins: Int = 0
        let studentsOfFirstFraction: [Student] = [Student(health: 500, damage: 300, chant: "Салам алейкум", name: "Ашот", fraction:Fraction(name:"tennis")), Student(health: 400, damage: 200, chant: "Привет", name: "Саша", fraction: Fraction(name: "football")), Student(health: 300, damage: 100, chant: "Здоров", name: "Данил", fraction: Fraction(name: "basketball"))]
        let studentsOfSecondFraction: [Student] = [Student(health: 600, damage: 100, chant: "Я здесь", name: "Виктор", fraction:Fraction(name:"pop music")), Student(health: 800, damage: 300, chant: "Жизнь поворам", name: "Василий", fraction: Fraction(name: "rap music")), Student(health: 800, damage: 50, chant: "Один за всех", name: "Федор", fraction: Fraction(name: "rock music"))]
        
        for temporary in 0..<countOfStudentsInFractions {
            print("Атакующий \(studentsOfFirstFraction[temporary].name) - \(studentsOfFirstFraction[temporary].chant)")
            print("Защищающийся \(studentsOfSecondFraction[temporary].name) - \(studentsOfSecondFraction[temporary].chant)")
            studentsOfFirstFraction[temporary].attack(enemy: studentsOfSecondFraction[temporary], studentsOfFirstFraction: studentsOfFirstFraction, studentsOfSecondFraction: studentsOfSecondFraction, countOfStudentsInFractions: countOfStudentsInFractions, temporary: temporary, countOfFirstFractionWins: countOfFirstFractionWins, countOfSecondFractionWins: countOfSecondFractionWins)
        }
    }
}


class Student: StudentProtocol {
    var health: Double
    var damage: Double
    var chant: String
    var name: String
    var fraction: Fraction
    
    init(health: Double, damage: Double, chant: String, name: String, fraction: Fraction) {
        self.health = health
        self.damage = damage
        self.chant = chant
        self.name = name
        self.fraction = fraction
    }
    
    func attack(enemy: Student, studentsOfFirstFraction: [Student], studentsOfSecondFraction: [Student], countOfStudentsInFractions: Int, temporary: Int, countOfFirstFractionWins: Int, countOfSecondFractionWins: Int) {
        var countOfFirstFractionWins: Int = 0
        var countOfSecondFractionWins: Int = 0
        
        switch (true) {
        case (studentsOfFirstFraction[temporary].health > studentsOfSecondFraction[temporary].health) && (studentsOfFirstFraction[temporary].damage > studentsOfSecondFraction[temporary].damage):
            print("В данном противостоянии победа осталась за \(studentsOfFirstFraction[temporary].name)")
            countOfFirstFractionWins += 1
            break
        case (studentsOfFirstFraction[temporary].health < studentsOfSecondFraction[temporary].health) && (studentsOfFirstFraction[temporary].damage < studentsOfSecondFraction[temporary].damage):
            print("В данном противостоянии победа осталась за \(studentsOfSecondFraction[temporary].name)")
            countOfSecondFractionWins += 1
            break
        case (studentsOfFirstFraction[temporary].health > studentsOfSecondFraction[temporary].health) && (studentsOfFirstFraction[temporary].damage < studentsOfSecondFraction[temporary].damage):
            print("В равном противостоянии победу одержал \(studentsOfFirstFraction[temporary].name)")
            countOfFirstFractionWins += 1
            break
        case (studentsOfFirstFraction[temporary].health < studentsOfSecondFraction[temporary].health) && (studentsOfFirstFraction[temporary].damage > studentsOfSecondFraction[temporary].damage):
            print("В равном противостоянии победу одержал \(studentsOfSecondFraction[temporary].name)")
            countOfSecondFractionWins += 1
            break
        default:
            print("Ничья")
        }
        switch (true) {
        case countOfFirstFractionWins > countOfSecondFractionWins:
            print("Победила первая фракция!")
            break
        case countOfSecondFractionWins > countOfFirstFractionWins:
            print("Победила вторая фракция!")
            break
        default:
            print("Ничья!")
        }
        print("Игра окончена!")
    }
}
let temp: () = Arena(firstFraction: Fraction(name: "Champions"), secondFraction: Fraction(name: "Loosers")).startBattle()
