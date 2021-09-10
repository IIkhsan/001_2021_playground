//MARK: - 2 Задание
class A {}

// Наследование
class B : A {}

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
let example : A = B()

//MARK: - 3 Задание
enum errors : Error {
    case ZeroDenominator
}

struct FractionalNumber {
    var numerator : Int
    var denominator : Int
    
    init(_ numerator : Int, _ denominator : Int) throws {
        if denominator == 0 {
            throw errors.ZeroDenominator
        }
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func multiply(another x : FractionalNumber) -> FractionalNumber  {
        let numerator = self.numerator * x.numerator
        let denominator = self.denominator * x.denominator
        return try! FractionalNumber(numerator, denominator)
    }
    
    func divide(another x : FractionalNumber) -> FractionalNumber {
        let numerator = self.numerator * x.denominator
        let denominator = self.denominator * x.numerator
        return try! FractionalNumber(numerator, denominator)
    }
    
    func plus(another x : FractionalNumber) -> FractionalNumber {
        let firstConstToMultiply = findLCM(self.denominator, x.denominator) / self.denominator
        let secondConstToMultiply = findLCM(self.denominator, x.denominator) / x.denominator
        
        let numerator = self.numerator * firstConstToMultiply + x.numerator * secondConstToMultiply
        let denominator = self.denominator * firstConstToMultiply
        return try! FractionalNumber(numerator, denominator)
    }
    
    func minus(another x : FractionalNumber) -> FractionalNumber {
        let firstConstToMultiply = findLCM(self.denominator, x.denominator) / self.denominator
        let secondConstToMultiply = findLCM(self.denominator, x.denominator) / x.denominator
        
        let numerator = self.numerator * firstConstToMultiply - x.numerator * secondConstToMultiply
        let denominator = self.denominator * firstConstToMultiply
        return try! FractionalNumber(numerator, denominator)
    }
    
    func show() {
        print("\(numerator)/\(denominator)")
    }
    
    // НОК
    private func findLCM(_ a : Int, _ b : Int) -> Int {
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

protocol Student {
    var name : String { get set }
    var hp : Int { get set }
    var damage : Int  { get set }
    var battleCry : String { get set }
    var isAlive : Bool { get set }
    static var counter : Int { get set }
    
    func attack(_ another : Student)
    func takeDamage(_ damage : Int)
}

protocol Arena {
    var firstGang : [Student] { get set }
    var secondGang : [Student] { get set }
    var place : Place! { get set }
    
    func startBattle()
}

enum Place {
    case school
    case garages
    case none
}

enum Fraction : String {
    case bloods = "Blood's Gang"
    case crips = "Crip's Gang"
    case pirus = "Piru's Gang"
    case bandidos = "Bandido's Gang"
}

class BloodsMember : Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive : Bool
    static var counter = 1
    
    init() {
        self.name = "Blood's member-\(BloodsMember.counter)"
        BloodsMember.counter += 1
        self.isAlive = true
        self.hp = 115
        self.damage = 25
        self.battleCry = "I will kill you"
    }
    
    func attack(_ another : Student) {
        print("\(self.name): \(self.battleCry), \(another.name)")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage : Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class CripsMember : Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive : Bool
    static var counter = 1
    
    init() {
        self.name = "Crip's member-\(CripsMember.counter)"
        BloodsMember.counter += 1
        self.isAlive = true
        self.hp = 125
        self.damage = 20
        self.battleCry = "Shoot this"
    }
    
    func attack(_ another : Student) {
        print("\(self.name): \(self.battleCry) \(another.name)")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage : Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class PirusMember : Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive : Bool
    static var counter = 1
    
    init() {
        self.name = "Piru's member-\(PirusMember.counter)"
        PirusMember.counter += 1
        self.isAlive = true
        self.hp = 100
        self.damage = 30
        self.battleCry = "Rest in peace"
    }
    
    func attack(_ another : Student) {
        print("\(self.name): \(self.battleCry), \(another.name)")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage : Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class BandidosMember : Student {
    
    var name: String
    var hp: Int
    var damage: Int
    var battleCry: String
    var isAlive : Bool
    static var counter = 1
    
    init() {
        self.name = "Bandido's member-\(BandidosMember.counter)"
        PirusMember.counter += 1
        self.isAlive = true
        self.hp = 150
        self.damage = 15
        self.battleCry = "Go away"
    }
    
    func attack(_ another : Student) {
        print("\(self.name): \(self.battleCry), \(another.name) pew-pew")
        another.takeDamage(self.damage)
    }
    
    func takeDamage(_ damage : Int) {
        self.hp -= damage
        if self.hp <= 0 {
            self.isAlive = false
        }
    }
}

class BattleArena : Arena {
    var firstGang: [Student]
    var firstGangFraction : String!
    var secondGang: [Student]
    var secondGangFraction : String!
    var place : Place!
    
    init() {
        firstGang = [Student]()
        secondGang = [Student]()
    }
    
    func startBattle() {
        place = choosePlace()
        generateGangs()
        var isAliveFirstGang = true
        var isAliveSecondGang = true
        while (isAliveFirstGang && isAliveSecondGang) {
            let firstGangMember = firstGang.filter({ student in
                return student.isAlive
            }).first!
           
            firstGangMember.attack(secondGang.filter({ student in
                return student.isAlive
            }).first!)
               
            isAliveSecondGang = checkIsGangAlive(secondGang)
            if !isAliveSecondGang {
                break
            }
            
            let secondGangMember = secondGang.filter({ student in
                return student.isAlive
            }).first!
           
            secondGangMember.attack(firstGang.filter({ student in
                return student.isAlive
            }).first!)
            isAliveFirstGang = checkIsGangAlive(firstGang)
            if !isAliveFirstGang {
                break
            }
        }
        printResults(isAliveFirstGang)
    }
    
    private func choosePlace() -> Place {
        let random = Int.random(in: 0...1)
        switch random {
        case 0:
            print("Place of fight is choosen: Garages")
            return .garages
        case 1:
            print("Place of fight is choosen: School")
            return .school
        default:
            return .none
        }
    }
    
    private func checkIsGangAlive(_ gang : [Student]) -> Bool {
        let counterOfAliveStudents = gang.filter { student in
            return student.isAlive
        }.count
        return counterOfAliveStudents != 0
    }
    
    private func generateGangs() {
        generateFirstGang()
        generateSecondGang()
    }
    
    private func generateFirstGang() {
        let idOfGang = Int.random(in: 1...4)
        let countsMembersOfGang = Int.random(in: 1...5)
        switch idOfGang {
        case 1:
            firstGangFraction = Fraction.crips.rawValue
            for _ in 0..<countsMembersOfGang {
                firstGang.append(CripsMember())
            }
        case 2:
            firstGangFraction = Fraction.bloods.rawValue
            for _ in 0..<countsMembersOfGang {
                firstGang.append(BloodsMember())
            }
        case 3:
            firstGangFraction = Fraction.bandidos.rawValue
            for _ in 0..<countsMembersOfGang {
                firstGang.append(BandidosMember())
            }
        case 4:
            firstGangFraction = Fraction.pirus.rawValue
            for _ in 0..<countsMembersOfGang {
                firstGang.append(PirusMember())
            }
        default:
            break
        }
    }
    
    private func generateSecondGang() {
        let idOfGang = Int.random(in: 1...4)
        let countsMembersOfGang = Int.random(in: 1...5)
        switch idOfGang {
        case 1:
            secondGangFraction = Fraction.crips.rawValue
            for _ in 0..<countsMembersOfGang {
                secondGang.append(CripsMember())
            }
        case 2:
            secondGangFraction = Fraction.bloods.rawValue
            for _ in 0..<countsMembersOfGang {
                secondGang.append(BloodsMember())
            }
        case 3:
            secondGangFraction = Fraction.bandidos.rawValue
            for _ in 0..<countsMembersOfGang {
                secondGang.append(BandidosMember())
            }
        case 4:
            secondGangFraction = Fraction.pirus.rawValue
            for _ in 0..<countsMembersOfGang {
                secondGang.append(PirusMember())
            }
        default:
            break
        }
    }
    
    func printResults(_ ifFirstWon : Bool) {
        print("Game over")
        if ifFirstWon {
            print("\(firstGangFraction!) won")
        } else {
            print("\(secondGangFraction!) won")
        }
        print("\(firstGangFraction!) info:")
        for student in firstGang {
            if student.isAlive {
                print("\(student.name) - \(student.hp)")
            } else {
                print("\(student.name) - dead")
            }
        }
        print("\(secondGangFraction!) info:")
        for student in secondGang {
            if student.isAlive {
                print("\(student.name) - \(student.hp)")
            } else {
                print("\(student.name) - dead")
            }
        }
    }
}


let game = BattleArena()
game.startBattle()
