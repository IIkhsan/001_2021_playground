//: [Previous](@previous)

import Foundation
import os


//MARK: FIRST TASK

class Parent {
    func parentMethod() {
        print("do something that parent can")
    }
}

class Child: Parent {
    func additionalMethod() {
        print("do another thing")
    }
}
//Inheritance
let child: Child = Child()
child.parentMethod()
child.additionalMethod()

//Polymoprhism
let parentTypeReference: Parent = child
parentTypeReference.parentMethod()

//Encapsulation
class Example {
    public func somePublicMethod() {
        //do smth
        doSomethingPrivately()
    }
    
    private var count: Int?
    
    private func doSomethingPrivately(){
        //any encapsulated logic
        guard count != nil else {
            return
        }
        count! += 1
    }
}

//Abstraction
protocol Soundable {
    func makeSound()
}

class Dog: Soundable {
    func makeSound() {
        print("woof woof")
    }
}

//MARK: SECOND TASK AND THIRD TASK
struct FractionalNumber: CustomStringConvertible {
    
    public func multiplie(digit: Int) -> FractionalNumber {
        return FractionalNumber(numerator: numerator * digit, denominator: denominator)
    }
    
    public func multiplie(fractional: FractionalNumber) -> FractionalNumber {
        return FractionalNumber(numerator: fractional.numerator * numerator, denominator: fractional.denominator * denominator)
    }
    
    public func divide(digit: Int) -> FractionalNumber {
        return FractionalNumber(numerator: numerator, denominator: denominator * digit)
    }
    
    public func divide(fractional: FractionalNumber) -> FractionalNumber {
        return FractionalNumber(numerator: fractional.denominator * numerator, denominator: fractional.numerator * denominator)
    }
    
    public func addition(fractional: FractionalNumber) -> FractionalNumber {
        let digit = FractionalNumber(numerator: numerator * fractional.denominator + fractional.numerator * denominator, denominator: denominator * fractional.denominator)
        return reduce(fractional: digit)
    }
    
    public func sustruction(fractional: FractionalNumber) -> FractionalNumber {
        let digit = FractionalNumber(numerator: numerator * fractional.denominator - fractional.numerator * denominator, denominator: denominator * fractional.denominator)
        return reduce(fractional: digit)
    }
    
    private func gcd(_ a: Int, _ b: Int) -> Int {
      let r = a % b
      if r != 0 {
        return gcd(b, r)
      } else {
        return b
      }
    }
    
    public func reduce(fractional: FractionalNumber) -> FractionalNumber{
        var divisor = gcd(fractional.numerator, fractional.denominator)
        if divisor < 0 { divisor *= -1 }
        guard divisor != 0 else { return FractionalNumber(numerator: fractional.numerator, denominator: 0) }
        return FractionalNumber(numerator: fractional.numerator / divisor, denominator: fractional.denominator / divisor)
    }
    
    var numerator: Int
    
    var denominator: Int
    
    var description: String {
        let digit = reduce(fractional: self)
        return "\(digit.numerator)/\(digit.denominator)"
    }
}

        




//MARK: FOURTH TASK

enum StudentType: String {
    case boxer = "Boxer"
    case biologist = "biologist"
    case sportsman = "sportsman"
    case motivator = "motivator"
}

protocol Student: AnyObject {
    func getDamage(damage: Int)
    func act(receiver: Student, supportPoints: Int)
    func makeSound()
    var health: Int { get set }
    var damage: Int { get set }
    var defense: Int { get set }
    var type: StudentType { get }
    var isAlive: Bool { get set }
    var isSupport: Bool { get set }
    var name: String { get }
    var number: Int { get }
    
    
}

class AbstractStudent: Student {
    
    public func getDamage(damage: Int) {
        health -= damage
        if health <= 0 {
            isAlive = false
            print("P\(number) \(type) \(name) just died. F")
        }
    }
    
    private init() {
    }
    
    func act(receiver: Student, supportPoints: Int) {
    }
    
    var isSupport: Bool = false
     
    var number: Int = -1
    
    var name: String = ""
    
    var defense: Int = 50
        
    func makeSound() {
        print("P\(number): Boxer \(name) is here")
    }
    
    var health: Int = 70
    
    var damage: Int = 100
    
    var type: StudentType = StudentType.boxer
    
    var isAlive: Bool = true
    
    init(number: Int, name: String) {
        self.number = number
        self.name = name
    }
}

class Boxer: AbstractStudent {
    
   override func act(receiver: Student, supportPoints: Int) {
       print("P\(number) boxer \(name) attack: P\(receiver.number) \(receiver.type) \(receiver.name)")
        var dmg = damage + supportPoints
        if receiver.defense >= dmg {
            print("boxer \(name) hit defense \(dmg) points")
            receiver.defense -=  dmg
        } else {
            dmg -= receiver.defense
            print("boxer \(name) destroy defense and hit \(dmg) hp")
            receiver.getDamage(damage: dmg)
        }
    }
    
    override func makeSound() {
         print("P\(number): Boxer \(name) is here")
     }
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        isSupport = false
        defense = 70
        health = 90
        damage = 70
        type = StudentType.boxer
    }
    
}
class Biologist: AbstractStudent {
    override func act(receiver: Student, supportPoints: Int) {
        print("P\(number) biologist \(name) hill P\(receiver.number) \(receiver.type) \(receiver.name) at \(damage) points")
        receiver.health += damage + supportPoints
    }
    
    override func makeSound() {
        print("P\(number): Biologist \(name) is here")
    }
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        defense = 50
        health = 60
        damage = 20
        type = StudentType.biologist
        isSupport = true
    }
}

class Sportsman: AbstractStudent {
    
    override func act(receiver: Student, supportPoints: Int) {
        print("P\(number) sportsman \(name) attack: P\(receiver.number) \(receiver.type) \(receiver.name)")
         var dmg = damage + supportPoints
         if receiver.defense >= dmg {
             print("sportsman \(name) hit defense \(dmg) points")
             receiver.defense -=  dmg
         } else {
             dmg -= receiver.defense
             print("sportssman \(name) destroy defense and hit \(dmg) hp")
             receiver.getDamage(damage: dmg)
         }
    }
    
    override func makeSound() {
        print("P\(number): Sportsman \(name) is here")
    }
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        defense = 100
        health = 90
        damage = 60
        type = StudentType.sportsman
        isSupport = false
    }
}

class Motivator: AbstractStudent {
    
    override func act(receiver: Student, supportPoints: Int) {
        print("P\(number) motivator \(name) motivate and increase P\(receiver.number) \(receiver.type) \(receiver.name) damage points at \(damage)")
        receiver.damage += damage + supportPoints
    }
    
    override func makeSound() {
        print("P\(number): Motivator \(name) is here")
    }
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        defense = 60
        health = 60
        damage = 50
        type = StudentType.motivator
        isSupport = true
    }
}

protocol Arena {
    
    func startBattle()
    
    var faction1: [Student] { get set }
    
    var faction2: [Student] { get set }
}

class AbstractArena: Arena {
    
    private init() {
        faction2 = []
        faction1 = []
        unitManager = UnitManager.init()
    }
    
    func startBattleMessage() {
    }
    
    func startBattle() {
        startBattleMessage()
        var isAllTeamsAlive = true
        while isAllTeamsAlive {
            print("NEW ROUND")
            unitManager.deadListRoundFaction2.removeAll()
            unitManager.deadListRoundFaction1.removeAll()
            var faction1TeamNumbers : [Int] = []
            var faction2TeamNumber: [Int] = []
            for i in 0..<faction1.count {
                faction1TeamNumbers.append(i)
            }
            for i in 0..<faction2.count {
                faction2TeamNumber.append(i)
            }
            faction1TeamNumbers.shuffle()
            faction2TeamNumber.shuffle()
            if faction1TeamNumbers[0] % 2 == 0 {
                print("First attack team 1")
                print("---------------------            --------------------------")
                unitManager.startRound(attackerFirst: faction1, attackerSecond: faction2, attackerFirstNumbers: faction1TeamNumbers, attackerSecondNumbers: faction2TeamNumber, privelegePoints: privelegePoints, attackerTeamNumber: 1)
            } else {
                print("First attack team 2")
                print("---------------------            --------------------------")
                unitManager.startRound(attackerFirst: faction2, attackerSecond: faction1, attackerFirstNumbers: faction2TeamNumber, attackerSecondNumbers: faction1TeamNumbers, privelegePoints: privelegePoints, attackerTeamNumber: 2)
            }
            print("Round ended...")
            print("---------------------            --------------------------")
            printRoundDeads()
            print("---------------------            --------------------------")
            printInfoAboutTeam()
            print("-----------------------------------------------------------")
            
            isAllTeamsAlive = unitManager.checkIfTeamAlive(team: faction1) && unitManager.checkIfTeamAlive(team: faction2)
        }
        printWinnerTeam()
    }
    
    init(faction1: [Student], faction2: [Student]) {
        self.faction1 = faction1
        self.faction2 = faction2
        unitManager = UnitManager.init()
    }
    
    func printWinnerTeam() {
        if unitManager.checkIfTeamAlive(team: faction1) {
            print("TEAM 1 WIN!👑")
        } else {
            print("TEAM 2 WIN!👑")
        }
    }
    
    func printInfoAboutTeam() {
        print("Current team units:")
        print("Team number 1:")
        for i in 0..<faction1.count {
            if faction1[i].isAlive {
            print("P\(faction1[i].number) \(faction1[i].type) \(faction1[i].name): \(faction1[i].health) hp, \(faction1[i].damage) damage, \(faction1[i].defense) defense")
            } else {
                print ("P\(faction1[i].number) \(faction1[i].type) \(faction1[i].name) dead")
            }
        }
        print("")
        print("Team number 2:")
        for i in 0..<faction2.count {
            if faction2[i].isAlive {
            print("P\(faction2[i].number) \(faction2[i].type) \(faction2[i].name): \(faction2[i].health) hp, \(faction2[i].damage) damage, \(faction2[i].defense) defense")
            } else {
                print("P\(faction2[i].number) \(faction2[i].type) \(faction2[i].name) dead")
            }
        }
    }
    
    func printRoundDeads() {
        print("In this round were knocked out:")
        print("Team 1:")
        if unitManager.deadListRoundFaction1.isEmpty {
            print("none")
        } else {
            for i in 0..<unitManager.deadListRoundFaction1.count {
                print("P\(unitManager.deadListRoundFaction1[i].number) \(unitManager.deadListRoundFaction1[i].type) \(unitManager.deadListRoundFaction1[i].name)")
            }
        }
        print("Team 2:")
        if unitManager.deadListRoundFaction2.isEmpty {
            print("none")
        } else {
            for i in 0..<unitManager.deadListRoundFaction2.count {
                print("P\(unitManager.deadListRoundFaction2[i].number) \(unitManager.deadListRoundFaction2[i].type) \(unitManager.deadListRoundFaction2[i].name)")
            }
        }
    }
    
    var faction1: [Student]
    
    var faction2: [Student]
    
    var privelegeList: [StudentType] = [StudentType.biologist]
    
    var privelegePoints: Int = 10
    
    var unitManager: UnitManager
    
}

class ChemicalClass: AbstractArena {
    
    override init(faction1: [Student], faction2: [Student]) {
        super.init(faction1: faction1, faction2: faction2)
        unitManager = UnitManager.init(addPrivilegeAndBattleClosure: {
            (attacker: Student, defender: Student, privelegePoints) -> Void in
            if attacker.type == StudentType.biologist {
                print("P\(attacker.number) \(attacker.type) get arena bonus")
                attacker.act(receiver: defender, supportPoints: privelegePoints)
            } else {
                attacker.act(receiver: defender, supportPoints: 0)
            }
        })
    }
    
    override func startBattleMessage() {
        print("----------------------------------------------------------")
        print("Battle has been started. Arena: Chemical Class")
        print("Privilege has biologist. They hill stronger at \(privelegePoints) points")
        print("---------------------            --------------------------")
    }
}

class Gym: AbstractArena {
    
    override init(faction1: [Student], faction2: [Student]) {
        super.init(faction1: faction1, faction2: faction2)
        unitManager = UnitManager.init(addPrivilegeAndBattleClosure: {
            (attacker: Student, defender: Student, privelegePoints) -> Void in
            if attacker.type == StudentType.sportsman || attacker.type == StudentType.boxer {
                print("P\(attacker.number) \(attacker.type) get arena bonus")
                attacker.act(receiver: defender, supportPoints: privelegePoints)
            } else {
                attacker.act(receiver: defender, supportPoints: 0)
            }
        })
    }
    
    override func startBattleMessage() {
        print("----------------------------------------------------------")
        print("Battle has been started. Arena: Gym")
        print("Privilege has boxers and sportsmans. They damage increases at \(privelegePoints) points")
        print("---------------------            --------------------------")
    }
}

class ConcertHall: AbstractArena {
    
    override init(faction1: [Student], faction2: [Student]) {
        super.init(faction1: faction1, faction2: faction2)
        unitManager = UnitManager.init(addPrivilegeAndBattleClosure: {
            (attacker: Student, defender: Student, privelegePoints) -> Void in
            if attacker.type == StudentType.motivator {
                print("P\(attacker.number) \(attacker.type) get arena bonus")
                attacker.act(receiver: defender, supportPoints: privelegePoints)
            } else {
                attacker.act(receiver: defender, supportPoints: 0)
            }
        })
    }
    
    override func startBattleMessage() {
        print("----------------------------------------------------------")
        print("Battle has been started. Arena: ConcertHall")
        print("Privilege has motivators. They motivate better at \(privelegePoints) points")
        print("---------------------            --------------------------")
    }
}

class UnitManager {
    
    var deadListRoundFaction1 : [Student] = []
    
    var deadListRoundFaction2: [Student] = []
    
    var addPrivelegeAndBattleClosure : (_ attacker: Student, _ defender: Student, _ privelegePoints: Int) -> Void
    
    init() {
        self.addPrivelegeAndBattleClosure = { (attacker: Student, defender: Student, privelegePoints) -> Void in
        }
    }
    
    init(addPrivilegeAndBattleClosure: @escaping (_ attacker: Student, _ defender: Student, _ privelegePoints: Int) -> Void) {
        self.addPrivelegeAndBattleClosure = addPrivilegeAndBattleClosure
    }
        
    public func startRound(attackerFirst: [Student], attackerSecond: [Student], attackerFirstNumbers: [Int], attackerSecondNumbers: [Int], privelegePoints: Int, attackerTeamNumber: Int) {
        for i in attackerFirstNumbers {
            if attackerFirst[i].isAlive {
                if attackerFirst[i].isSupport {
                    for j in attackerSecondNumbers {
                        if attackerFirst[j].isAlive {
                            addPrivelegeAndBattleClosure(attackerFirst[i], attackerFirst[j], privelegePoints)
                            break
                        }
                    }
                } else {
                    for j in attackerSecondNumbers {
                        if attackerSecond[j].isAlive {
                            addPrivelegeAndBattleClosure(attackerFirst[i], attackerSecond[j], privelegePoints)
                            if attackerSecond[j].isAlive == false {
                                if attackerTeamNumber == 1 {
                                    deadListRoundFaction2.append(attackerSecond[j])
                                } else {
                                    deadListRoundFaction1.append(attackerSecond[j])
                                }
                            }
                            break
                        }
                    }
                }
            }
        }
        print("Second team attack")
        print("---------------------            --------------------------")
        for i in attackerSecondNumbers {
            if attackerSecond[i].isAlive {
                if attackerSecond[i].isSupport {
                    for j in attackerFirstNumbers {
                        if attackerSecond[j].isAlive {
                            addPrivelegeAndBattleClosure(attackerSecond[i], attackerSecond[j], privelegePoints)
                            break
                        }
                    }
                } else {
                    for j in attackerFirstNumbers {
                        if attackerFirst[j].isAlive {
                            addPrivelegeAndBattleClosure(attackerSecond[i], attackerFirst[j], privelegePoints)
                            if attackerFirst[j].isAlive == false {
                                if attackerTeamNumber == 1 {
                                    deadListRoundFaction1.append(attackerFirst[j])
                                } else {
                                    deadListRoundFaction2.append(attackerFirst[j])
                                }
                            }
                            break
                        }
                    }
                }
            }
        }
    }
    
    public func checkIfTeamAlive(team: [Student]) -> Bool {
        for i in 0..<team.count {
            if team[i].isAlive == true {
                return true
            }
        }
        return false
    }
}

class BattleManager {
    
    let generator: Generator = Generator()
    
    var arena: Arena
        
    init(){
       arena = generator.generateArena()
    }
    
    public func start(){
        arena.startBattle()
    }
   }

class Generator {
    
    public func generateTeam() -> [Student] {
        var students: [Student] = []
        var count = -1
        //!!readLine не работает в playground поэтому хардкод
        //print("Enter unit count")
        //let stringValue = readLine()
        /*
        if let stringValue = readLine() {
            count = Int(stringValue) ?? -1
        }
         */
        count = 5
        for i in 0..<count {
            students.append(generateUnit(number: i))
        }
        print("----------------")
        return students
    }
    
    private func generateUnit(number: Int) -> Student {
        let nameArrIndex = Int.random(in: 0..<names.count)
        let name = names[nameArrIndex]
        let typeInt = Int.random(in: 0...3)
        switch typeInt {
        case 0:
            let boxer = Boxer(number: number, name: name)
            boxer.makeSound()
            return boxer
        case 1:
            let biologist = Biologist(number: number, name: name)
            biologist.makeSound()
            return biologist
        case 2:
            let motivator = Motivator(number: number, name: name)
            motivator.makeSound()
            return motivator
        case 3:
            let sportsman = Sportsman(number: number, name: name)
            sportsman.makeSound()
            return sportsman
        default:
            return Boxer(number: number, name: name)
        }
    }
    
    public func generateArena() -> Arena {
        let randomdigit = Int.random(in: 0...2)
        switch randomdigit {
        case 0:
            return ConcertHall(faction1: generateTeam(), faction2: generateTeam())
        case 1:
            return Gym(faction1: generateTeam(), faction2: generateTeam())
        default:
            return ChemicalClass(faction1: generateTeam(), faction2: generateTeam())
        }
    }
    
    var names: [String] = ["Ivan", "Valera", "Alexander", "Volodya", "Rustam", "Emil", "Marat", "Leha", "Islam", "Ildar"]
    
}


//MARK: TEST
let digit = FractionalNumber(numerator: 1, denominator: 2)
print(digit.addition(fractional: FractionalNumber(numerator: 1, denominator: 2)))
print(digit.multiplie(digit: 4))
print(digit.divide(digit: 2))
print(digit.sustruction(fractional: FractionalNumber(numerator: 1, denominator: 4)))
print("")
print("")
print("GAME")
var battleManager: BattleManager = BattleManager.init()
battleManager.start()

//: [Next](@next)
