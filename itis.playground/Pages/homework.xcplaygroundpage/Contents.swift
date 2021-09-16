//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//task 2

//Absrtaction

protocol Human{
    var name: String? {get set}
    var age: Int? {get set}
    var sex: String? {get set}
    
    func sleep() -> Int
    func eat() -> String
}

//Encapsulation and inheritance

class Student: Human {
    var name: String?
    var age: Int?
    var sex: String?

    private var politicalViews: String?

    func sleep() -> Int {
        return 4
    }

    func eat() -> String {
        return "ate shawarma"
    }

    private func prepareCheatSheats(subject:String) -> String {
        return "cheat sheat are ready"
    }
}

//task 3

enum fractionNumberErrors: Error {
    case divisionByZero
    case other(description: String)
}

struct FractionalNumber {
    
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) throws {
        if denominator == 0 {
            throw fractionNumberErrors.divisionByZero
        } else {
            self.denominator = denominator
        }
        self.numerator = numerator
        reduce()
    }
        
    func gcd(firstNum: Int, secondNum: Int) -> Int {
        if secondNum == 0 {
            return firstNum
        }
        return gcd(firstNum: secondNum, secondNum: firstNum % secondNum)
    }
    
    mutating func reduce() {
        let gcd = gcd(firstNum: self.numerator, secondNum: self.denominator)
        numerator /= gcd
        denominator /= gcd
    }
    
    func show() {
        let buf = numerator % denominator
        if (buf == 0) {
            print(numerator/denominator)
        }
        else {
            print("\(numerator) / \(denominator)")
        }
    }
     func add(fractionNumber: FractionalNumber) -> FractionalNumber {
        
        let numerator = fractionNumber.numerator * self.denominator + fractionNumber.denominator * self.numerator
        let denominator = fractionNumber.denominator * self.denominator
        
        if let newFractionalNumber = try? FractionalNumber(numerator: numerator, denominator: denominator) {
            return newFractionalNumber
        }
        else {
            return self
        }
        
    }
    
    func subtract(fractionNumber: FractionalNumber) -> FractionalNumber {
       
        if (fractionNumber.denominator == self.denominator) {
            let numerator = self.numerator - fractionNumber.numerator
            let denominator = denominator
            if let newFractionNumber = try? FractionalNumber(numerator: numerator , denominator: denominator) {
                return newFractionNumber
            }
            else {
                return self
            }
        }
        else {
            let numerator = fractionNumber.denominator * self.numerator - fractionNumber.numerator * self.denominator
            let denominator = fractionNumber.denominator * self.denominator
            
            if let newFractionNumber = try? FractionalNumber(numerator: numerator, denominator: denominator) {
                return newFractionNumber
            }
            else {
                return self
            }
           
        }
    }
    
    func multiply(fractionNumber: FractionalNumber) -> FractionalNumber {
        
        let numerator = self.numerator * fractionNumber.numerator
        let denominator = self.denominator * fractionNumber.denominator
        
        if let newFractionNumber = try?  FractionalNumber(numerator: numerator, denominator: denominator) {
            return newFractionNumber
        }
        else {
            return self
        }
    }
    
    func divide(fractionNumber: FractionalNumber) -> FractionalNumber {
       
        if let inverseFraction =  try? FractionalNumber(numerator: fractionNumber.denominator, denominator: fractionNumber.numerator) {
            return self.multiply(fractionNumber: inverseFraction)
        }
        else {
            return self
        }
    }
    
}
var number = try FractionalNumber(numerator: 5,denominator: 4)
number = number.multiply(fractionNumber: try FractionalNumber(numerator: 13, denominator: 35))
number.show()

protocol Student {
    
    var healthPoint: Int { get set }
    var damage: Int { get set }
    var slogan: String { get set }
    var isAlive: Bool { get set }
    var name: String { get set }
    
    func causeDamage(anotherStudent: Student)
    
    func getLosses(anotherStudent: Student)
    
}

protocol Arena {
    
    var fractions: [Fraction] { get set }
    var isAliveFirstTeam: Bool { get set }
    var isAliveSecTeam: Bool { get set }
    
    func startBattle()
    func printNameFraction()
    func chekoutFraction(fractions: [Fraction]) -> [Fraction]
    func generateFractions()
    
}
 
protocol Fraction  {
    
    var name: String { get set }
    var students: [Student] { get set }
    var maxCountStudents: Int { get set }
    
    func generate()
    func isAliveAllStudentsInFraction() -> Bool
    func getLosses() -> String
    
}

class ItisStudent: Student {
    
    var healthPoint: Int
    var damage: Int
    var slogan: String
    var isAlive: Bool
    var name: String
    
    init() {
        self.name = ItisFraction.getNameFraction()
        self.isAlive = true
        self.healthPoint = 100
        self.damage = 5
        self.slogan = "ИТИС зашибись!"
        
    }
    
    func causeDamage(anotherStudent: Student) {
        anotherStudent.getLosses(anotherStudent: self)
        if (!anotherStudent.isAlive) {
            print ("\(self.name) killed \(anotherStudent.name) \n \(self.slogan)")
        }
        else {
            print("\(self.name) wounded \(anotherStudent.name) \n \(self.slogan) vs \(anotherStudent.slogan) ")
        }
    }
    
    func getLosses(anotherStudent: Student) {
        self.healthPoint -= anotherStudent.damage
        
        if self.healthPoint < 0 {
            self.isAlive = false
        }
    }

}

class IvmiitStudent: Student {
    
    var healthPoint: Int
    var damage: Int
    var slogan: String
    var isAlive: Bool
    var name: String
    
    init() {
        self.name = IvmiitFraction.getNameFraction()
        self.isAlive = true
        self.healthPoint = 100
        self.damage = 5
        self.slogan = "IVMIIT the best!"
    }

    func causeDamage(anotherStudent: Student) {
        anotherStudent.getLosses(anotherStudent: self)
        if (!anotherStudent.isAlive) {
            print ("\(self.name) killed \(anotherStudent.name) \n \(self.slogan)")
        }
        else {
            print("\(self.name) wounded \(anotherStudent.name) \n \(self.slogan) vs \(anotherStudent.slogan)")
        }
    }
    
    func getLosses(anotherStudent: Student) {
        self.healthPoint -= anotherStudent.damage
        
        if self.healthPoint < 0 {
            self.isAlive = false
        }
    }
}

class FizFackStudent: Student {
   
    var healthPoint: Int
    var damage: Int
    var slogan: String
    var isAlive: Bool
    var name: String
    
    init() {
        self.name = FizFackFraction.getNameFraction()
        self.isAlive = true
        self.healthPoint = 100
        self.damage = 5
        self.slogan = "I love FizFack!"
    }
    
    func causeDamage(anotherStudent: Student) {
        anotherStudent.getLosses(anotherStudent: self)
        if (!anotherStudent.isAlive) {
            print ("\(self.name) killed \(anotherStudent.name) \n \(self.slogan)")
        }
        else {
            print("\(self.name) wounded \(anotherStudent.name) \n \(self.slogan) vs \(anotherStudent.slogan)")
        }
    }
    
    func getLosses(anotherStudent: Student) {
        self.healthPoint -= anotherStudent.damage
        
        if self.healthPoint < 0 {
            self.isAlive = false
        }
    }
}

class MechMathStudent: Student {
   
    var healthPoint: Int
    var damage: Int
    var slogan: String
    var isAlive: Bool
    var name: String
    
    init() {
        self.name = MechMathFraction.getNameFraction()
        self.isAlive = true
        self.healthPoint = 100
        self.damage = 5
        self.slogan = "Learn! Create! Win on MechMath!"
    }
    
    func causeDamage(anotherStudent: Student) {
        anotherStudent.getLosses(anotherStudent: self)
        if (!anotherStudent.isAlive) {
            print ("\(self.name) killed \(anotherStudent.name) \n \(self.slogan)")
        }
        else {
            print("\(self.name) wounded \(anotherStudent.name) \n \(self.slogan) and \(anotherStudent.slogan)")
        }
    }
    
    func getLosses(anotherStudent: Student) {
        self.healthPoint -= anotherStudent.damage
        
        if self.healthPoint < 0 {
            self.isAlive = false
        }
    }
}


class ItisFraction: Fraction {
    
    var maxCountStudents = 5
    var name = "ITIS"
    var students: [Student]
    
    init() {
        students = [ItisStudent]()
        generate()
    }
    
    func generate() {
        for _ in 0..<maxCountStudents {
            self.students.append(ItisStudent())
        }
    }

    static func getNameFraction() -> String {
        return "ITIS";
    }
    
    func isAliveAllStudentsInFraction() -> Bool {
        var countKilledStudents = 0
        for student in students {
            if student.isAlive == false {
                countKilledStudents += 1
            }
        }
        if countKilledStudents == maxCountStudents {
            return false
        }
        return true
    }
    
    func getLosses() -> String {
        var losses = 0
        for student in students {
            if (!student.isAlive) {
                losses += 1
            }
        }
        return "\(losses) students died in fraction \(name)"
    }
}

class IvmiitFraction: Fraction {
    
    var maxCountStudents = 5
    var name = "IVMIIT"
    var students: [Student]
    
    init() {
        students = [IvmiitStudent]()
        generate()
    }
    
    func generate() {
        for _ in 0..<maxCountStudents {
            self.students.append(IvmiitStudent())
        }
    }
    
    func getName() -> String {
        return name;
    }
    
    static func getNameFraction() -> String {
        return "IVMIIT";
    }
    
    func isAliveAllStudentsInFraction() -> Bool {
        var countKilledStudents = 0
        for student in students {
            if student.isAlive == false {
                countKilledStudents += 1
            }
        }
        if countKilledStudents == maxCountStudents {
            return false
        }
        return true
    }
    func getLosses() -> String {
        var losses = 0
        for student in students {
            if (!student.isAlive) {
                losses += 1
            }
        }
        return "\(losses) students died in fraction \(name)"
    }
}

class FizFackFraction: Fraction {
    
    var name = "FizFack"
    var students: [Student]
    var maxCountStudents = 5
    
    init() {
        students = [FizFackStudent]()
        generate()
    }
    func isAliveAllStudentsInFraction() -> Bool {
        var countKilledStudents = 0
        for student in students {
            if student.isAlive == false {
                countKilledStudents += 1
            }
        }
        if countKilledStudents == maxCountStudents {
            return false
        }
        return true
    }
    
    func generate() {
        for _ in 0..<maxCountStudents {
            self.students.append(FizFackStudent())
        }
    }
    
    static func getNameFraction() -> String {
        return "FizFack";
    }
    func getLosses() -> String {
        var losses = 0
        for student in students {
            if (!student.isAlive) {
                losses += 1
            }
        }
        return "\(losses) students died in fraction \(name)"
    }
}

class MechMathFraction: Fraction {

    var name = "MechMath"
    var students: [Student]
    var maxCountStudents = 5
    
    init() {
        students = [MechMathStudent]()
        generate()
    }
    
    func generate() {
        for _ in 0..<maxCountStudents {
            self.students.append(MechMathStudent())
        }
    }
    
    static func getNameFraction() -> String {
        return "MechMath";
    }
    
    func isAliveAllStudentsInFraction() -> Bool {
        var countKilledStudents = 0
        for student in students {
            if student.isAlive == false {
                countKilledStudents += 1
            }
        }
        if countKilledStudents == maxCountStudents {
            return false
        }
        return true
    }
    
    func getLosses() -> String {
        var losses = 0
        for student in students {
            if (!student.isAlive) {
                losses += 1
            }
        }
        return "\(losses) students died in fraction \(name)"
    }
    
}

extension Array {

    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

class CanteenOfFizFack: Arena {
    
    var fractions: [Fraction]
    var isAliveFirstTeam: Bool = true
    var isAliveSecTeam: Bool = true
    
    init() {
        fractions = [Fraction]()
        generateFractions()
        printNameFraction()
    }
    
    internal func printNameFraction() {
        print("These fractions participate in the battle: \(fractions[0].name) and \(fractions[1].name)")
    }
     internal func generateFractions() {
        
        let allFractions: [Fraction] = [ItisFraction(), IvmiitFraction(), FizFackFraction(), MechMathFraction()]
        
        let count = Array(0...3)
        let index = count[randomPick: 2]
        
        for i in index {
            fractions.append(allFractions[i])
        }
    }
    
    func startBattle() {
        fractions = chekoutFraction(fractions: fractions)
    
        while (isAliveFirstTeam) || (isAliveSecTeam) {
            let randomFraction = Int.random(in: 0..<2)
            for index in 0..<fractions[0].maxCountStudents {
                fractions[randomFraction].students[index].causeDamage(anotherStudent: fractions[abs(1-randomFraction)].students[index])
                if (!fractions[1].isAliveAllStudentsInFraction()) {
                    print("In this battle fraction won: \(fractions[0].name) 👑 \n",
                          "\(fractions[0].getLosses())")
                    isAliveFirstTeam = false
                    break
                }
                else {
                   if (!fractions[0].isAliveAllStudentsInFraction()) {
                        print("In this battle fraction won: \(fractions[1].name) 👑 \n",
                              "\(fractions[1].getLosses())")
                        isAliveSecTeam = false
                        break
                    }
                }
            }
            if (!isAliveFirstTeam) || (!isAliveSecTeam) {
                break
            }
        }
        
    }
    internal func chekoutFraction(fractions: [Fraction]) -> [Fraction] {
        for fraction in fractions {
            if fraction.name == FizFackFraction.getNameFraction() {
                for var student in fraction.students {
                    student.healthPoint += 15
                }
            }
            else {
                for var student in fraction.students {
                    student.healthPoint -= 15
                }
            }
        }
        return fractions
    }    
}

class MarbleHall: Arena {
    
    var isAliveFirstTeam: Bool = true
    var isAliveSecTeam: Bool = true
    var fractions: [Fraction]
    
    init() {
        fractions = [Fraction]()
        generateFractions()
        printNameFraction()
    }
    
    internal func printNameFraction() {
        print("These fractions participate in the battle: \(fractions[0].name) and \(fractions[1].name)")
    }

    internal func chekoutFraction(fractions: [Fraction]) -> [Fraction] {
        for var fraction in fractions {
            if fraction.name == ItisFraction.getNameFraction() {
                let bossStudent = ItisStudent()
                bossStudent.healthPoint = 200
                bossStudent.damage = 15
                
                fraction.students.removeFirst()
                fraction.students.insert(bossStudent, at: 0)
            }
        }
        
        return fractions
    }
    
    internal func generateFractions() {
        let allFractions: [Fraction] = [ItisFraction(), IvmiitFraction(), FizFackFraction(), MechMathFraction()]
        
        let count = Array(0...3)
        let index = count[randomPick: 2]
        
        for i in index {
            fractions.append(allFractions[i])
        }
    }
    
    
    func startBattle() {
        fractions = chekoutFraction(fractions: fractions)
    
        while (isAliveFirstTeam) || (isAliveSecTeam) {
            let randomFraction = Int.random(in: 0..<2)
            for index in 0..<fractions[0].maxCountStudents {
                fractions[randomFraction].students[index].causeDamage(anotherStudent: fractions[abs(1-randomFraction)].students[index])
                if (!fractions[1].isAliveAllStudentsInFraction()) {
                    print("In this battle fraction won: \(fractions[0].name) 👑 \n",
                          "\(fractions[0].getLosses())")
                    isAliveFirstTeam = false
                    break
                }
                else {
                   if (!fractions[0].isAliveAllStudentsInFraction()) {
                        print("In this battle fraction won: \(fractions[1].name) 👑 \n",
                              "\(fractions[1].getLosses())")
                        isAliveSecTeam = false
                        break
                    }
                }
            }
            if (!isAliveFirstTeam) || (!isAliveSecTeam) {
                break
            }
        }
        
    }
    
}

var arena = MarbleHall()
arena.startBattle()
////: [Next](@next)
