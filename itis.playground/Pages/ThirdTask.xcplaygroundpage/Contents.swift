//: [Previous](@previous)

import Foundation

protocol Student{
    var name: String { get set }
    var health: Int { get set }
    var damage: Int { get set }
    var chant: String { get set }
    var isAlive: Bool {get set}
    var fractionName: Fraction {get set}
    var count: Int {get set}
    
    func getDamage(_ damage: Int)
    func attack(_ another: Student)
}


protocol Arena{
    var firstTeam: [Student] {get set}
    var secondTeam: [Student] {get set}
    var place: Place! {get set}
    
    func startBattle()
}

enum Place: CaseIterable{
    case garage
    case park
    case street
}

enum Fraction: String,CaseIterable{
    case mathematicians = "Math"
    case programmers = "P"
    case linguists = "L"
    case chemists = "C"
}

class Mathematician: Student{
    
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var fractionName: Fraction
    var isAlive: Bool
    var count = 0
    
    
    init() {
        self.name = "Math\(count)"
        count += 1
        self.health = 20
        self.damage = 5
        self.fractionName = Fraction.mathematicians
        self.chant = " Be afraid of mathematicians!"
        self.isAlive = true
    }
    
    func getDamage(_ damage: Int) {
        if self.health <= 0 {
            self.isAlive = false
            print("\(self.name) died")
        }
            self.health -= damage
    }
    
    func attack(_ another: Student) {
        print("\(self.name):\(another.name)\(self.chant)")
        print("\(self.name) attacked \(another.name)")
        another.getDamage(self.damage)
    }
}

class Programmers: Student{
    var count = 0
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var fractionName: Fraction
    var isAlive: Bool
    
    
    init() {
        self.name = "Prog\(count)"
        count += 1
        self.health = 30
        self.damage = 15
        self.fractionName = Fraction.mathematicians
        self.chant = "Wictory or Death!!!!"
        self.isAlive = true
    }
    
    func getDamage(_ damage: Int) {
        if self.health <= 0 {
            self.isAlive = false
            print("\(self.name) died")
        }
            self.health -= damage
    }
    
    func attack(_ another: Student) {
        print("\(self.name):\(self.chant)")
        print("\(self.name) attacked \(another.name)")
        another.getDamage(self.damage)
    }
}

class Linguists: Student{
    var count = 0
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var fractionName: Fraction
    var isAlive: Bool
    
    
    init() {
        self.name = "Math\(count)"
        count += 1
        self.health = 10
        self.damage = 2
        self.fractionName = Fraction.mathematicians
        self.chant = "ALGA!"
        self.isAlive = true
    }
    
    func getDamage(_ damage: Int) {
        if self.health <= 0 {
            self.isAlive = false
            print("\(self.name) died")
        }
            self.health -= damage
    }
    
    func attack(_ another: Student) {
        print("\(self.name):\(self.chant)")
        print("\(self.name) attacked \(another.name)")
        another.getDamage(self.damage)
    }
}

class Chemists: Student{
    var count = 0
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var fractionName: Fraction
    var isAlive: Bool
    
    
    init() {
        self.name = "Chem\(count)"
        count += 1
        self.health = 10
        self.damage = 3
        self.fractionName = Fraction.mathematicians
        self.chant = "HURRAH!"
        self.isAlive = true
    }
    
    func getDamage(_ damage: Int) {
        if self.health <= 0 {
            self.isAlive = false
            print("\(self.name) died")
        }
            self.health -= damage
    }
    
    func attack(_ another: Student) {
        print("\(self.name):\(self.chant)")
        print("\(self.name) attacked \(another.name)")
        another.getDamage(self.damage)
    }
}
class BattleArena: Arena {

    var firstTeam: [Student]
    var secondTeam: [Student]
    var place: Place!
    var firstTeamFraction: String!
    var secondTeamFraction: String!
    
    init() {
        firstTeam = [Student]()
        secondTeam = [Student]()
    }
    
    func startBattle() {
        place = Place.allCases.randomElement()!
        generateTeam()
        var isAliveFirstTeam = true
        var isAliveSecondTeam = true
        
        while (isAliveFirstTeam && isAliveSecondTeam) {
            let firstTeamMember = firstTeam.filter({student in return student.isAlive}).first!
            
            firstTeamMember.attack(secondTeam.filter({student in return student.isAlive}) as! Student)
            
            isAliveSecondTeam = checkIsTeamAlive(secondTeam)
            if !isAliveSecondTeam {
                break
            }
            
            let secondTeamMember = secondTeam.filter({student in return student.isAlive}).first!
            
            secondTeamMember.attack(firstTeam.filter({student in return student.isAlive}) as! Student)
            
            isAliveFirstTeam = checkIsTeamAlive(firstTeam)
            if !isAliveFirstTeam {
                break
            }
        }
        printResult(isAliveFirstTeam)
    }
    
    private func checkIsTeamAlive(_ team: [Student]) -> Bool {
        let count = team.filter{student in return student.isAlive}.count
        return count != 0
    }
    
    private func generateTeam() {
            generateFirstTeam()
            generateSecondTeam()
        }
        
        private func generateFirstTeam() {
            let idOfTeam = Int.random(in: 1...4)
            let countsMembersOfTeam = Int.random(in: 1...5)
            switch idOfTeam {
            case 1:
                firstTeamFraction = Fraction.mathematicians.rawValue
                for _ in 0..<countsMembersOfTeam {
                    firstTeam.append(Mathematician())
                }
            case 2:
                firstTeamFraction = Fraction.programmers.rawValue
                for _ in 0..<countsMembersOfTeam {
                    firstTeam.append(Programmers())
                }
            case 3:
                firstTeamFraction = Fraction.linguists.rawValue
                for _ in 0..<countsMembersOfTeam {
                    firstTeam.append(Linguists())
                }
            case 4:
                firstTeamFraction = Fraction.chemists.rawValue
                for _ in 0..<countsMembersOfTeam {
                    firstTeam.append(Chemists())
                }
            default:
                break
            }
        }
        
    private func generateSecondTeam() {
        let idOfTeam = Int.random(in: 1...4)
        let countsMembersOfTeam = Int.random(in: 1...5)
        switch idOfTeam {
        case 1:
            secondTeamFraction = Fraction.mathematicians.rawValue
            for _ in 0..<countsMembersOfTeam {
                secondTeam.append(Mathematician())
            }
        case 2:
            secondTeamFraction = Fraction.programmers.rawValue
            for _ in 0..<countsMembersOfTeam {
                secondTeam.append(Programmers())
            }
        case 3:
            secondTeamFraction = Fraction.linguists.rawValue
            for _ in 0..<countsMembersOfTeam {
                secondTeam.append(Linguists())
            }
        case 4:
            secondTeamFraction = Fraction.chemists.rawValue
            for _ in 0..<countsMembersOfTeam {
                secondTeam.append(Chemists())
            }
        default:
            break
        }
    }
        
        func printResult(_ ifFirstWon : Bool) {
            print("Game over")
            if ifFirstWon {
                print("\(firstTeamFraction!) won")
            } else {
                print("\(secondTeamFraction!) won")
            }
            print("\(firstTeamFraction!) info:")
            for student in firstTeam {
                if student.isAlive {
                    print("\(student.name) - \(student.health)")
                } else {
                    print("\(student.name) - dead")
                }
            }
            print("\(secondTeamFraction!) info:")
            for student in secondTeam {
                if student.isAlive {
                    print("\(student.name) - \(student.health)")
                } else {
                    print("\(student.name) - dead")
                }
            }
        }
    }


    let game = BattleArena()
    game.startBattle()
    

//: [Next](@next)
