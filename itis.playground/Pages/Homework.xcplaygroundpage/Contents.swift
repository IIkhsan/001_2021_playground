//MARK: - 2 Задание
class A {}

// Наследование
class B: A {}

// Инкапсуляция
class C {
    private var id: Int?
    
    func getId() -> Int? {
        return self.id
    }
    
    func setId(_ id : Int?) {
        self.id = id
    }
}

// Полиморфизм
let example: A = B()

//MARK: - 3 Задание
enum errors: Error {
    case ZeroDenominator
    case UnknownId(describing: String)
}

struct FractionalNumber {
    var numerator: Int
    var denominator: Int
    
    init(_ numerator: Int, _ denominator: Int) throws {
        if denominator == 0 {
            throw errors.ZeroDenominator
        }
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func multiply(another x: FractionalNumber) -> FractionalNumber  {
        let numerator = self.numerator * x.numerator
        let denominator = self.denominator * x.denominator
        if let newNumber =  try? FractionalNumber(numerator, denominator) {
            return newNumber
        } else {
            return self
        }
    }
    
    func divide(another x: FractionalNumber) -> FractionalNumber {
        let numerator = self.numerator * x.denominator
        let denominator = self.denominator * x.numerator
        if let newNumber =  try? FractionalNumber(numerator, denominator) {
            return newNumber
        } else {
            return self
        }
    }
    
    func plus(another x: FractionalNumber) -> FractionalNumber {
        let firstConstToMultiply = findLCM(self.denominator, x.denominator) / self.denominator
        let secondConstToMultiply = findLCM(self.denominator, x.denominator) / x.denominator
        
        let numerator = self.numerator * firstConstToMultiply + x.numerator * secondConstToMultiply
        let denominator = self.denominator * firstConstToMultiply
        if let newNumber =  try? FractionalNumber(numerator, denominator) {
            return newNumber
        } else {
            return self
        }
    }
    
    func minus(another x: FractionalNumber) -> FractionalNumber {
        let firstConstToMultiply = findLCM(self.denominator, x.denominator) / self.denominator
        let secondConstToMultiply = findLCM(self.denominator, x.denominator) / x.denominator
        
        let numerator = self.numerator * firstConstToMultiply - x.numerator * secondConstToMultiply
        let denominator = self.denominator * firstConstToMultiply
        if let newNumber =  try? FractionalNumber(numerator, denominator) {
            return newNumber
        } else {
            return self
        }
    }
    
    func show() {
        print("\(numerator)/\(denominator)")
    }
    
    // НОК
    private func findLCM(_ a: Int, _ b: Int) -> Int {
        return (a * b) / findGCD(a, b)
    }
    
    // НОД
    private func findGCD(_ a: Int, _ b: Int) -> Int {
        let answer = abs(a) % abs(b)
        if answer != 0 {
            return findGCD(abs(b), answer)
        } else {
            return abs(b)
        }
    }
}

// Tests
let a = try FractionalNumber(1, 13)
let b = try FractionalNumber(4, 6)

var answers = [FractionalNumber]()
answers.append(a.plus(another: b))
answers.append(a.minus(another: b))
answers.append(a.multiply(another: b))
answers.append(a.divide(another: b))

for element in answers {
    element.show()
}

//MARK: - 4 Задание

// Протоколы
protocol Student {
    var name: String { get set }
    var hp: Int { get set }
    var damage: Int  { get set }
    var battleCry: String { get set }
    var isAlive: Bool { get set }
    static var counter: Int { get set }
    
    func attack(_ another: Student)
    func takeDamage(_ damage: Int)
}

protocol Arena {
    var name: String { get set }
    var firstGang: Fraction { get set }
    var secondGang: Fraction { get set }
    
    func battle()
}

protocol Fraction {
    var name: String { get set }
    var members: [Student] { get set }
    var areMembersAlive: Bool { get set }
}

// Ученики
class BloodsMember: Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive: Bool
    static var counter = 1
    
    init() {
        self.name = "Blood's member-\(BloodsMember.counter)"
        BloodsMember.counter += 1
        self.isAlive = true
        self.hp = 115
        self.damage = 25
        self.battleCry = "I will kill you"
    }
    
    func attack(_ another: Student) {
        print("\(self.name): \(self.battleCry), \(another.name)")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage: Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class CripsMember: Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive: Bool
    static var counter = 1
    
    init() {
        self.name = "Crip's member-\(CripsMember.counter)"
        BloodsMember.counter += 1
        self.isAlive = true
        self.hp = 125
        self.damage = 20
        self.battleCry = "Shoot this"
    }
    
    func attack(_ another: Student) {
        print("\(self.name): \(self.battleCry) \(another.name)")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage: Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class PirusMember: Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive: Bool
    static var counter = 1
    
    init() {
        self.name = "Piru's member-\(PirusMember.counter)"
        PirusMember.counter += 1
        self.isAlive = true
        self.hp = 100
        self.damage = 30
        self.battleCry = "Rest in peace"
    }
    
    func attack(_ another: Student) {
        print("\(self.name): \(self.battleCry), \(another.name)")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage: Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class BandidosMember: Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive: Bool
    static var counter = 1
    
    init() {
        self.name = "Bandido's member-\(BandidosMember.counter)"
        PirusMember.counter += 1
        self.isAlive = true
        self.hp = 150
        self.damage = 15
        self.battleCry = "Go away"
    }
    
    func attack(_ another: Student) {
        print("\(self.name): \(self.battleCry), \(another.name) pew-pew")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage: Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

// Фракции
class Crips: Fraction {
    
    var name: String
    var members: [Student]
    var areMembersAlive: Bool
    let maxMembers = 5
    
    init() {
        self.name = "Crips"
        self.areMembersAlive = true
        self.members = [Student]()
        generateMembers()
    }
    
    private func generateMembers() {
        let countsMembersOfGang = Int.random(in: 1...maxMembers)
        for _ in 1...countsMembersOfGang {
            members.append(CripsMember())
        }
    }
}

class Bloods: Fraction {
    
    var name: String
    var members: [Student]
    var areMembersAlive: Bool
    let maxMembers = 5
    
    init() {
        self.name = "Bloods"
        self.areMembersAlive = true
        self.members = [Student]()
        generateMembers()
    }
    
    private func generateMembers() {
        let countsMembersOfGang = Int.random(in: 1...maxMembers)
        for _ in 1...countsMembersOfGang {
            members.append(BloodsMember())
        }
    }
}

class Pirus: Fraction {
    
    var name: String
    var members: [Student]
    var areMembersAlive: Bool
    let maxMembers = 5
    
    init() {
        self.name = "Pirus"
        self.areMembersAlive = true
        self.members = [Student]()
        generateMembers()
    }
    
    private func generateMembers() {
        let countsMembersOfGang = Int.random(in: 1...maxMembers)
        for _ in 1...countsMembersOfGang {
            members.append(PirusMember())
        }
    }
}

class Bandidos: Fraction {
    
    var name: String
    var members: [Student]
    var areMembersAlive: Bool
    let maxMembers = 5
    
    init() {
        self.name = "Bandidos"
        self.areMembersAlive = true
        members = [Student]()
        generateMembers()
    }
    
    private func generateMembers() {
        let countsMembersOfGang = Int.random(in: 1...maxMembers)
        for _ in 1...countsMembersOfGang {
            members.append(BandidosMember())
        }
    }
}

// Арена
class School: Arena {
    
    var name: String
    var firstGang: Fraction
    var secondGang: Fraction
    
    init(_ firstGang: Fraction, _ secondGang: Fraction) {
        self.name = "School"
        self.firstGang = firstGang
        self.secondGang = secondGang
    }
    
    func battle() {
        while (firstGang.areMembersAlive && secondGang.areMembersAlive) {
            
            guard let firstGangMember = firstGang.members.filter({ $0.isAlive }).first else {
                firstGang.areMembersAlive = false
                break
            }
           
            guard let enemyForFirstGang = secondGang.members.filter({ $0.isAlive }).first else {
                secondGang.areMembersAlive = false
                break
            }
            firstGangMember.attack(enemyForFirstGang)
               
            secondGang.areMembersAlive = checkIsGangAlive(secondGang.members)
            if !secondGang.areMembersAlive { break }
            
            guard let secondGangMember = secondGang.members.filter({ $0.isAlive }).first else {
                secondGang.areMembersAlive = false
                break
            }
            
            guard let enemyForSecondGang = firstGang.members.filter({ $0.isAlive }).first else {
                firstGang.areMembersAlive = false
                break
            }
            secondGangMember.attack(enemyForSecondGang)
            
            firstGang.areMembersAlive = checkIsGangAlive(firstGang.members)
            if !firstGang.areMembersAlive { break }
        }
        printResults(firstGang, secondGang)
    }
    
    private func checkIsGangAlive(_ gang: [Student]) -> Bool {
        let counterOfAliveStudents = gang.filter { student in
            return student.isAlive
        }.count
        return counterOfAliveStudents != 0
    }
    
    private func printResults(_ first: Fraction, _ second: Fraction) {
        print("Game over")
        if first.areMembersAlive {
            print("\(first.name) won")
        } else {
            print("\(second.name) won")
        }
        print("\(first.name) info:")
        for student in first.members {
            if student.isAlive {
                print("\(student.name) - \(student.hp)")
            } else {
                print("\(student.name) - dead")
            }
        }
        print("\(second.name) info:")
        for student in second.members {
            if student.isAlive {
                print("\(student.name) - \(student.hp)")
            } else {
                print("\(student.name) - dead")
            }
        }
    }
}

// Game
class Game {
    
    private let arena: Arena
    
    init() {
        arena = School(Helper.generateFraction(), Helper.generateFraction())
    }
    
    func stat() {
        arena.battle()
    }
    
}

// Helpers
class Helper {
    static func generateFraction() -> Fraction  {
        let id = Int.random(in: 1...4)
        switch id {
        case 1:
            return Crips()
        case 2:
            return Bloods()
        case 3:
            return Pirus()
        case 4:
            return Bandidos()
        default:
            return Crips()
        }
    }
}

// Main
let game = Game()
game.stat()
