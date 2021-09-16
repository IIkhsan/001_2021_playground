//: [Previous](@previous)

import Foundation

protocol Student {
    var name: String {get set}
    var health: Int {get set}
    var damage: Int {get set}
    var chant: String {get set}
    var isAlive: Bool {get set}
    
    func attack(student: Student)
}

protocol Team {
    var name: String {get set}
    var teammate: [Student] {get set}
    var isAlive: Bool {get set}
}

protocol Arena {
    var name: String {get set}
    var firstTeam: Team {get set}
    var secondTeam: Team {get set}
    func startBattle()
    
}

var NAMES = ["Oleg", "Danil", "Kostya", "Katya", "Zukhra", "Alex", "Max", "Sonya", "Lenar", "Yana", "Petr", "Ivan", "Ramil", "Elly"]

class Elf: Student {
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var isAlive: Bool
    
    init() {
        self.name = NAMES.randomElement()!
        self.health = 40
        self.damage = 15
        self.chant = "I am cool"
        self.isAlive = true
    }
    
    //атака = исцеление тиммейта
    func attack(student: Student) {
        print("\(self.name) heals \(student.name)")
        var student = student
        student.health = student.health + self.damage
    }
}

class Fairy: Student {
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var isAlive: Bool
    
    init() {
        self.name = NAMES.randomElement()!
        self.health = 40
        self.damage = 10
        self.chant = "I am super"
        self.isAlive = true
    }
    
    //атака = повышение силы тиммейта
    func attack(student: Student) {
        print("\(self.name) healped \(student.name)")
        var student = student
        student.damage = student.damage + self.damage
    }
}

class Ogr: Student {
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var isAlive: Bool
    
    init() {
        self.name = NAMES.randomElement()!
        self.health = 50
        self.damage = 15
        self.chant = "I am so cool"
        self.isAlive = true
    }
    
    func attack(student: Student) {
        print("\(self.name) attacked \(student.name)")
        var student = student
        student.health = student.health - self.damage
    }
}

class Giant: Student {
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var isAlive: Bool
    
    init() {
        self.name = NAMES.randomElement()!
        self.health = 70
        self.damage = 22
        self.chant = "I am the strongest"
        self.isAlive = true
    }
    
    func attack(student: Student) {
        print("\(self.name) attacked \(student.name)")
        var student = student
        student.health = student.health - self.damage
    }
}

class MagicFive: Team {
    var name: String
    var teammate: [Student]
    var isAlive: Bool
    var count = 5
    
    init() {
        self.name = "Magic Five"
        self.teammate = [Student] ()
        self.isAlive = true
        generateTeammate()
    }
    
    func generateTeammate() {
        for _ in 1...5 {
            teammate.append(generateTeammate() as! Student)
        }
    }
}

class MagicDust: Team {
    var name: String
    var teammate: [Student]
    var isAlive: Bool
    
    init() {
        self.name = "Magic Dust"
        self.teammate = [Student] ()
        self.isAlive = true
        generateTeammate()
    }
    
    func generateTeammate() {
        for _ in 1...5 {
            teammate.append(generateTeammate() as! Student)
        }
    }
}

class MagicTeam: Team {
    var name: String
    var teammate: [Student]
    var isAlive: Bool
    var count = 5
    
    init() {
        self.name = "Magic Team"
        self.teammate = [Student] ()
        self.isAlive = true
        generateTeammate()
    }
    
    func generateTeammate() {
        for _ in 1...5 {
            teammate.append(generateTeammate() as! Student)
        }
    }
}

class Castle: Arena {
    var name: String
    var firstTeam: Team
    var secondTeam: Team
    
    init(firstTeam: Team, secondTeam: Team) {
        self.name = "Castle"
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
    }
    
    func startBattle() {
        print("START BATTLE")
        while (firstTeam.isAlive && secondTeam.isAlive) {
            
            guard let playerFirstTeam = firstTeam.teammate.filter({$0.isAlive}).first else { firstTeam.isAlive = false
            break
        }
            
            guard let playerSecondTeam = secondTeam.teammate.filter({$0.isAlive}).first else { secondTeam.isAlive = false
            break
        }
            
            playerFirstTeam.attack(student: playerSecondTeam)
            
            secondTeam.isAlive = isTeamAlive(secondTeam.teammate)
            if !secondTeam.isAlive {
                print("\(firstTeam.name) WIN")
                break
            }
            
            guard let playerFirstTeamm = firstTeam.teammate.filter({$0.isAlive}).first else { firstTeam.isAlive = false
            break
        }
            
            guard let playerSecondTeamm = secondTeam.teammate.filter({$0.isAlive}).first else { secondTeam.isAlive = false
            break
        }
            
            playerSecondTeamm.attack(student: playerFirstTeamm)
            
            firstTeam.isAlive = isTeamAlive(firstTeam.teammate)
            if !firstTeam.isAlive {
                print("\(secondTeam.name) WIN")
                break
            }
            
        func isTeamAlive(_ team: [Student]) -> Bool {
            let counter = team.filter { student in
                return student.isAlive
            }.count
            return counter != 0
        }
        }
    }
    func isTeamAlive(team: [Student]) -> Bool {
        let counter = team.filter { student in
            return student.isAlive
        }.count
        return counter != 0
    }
}

//let arenaType: [Arena.Type] = [Castle.self, MagicForest.self]

class Game {
    private let arena: Arena
    
    init() {
        arena = Castle(firstTeam: ManagerForTeam.generateTeam(),secondTeam: ManagerForTeam.generateTeam())
    }
    
    func start() {
        arena.startBattle()
    }
}

class ManagerForTeam{
    static func generateTeam() -> Team {
        let id = Int.random(in: 1...3)
        switch id {
        case 1:
            return MagicFive()
        case 2:
            return MagicTeam()
        case 3:
            return MagicDust()
        default:
            return MagicDust()
        }
    }
}

class ManagerForStudents{
    static func generatePlayer() -> Student {
        let id = Int.random(in: 1...4)
        switch id {
        case 1:
            return Elf()
        case 2:
            return Fairy()
        case 3:
            return Ogr()
        case 4:
            return Giant()
        default:
            return Ogr()
        }
    }
}

let game = Game()
game.start()




