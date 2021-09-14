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
        parentMethod()
        print("do another thing")
    }
}
//Inheritance
let child: Child = Child()
child.additionalMethod()

//Polymoprhism
let parentTypeReference: Parent = child
parentTypeReference.parentMethod()

//Encapsulation
class Example {
    
    private var count: Int?
    public func somePublicMethod() {
        //do smth
        doSomethingPrivately()
    }
    
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
    
    var numerator: Int
    var denominator: Int
    var description: String {
        let digit = reduce(fractional: self)
        return "\(digit.numerator)/\(digit.denominator)"
    }
    
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
}

        




//MARK: FOURTH TASK

//MARK: Правила
/*
Сущности
 1)Студенты бывают 4 типов: biologist лечит своих тиммейтов, motivator прибавляет damage тиммейтам, boxer и sportsman атакуют врагов, разница лишь в количестве hp, damage, defense
 2)Арены бывают 3 типов: ChemicalClass дают бонус классу biologist, они лечат лучше. Gym дает бонус классу boxer и sportsman, у них увеличивается damage. ConcertHall дает бонус классу motivator, они увеличивают damage своим тиммейтам лучше
 
 Бой
 1)Есть две фракции, количество студентов в них могло бы быть вводимым через консоль если бы команда readline() работала в playground, поэтому как будто ввели 5 на каждую из команд (их только 2)
 2)Две фракции сражаются в раундах до тех пор пока у одной из фракций не погибнут все участники
 3)В конце боя выводится фракция победитель
 
 Раунд
 1)Каждый раунд рандомно выбирается фракция которая атакует первой, затем очередь атаковать другой фракции

 2)Каждый персонаж фракции атакует только 1 раз другого рандомно выбранного живого персонажа из фракции оппонентов (Если аттакует саппорт (motivator или biologist) то рандомно выбирается живой персонаж из своей команды и саппорт увеличивает damage или hp). Потом другая фракция атакует по тем же правилам
 3)В конце каждого раунда выводится информация о том, кто погиб именно в текущем раунде а также информация о текущем составе команд
 
 Генерация
 1)Рандомно генерируется арена
 2)Перед боем генерируется массив студентов для каждой из фракции
 3)В массив добавляются Персонажи, у которых тип и имя выбраны рандомно
 */

enum StudentType: String {
    case boxer = "Boxer"
    case biologist = "biologist"
    case sportsman = "sportsman"
    case motivator = "motivator"
}

protocol Student: AnyObject {
    var health: Int { get set }
    var damage: Int { get set }
    var defense: Int { get set }
    var type: StudentType { get }
    var isAlive: Bool { get set }
    var isSupport: Bool { get set }
    var name: String { get }
    var number: Int { get }

    func getDamage(damage: Int)
    func act(receiver: Student, supportPoints: Int)
    func makeSound()
}

class AbstractStudent: Student {
    
    var isSupport: Bool = false
    var number: Int
    var name: String
    var defense: Int = 0
    var health: Int = 0
    var damage: Int = 0
    var type: StudentType = StudentType.boxer
    var isAlive: Bool = true
    
    init(number: Int, name: String) {
        self.number = number
        self.name = name
    }
        
    public func getDamage(damage: Int) {
        health -= damage
        if health <= 0 {
            isAlive = false
            print("P\(number) \(type) \(name) just died. F")
        }
    }
    
    func act(receiver: Student, supportPoints: Int) {
    }
    
    func makeSound() {
        print("P\(number): Boxer \(name) is here")
    }
}

class Boxer: AbstractStudent {
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        isSupport = false
        defense = 70
        health = 90
        damage = 70
        type = StudentType.boxer
    }
    
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
}
class Biologist: AbstractStudent {
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        defense = 50
        health = 60
        damage = 20
        type = StudentType.biologist
        isSupport = true
    }
    
    override func act(receiver: Student, supportPoints: Int) {
        print("P\(number) biologist \(name) hill P\(receiver.number) \(receiver.type) \(receiver.name) at \(damage) points")
        receiver.health += damage + supportPoints
    }
    
    override func makeSound() {
        print("P\(number): Biologist \(name) is here")
    }
}

class Sportsman: AbstractStudent {
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        defense = 100
        health = 90
        damage = 60
        type = StudentType.sportsman
        isSupport = false
    }
    
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
}

class Motivator: AbstractStudent {
    
    override init(number: Int, name: String) {
        super.init(number: number, name: name)
        defense = 60
        health = 60
        damage = 50
        type = StudentType.motivator
        isSupport = true
    }
    
    override func act(receiver: Student, supportPoints: Int) {
        print("P\(number) motivator \(name) motivate and increase P\(receiver.number) \(receiver.type) \(receiver.name) damage points at \(damage)")
        receiver.damage += damage + supportPoints
    }
    
    override func makeSound() {
        print("P\(number): Motivator \(name) is here")
    }
}

protocol Arena {
    
    var faction1Students: [Student] { get set }
    var faction2Students: [Student] { get set }
    
    func startBattle()
}

class AbstractArena: Arena {
    
    var faction1Students: [Student]
    var faction2Students: [Student]
    var privelegeList: [StudentType] = [StudentType.biologist]
    var privelegePoints: Int = 10
    var unitManager: UnitManager
    
    init(faction1Students: [Student], faction2Students: [Student]) {
        self.faction1Students = faction1Students
        self.faction2Students = faction2Students
        unitManager = UnitManager.init()
    }
    
    func startBattleMessage() {
    }
    
    func startBattle() {
        startBattleMessage()
        var isAllTeamsAlive = true
        var faction1RandomIndexes: [Int] = []
        var faction2RandomIndexes: [Int] = []
        for i in 0..<faction1Students.count {
            faction1RandomIndexes.append(i)
        }
        for i in 0..<faction2Students.count {
            faction2RandomIndexes.append(i)
        }
        while isAllTeamsAlive {
            print("NEW ROUND")
            unitManager.deadListRoundFaction2.removeAll()
            unitManager.deadListRoundFaction1.removeAll()
            faction1RandomIndexes.shuffle()
            faction2RandomIndexes.shuffle()
            if faction1RandomIndexes[0] % 2 == 0 {
                print("First attack team 1")
                print("---------------------            --------------------------")
                unitManager.startRound(attackerFirst: faction1Students, attackerSecond: faction2Students, attackerFirstRandomIndexes: faction1RandomIndexes, attackerSecondRandomIndexes: faction2RandomIndexes, privelegePoints: privelegePoints, attackerTeamNumber: 1)
            } else {
                print("First attack team 2")
                print("---------------------            --------------------------")
                unitManager.startRound(attackerFirst: faction2Students, attackerSecond: faction1Students, attackerFirstRandomIndexes: faction2RandomIndexes, attackerSecondRandomIndexes: faction1RandomIndexes, privelegePoints: privelegePoints, attackerTeamNumber: 2)
            }
            print("Round ended...")
            print("---------------------            --------------------------")
            printRoundDeads()
            print("---------------------            --------------------------")
            printInfoAboutTeam()
            print("-----------------------------------------------------------")
            isAllTeamsAlive = unitManager.checkIfTeamAlive(team: faction1Students) && unitManager.checkIfTeamAlive(team: faction2Students)
        }
        printWinnerTeam()
    }

    func printWinnerTeam() {
        if unitManager.checkIfTeamAlive(team: faction1Students) {
            print("TEAM 1 WIN!👑")
        } else {
            print("TEAM 2 WIN!👑")
        }
    }
    
    func printInfoAboutTeam() {
        print("Current team units:")
        print("Team number 1:")
        for i in 0..<faction1Students.count {
            if faction1Students[i].isAlive {
            print("P\(faction1Students[i].number) \(faction1Students[i].type) \(faction1Students[i].name): \(faction1Students[i].health) hp, \(faction1Students[i].damage) damage, \(faction1Students[i].defense) defense")
            } else {
                print ("P\(faction1Students[i].number) \(faction1Students[i].type) \(faction1Students[i].name) dead")
            }
        }
        print("")
        print("Team number 2:")
        for i in 0..<faction2Students.count {
            if faction2Students[i].isAlive {
            print("P\(faction2Students[i].number) \(faction2Students[i].type) \(faction2Students[i].name): \(faction2Students[i].health) hp, \(faction2Students[i].damage) damage, \(faction2Students[i].defense) defense")
            } else {
                print("P\(faction2Students[i].number) \(faction2Students[i].type) \(faction2Students[i].name) dead")
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
}

class ChemicalClass: AbstractArena {
    
    override init(faction1Students: [Student], faction2Students: [Student]) {
        super.init(faction1Students: faction1Students, faction2Students: faction2Students)
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
    
    override init(faction1Students: [Student], faction2Students: [Student]) {
        super.init(faction1Students: faction1Students, faction2Students: faction2Students)
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
    
    override init(faction1Students: [Student], faction2Students: [Student]) {
        super.init(faction1Students: faction1Students, faction2Students: faction2Students)
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
        
    public func startRound(attackerFirst: [Student], attackerSecond: [Student], attackerFirstRandomIndexes: [Int], attackerSecondRandomIndexes: [Int], privelegePoints: Int, attackerTeamNumber: Int) {
        for i in attackerFirstRandomIndexes {
            if attackerFirst[i].isAlive {
                if attackerFirst[i].isSupport {
                    for j in attackerSecondRandomIndexes {
                        if attackerFirst[j].isAlive {
                            addPrivelegeAndBattleClosure(attackerFirst[i], attackerFirst[j], privelegePoints)
                            break
                        }
                    }
                } else {
                    for j in attackerSecondRandomIndexes {
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
        for i in attackerSecondRandomIndexes {
            if attackerSecond[i].isAlive {
                if attackerSecond[i].isSupport {
                    for j in attackerFirstRandomIndexes {
                        if attackerSecond[j].isAlive {
                            addPrivelegeAndBattleClosure(attackerSecond[i], attackerSecond[j], privelegePoints)
                            break
                        }
                    }
                } else {
                    for j in attackerFirstRandomIndexes {
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
    
    var names: [String] = ["Ivan", "Valera", "Alexander", "Volodya", "Rustam", "Emil", "Marat", "Leha", "Islam", "Ildar"]
    
    public func generateTeam() -> [Student] {
        var students: [Student] = []
        var count = -1
        //MARK: readLine не работает в playground поэтому хардкод
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
            return ConcertHall(faction1Students: generateTeam(), faction2Students: generateTeam())
        case 1:
            return Gym(faction1Students: generateTeam(), faction2Students: generateTeam())
        default:
            return ChemicalClass(faction1Students: generateTeam(), faction2Students: generateTeam())
        }
    }
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
