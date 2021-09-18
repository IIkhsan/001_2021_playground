//: [Previous](@previous)

import Foundation

protocol Student {
    var name: String { get }
    var health: Int { get set }
    var damage: Int { get set }
    var chant: String { get set }
    var isAlive: Bool { get set }
    
    func attack(student: Student)
}

protocol Team {
    var name: String { get set }
    var teammate: [Student] { get set }
    var isAlive: Bool {get set }
}

protocol Arena {
    var name: String { get }
    var firstTeam: Team { get set }
    var secondTeam: Team { get set}
    func startBattle()
    
}

let NAMES = ["Oleg", "Danil", "Kostya", "Katya", "Zukhra", "Alex", "Max", "Sonya", "Lenar", "Yana", "Petr", "Ivan", "Ramil", "Elly"]

class Elf: Student {
    var name: String
    var health: Int
    var damage: Int
    var chant: String
    var isAlive: Bool
    
    init(name: String, health: Int, damage: Int, chant: String, isAlive: Bool ) {
        self.name = name
        self.health = health
        self.damage = damage
        self.chant = chant
        self.isAlive = isAlive
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
    
    init(name: String, health: Int, damage: Int, chant: String, isAlive: Bool ) {
        self.name = name
        self.health = health
        self.damage = damage
        self.chant = chant
        self.isAlive = isAlive
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
    
    init(name: String, health: Int, damage: Int, chant: String, isAlive: Bool ) {
        self.name = name
        self.health = health
        self.damage = damage
        self.chant = chant
        self.isAlive = isAlive
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
    
    init(name: String, health: Int, damage: Int, chant: String, isAlive: Bool ) {
        self.name = name
        self.health = health
        self.damage = damage
        self.chant = chant
        self.isAlive = isAlive
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
    
    init(name: String, teammate: [Student], isAlive: Bool) {
        self.name = name
        self.teammate = teammate
        self.isAlive = isAlive
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
    
    init(name: String, teammate: [Student], isAlive: Bool) {
        self.name = name
        self.teammate = teammate
        self.isAlive = isAlive
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
    
    init(name: String, teammate: [Student], isAlive: Bool) {
        self.name = name
        self.teammate = teammate
        self.isAlive = isAlive
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
            return MagicFive(name: "Magic Five", teammate: [Student] (), isAlive: true)
        case 2:
            return MagicTeam(name: "Magic Team", teammate: [Student] (), isAlive: true)
        case 3:
            return MagicDust(name: "Magic Dust", teammate: [Student] (), isAlive: true)
        default:
            return MagicDust(name: "Magic Five", teammate: [Student] (), isAlive: true)
        }
    }
}

class ManagerForStudents{
    static func generatePlayer() -> Student {
        let id = Int.random(in: 1...4)
        switch id {
        case 1:
            return Elf(name: NAMES.randomElement()!, health: 40, damage: 15, chant: "I am cool", isAlive: true)
        case 2:
            return Fairy(name: NAMES.randomElement()!, health: 35, damage: 10, chant: "I am super", isAlive: true)
        case 3:
            return Ogr(name: NAMES.randomElement()!, health: 50, damage: 15, chant: "GOOO", isAlive: true)
        case 4:
            return Giant(name: NAMES.randomElement()!, health: 50, damage: 12, chant: "I WILL KILL YOU", isAlive: true)
        default:
            return Ogr(name: NAMES.randomElement()!, health: 40, damage: 15, chant: "I am cool", isAlive: true)
        }
    }
}

let game = Game()
game.start()




