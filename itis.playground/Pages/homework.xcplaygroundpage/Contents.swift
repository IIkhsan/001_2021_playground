//: [Previous](@previous)

import Foundation

// MARK: -  TASK 1
//
// Abstraction
protocol Movable {
    func move()
}

protocol Eatable {
    func eat()
}

class Animal: Movable, Eatable {
    func move() {
        print("Moving..")
    }
    
    func eat() {
        print("Bites..")
    }
}

// Inheritance
class Human: Animal {

    private var firstName: String
    private var lastName: String
    
    public var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Polymorphism -> Method Overriding
    override func move() {
        print("Walking..")
    }
    
    //Static Polymorphism -> Method Overloading
    func move(with friend: Human) {
        print("Walking with \(friend.fullName)")
    }
}

// Encapsulation
let me = Human(firstName: "Evans", lastName: "Owamoyo")
// me.firstName ❌
// me.lastName ❌
print(me.fullName)


//
// MARK: - TASK 2
//
class Fraction: CustomStringConvertible {
    var description: String {
        "\(numerator)/\(denominator)"
    }
    
    
    var numerator: Int
    var denominator: Int
    
    init(_ numerator: Int, over denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    convenience init() {
        self.init(0,over: 1)
    }
    
    static prefix func -(fraction: Fraction) -> Fraction {
        return Fraction(fraction.numerator * -1, over: fraction.denominator)
    }
    
    // sum
    static func +(lhs: Fraction, rhs: Fraction) -> Fraction {
        lhs.reduce()
        rhs.reduce()
        
        let newNumerator = lhs.numerator * rhs.denominator + lhs.denominator * rhs.numerator
        let newDenominator = lhs.denominator * rhs.denominator
        let f = Fraction(newNumerator, over: newDenominator)
        f.reduce()
        return f
        
    }
    
    // difference
    static func -(lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs + (-rhs);
    }
    
    // product
    static func *(lhs: Fraction, rhs: Fraction) -> Fraction {
        let f = Fraction(lhs.numerator * rhs.numerator,
                         over: lhs.denominator * rhs.denominator)
        f.reduce()
        return f
    }
    
    // inverse
    func inverse() -> Fraction {
        let f = Fraction(denominator, over: numerator)
        f.reduce()
        return f
    }
    
    // division
    static func /(lhs: Fraction, rhs: Fraction) -> Fraction {
        let f = lhs * rhs.inverse()
        f.reduce()
        return f
    }
    
    // divides both the numerator and the denominator by
    // their gcd
    func reduce() {
       var negativeCache = false
        if numerator < 0 {
            negativeCache = !negativeCache
            numerator *= -1
        }
        if denominator < 0 {
            negativeCache = !negativeCache
            denominator *= -1
        }
        
        let divisor = gcd(numerator,denominator)
        numerator /= divisor
        denominator /= divisor
        
        if negativeCache {
            numerator *= -1
        }
    }
    
    private func gcd(_ num1: Int, _ num2: Int) -> Int {
        let remainder = num1 % num2
        
        return remainder == 0 ? num2 : gcd(num2,remainder);
    }
    
    private func lcm(_ num1: Int, _ num2: Int) -> Int {
        return (num1 * num2) / gcd(num1,num2)
    }
}

// MARK: TEST for TASK 2
let fraction = Fraction(2, over: 3)
let fraction2 = Fraction(1, over: 4)

let sum = fraction + fraction2
print(sum) // sum = 11/12

let diff = fraction - fraction2
print(diff) // diff = 5/12

let product = fraction * fraction2
print(product) // product = 1/6

let quotient = fraction / fraction2
print(quotient) // quotient = 8/3


// MARK: - TASK 3

// Дано:
protocol Student {
    var health: Int { get set }
    var damage: Int { get set }
    var chant: String? { get set }
    var name: String { get }
    
    var division: Division? { get set }
//    var superPower: Superpower { get set }
    
    // die is condition 1-6
    func attack(_ opponent: Student, with die: Int)
}

protocol Superpower {
    func attackWithSuperpower(_ opponent: AnyStudent)
}


class AnyStudent: Student, Superpower {
    
    var health: Int {
        didSet {
            isAlive = health > 0
            if !isAlive {
                division?.students.removeAll{ $0.name == name }
            }
        }
    }
    
    var damage: Int
    
    var chant: String?
    
    var name: String
    
    var isAlive = true
    
    var division: Division? {
        didSet {
            self.chant = division?.slogan
        }
    }
    
    var nick: String {
        if division == nil {
            return name
        } else {
            return "\(name) of \(division!.name)"
        }
    }
    
    init(name: String) {
        self.health = 100
        self.name = name
        self.damage = Int.random(in: 80...100)
//        self.superPower = power
    }
    
    func attack(_ opponent: Student, with die: Int) {
        guard let opponent = opponent as? AnyStudent else { return }
        
        // 1-3 - use superpower
        // 4-5 - attack normally
        // 6 - do nothing
        switch die {
            case 1...3:
                if opponent is IronGate {
                    print("\(opponent.nick) shielded super power attack from \(nick)")
                } else {
                    attackWithSuperpower(opponent)
                }
            case 4...5:
                opponent.health -= damage
                printAttack(nil,opponent.nick)
                
            default:
                printAttack()
        }
    }
    
    // default attack for students without superpower
    func attackWithSuperpower(_ opponent: AnyStudent) {
        opponent.health -= damage
        printAttack(nil, opponent.nick)
    }
    
    fileprivate func printAttack(_ action: String? = nil,
                             _ opponent: String? = nil,
                             with: String? = nil) {
        var answer: String = ""

        if opponent == nil {
            answer = "\(nick) slept off and didn't attack anyone"
        } else if action == nil {
            answer = "\(nick) attacked \(opponent!)"
        } else {
            answer = "\(nick) \(action!) \(opponent!)"
        }
        if with != nil {
            answer += " with \(with!)"
        }
        
        print(answer)
    }
    
}

// old .shield superpower
class IronGate: AnyStudent {}

//old .speed superpower
class SpeedSter: AnyStudent {
    override func attackWithSuperpower(_ opponent: AnyStudent) {
        guard let opponents = opponent.division?.students else { return }
        for player in opponents {
            player.health -= damage
        }
        printAttack("super power attacked all", "\(opponent.division!.name)", with: "⚡️")
    }
}

// old .strength superpower
class Tanks: AnyStudent {
    override func attackWithSuperpower(_ opponent: AnyStudent) {
        opponent.health -= (damage * 2)
        printAttack("super power attacked",opponent.nick, with: "super strength")
    }
}

// old .luck superpower
class LuckCharmer: AnyStudent {
    override func attackWithSuperpower(_ opponent: AnyStudent) {
        health = 100
        opponent.health -= damage
        print("\(name) used his luck super power")
    }
}

// old .phoenix superpower
class Phoenix: AnyStudent {
    override func attackWithSuperpower(_ opponent: AnyStudent) {
        guard let teammates = division?.students else { return }
        
        opponent.health -= damage
        for player in teammates {
            player.health += 20
        }
        print("\(name) increased his teammates health by +20♻️")
    }
}

// old .snake superpower
class ConMan: AnyStudent {
    override func attackWithSuperpower(_ opponent: AnyStudent) {
        guard let teammates = division?.students else { return }
        
        opponent.health -= damage
        for player in teammates {
            player.health -= 20
        }
        health *= 2
        printAttack("super power attack", "his own team mates and \(opponent.nick)", with: "snake superpower")
    }
}

// old .godspeed power
class Titan: AnyStudent {
    override func attackWithSuperpower(_ opponent: AnyStudent) {
        guard let opponents = opponent.division?.students else { return }
        for player in opponents {
            player.health -= damage * 2
        }
        printAttack("super power attacked", "\(opponent.division!.name)", with: "GodSpeed 🔱")
    }
}



protocol Division {
    
    var name: String { get }

    // the chant for this division
    var slogan: String { get }
    
    // list of all students in the division
    var students: [AnyStudent] { get set }
    
    // if students in the division are still alive
    var isAlive: Bool { get }
}

// extension providing general `attack` functionality
extension Division {
 
    // method to choose a random student to attack from another division
    func attack(_ division: Division) {
        if let warrior = self.students.randomElement(),
           let opponent = division.students.randomElement()
           {
            // cast a die
            // 1-3 - use superpower
            // 4-5 - attack normally
            // 6 - do nothing
            let die = Int.random(in: 1...6)
            print(die)
            warrior.attack(opponent, with: die)
        }
    }
    
    var isAlive: Bool {
        for player in students {
            if player.isAlive {
                return true
            }
        }
        return false
    }
}

class Marvel: Division {
    
    var name: String = "Marvel"
    
    var slogan: String = "We Avenge for earth!!"
    
    var students = [AnyStudent]()
    
}

class DC: Division {
    
    var name: String = "DC"
    
    var slogan: String = "All for the money!!"
    
    var students = [AnyStudent]()

}

class MortalKombat: Division {
    
    var name: String = "MortalKombat"
    
    var students = [AnyStudent]()
    
    var slogan = "You win or you die!!"
}

class GreekGods: Division {
    
    var name: String = "GreekGods"
    
    var students = [AnyStudent]()
    
    var slogan = "Tonight we dine in hell! 🔥🔥"
}

protocol Arena {
    var firstDiv: Division { get set }
    var secondDiv: Division { get set }
    
    func startBattle()
}

// MARK: ** MAIN CLASS **
class BullyArena: Arena {
    let ludusMagnus = [
        "Marvel": [
            Titan(name: "Iron-Man"),
            ConMan(name: "Spider-Man"),
            Phoenix(name: "Dr-Strange"),
            LuckCharmer(name: "Ant-Man")
        ],
        "DC": [
            IronGate(name: "BatMan"),
            Titan(name: "SuperMan"),
            Tanks(name: "AquaMan"),
            Phoenix(name: "WonderWoman")
        ],
        "MortalKombat": [
            LuckCharmer(name: "Liu Kang"),
            SpeedSter(name: "Sub Zero"),
            ConMan(name: "Scorpion"),
            Titan(name: "Lord Raiden")
        ],
        "GreekGods": [
            Titan(name: "Zeus"),
            Phoenix(name: "Poseidon"),
            ConMan(name: "Hades"),
            AnyStudent(name: "Man")
        ]
        
    ]
    var firstDiv: Division
    
    var secondDiv: Division
    
    // generates random divisions to face off
    convenience init() {
        var list: [Division] = [Marvel(),DC(),MortalKombat(),GreekGods()]
        let firstDiv_ = list.randomElement()!
        list.removeAll{$0.name == firstDiv_.name}
        let secondDiv_ = list.randomElement()!
        self.init(firstDiv: firstDiv_,secondDiv: secondDiv_)
    }
    
    init(firstDiv: Division, secondDiv: Division) {
        self.firstDiv = firstDiv
        self.secondDiv = secondDiv
        add(ludusMagnus[firstDiv.name]!, to: firstDiv)
        add(ludusMagnus[secondDiv.name]!, to: secondDiv)
    }
    
    private func add(_ students: [AnyStudent], to division: Division) {
        var div = division
        for student in students {
            student.division = div
        }
        div.students.append(contentsOf: students)
    }
    
    func startBattle() {
        print("BATTLE STARTING....")
        print(firstDiv.slogan)
        print(secondDiv.slogan)
        var firstTurn = true
        while(firstDiv.isAlive && secondDiv.isAlive) {
            firstTurn ? firstDiv.attack(secondDiv) : secondDiv.attack(firstDiv)
            firstTurn = !firstTurn
            print("FIRST TEAM")
            for player in firstDiv.students {
                print(player.health)
            }
            print("SECOND TEAM")
            for player in secondDiv.students {
                print(player.health)
            }
        }
        if (!firstDiv.isAlive && !secondDiv.isAlive) {
            print("STALEMATE between \(firstDiv.name) and \(secondDiv.name)")
        } else {
            let aliveDiv = firstDiv.isAlive ? firstDiv : secondDiv
            let deadDiv = firstDiv.name == aliveDiv.name ? secondDiv : firstDiv
            print("\(aliveDiv.name) won \(deadDiv.name)")
        }
    }
    
}

let game = BullyArena()
game.startBattle()


//: [Next](@next)
