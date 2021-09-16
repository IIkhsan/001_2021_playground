import Foundation

enum Fraction: String{
    case water = "Water"
    case fire = "Fire"
    case earth = "Earth"
    case air = "Air"
}

protocol Student{
    var fraction: Fraction { get set }
    
    var isAlive: Bool { get set }
    var HP: Int { get set }
    var damage: Int { get set }
    var cry: String { get set }
    var name: String { get set }
    init(name: String)
}

protocol Advantage {
    var advantage: Int { get }
    func getAdv() -> Void
}

protocol Disadvantage {
    var disadvantage: Int { get }
    func getDis() -> Void
}

class Arena {
    
    var firstTeam: Team
    
    var secondTeam: Team
    
    init(team1: Team, team2: Team) {
        firstTeam = team1
        secondTeam = team2
    }
    
    func startBattle() {
        while firstTeam.isAlive, secondTeam.isAlive {
            print(firstTeam.students[0]?.cry ?? "")
            secondTeam.getDamage(damage: firstTeam.fullDamage())
            if secondTeam.isAlive {
                print(secondTeam.students[0]?.cry ?? "")
                firstTeam.getDamage(damage: secondTeam.fullDamage())
            }
        }
    }
}

class Team {
    var students: [Optional<Student>]
    let fraction: Fraction
    var teamHP = 0
    var isAlive = true
    
    init(studs: [Student]) {
        self.students = studs
        fraction = studs[0].fraction
        teamHP = commonHP()
    }
    
    func fullDamage () -> Int {
        var result = 0
        for s in students {
            result += s?.damage ?? 0
        }
        return result
    }
    
    func commonHP() -> Int {
        var result = 0
        for s in students{
            result+=s?.HP ?? 0
        }
        return result
    }
    
    func getDamage(damage: Int) -> Bool {
        if damage>=teamHP {
            print("The end for team ", self.fraction)
            isAlive = false
            return false
        }
        teamHP-=damage
        return true
    }
}

class WaterStudent: Student{
    
    required init(name: String) {
        self.name = name
        HP = Int.random(in: 250..<330)
        damage = Int.random(in: 40..<60)
    }
    
    var HP: Int
    
    var damage: Int
    
    var cry = "Water proof"
    
    var name: String
    
    var fraction = Fraction.water
    
    var isAlive = true
}

class FireStudent: Student{
    
    required init(name: String) {
        self.name = name
        HP = Int.random(in: 220..<260)
        damage = Int.random(in: 60..<70)
    }
    var HP: Int
    
    var damage: Int
    
    var cry = "With Fire and Sword"
    
    var name: String
    
    var fraction = Fraction.fire
    
    var isAlive = true

}

class EarthStudent: Student{
    required init(name: String) {
        self.name = name
        HP = Int.random(in: 230..<270)
        damage = Int.random(in: 50..<80)
    }
    var HP: Int
    
    var damage: Int
    
    var cry = "Financial Independence Retire Early"
    
    var name: String
    
    var fraction = Fraction.earth
    
    var isAlive = true

}

class AirStudent: Student{
    
    required init(name: String) {
        self.name = name
        HP = Int.random(in: 270..<300)
        damage = Int.random(in: 40..<60)
    }
    var HP: Int
    
    var damage: Int
    
    var cry = "Financial Independence Retire Early"
    
    var name: String
    
    var fraction = Fraction.air
    
    var isAlive = true
    
}

class Waterfall: Arena, Advantage, Disadvantage {
    var advantage = 20
    
    func getAdv() {
        if (firstTeam.fraction == Fraction.water){
            firstTeam.teamHP += advantage
        } else if (secondTeam.fraction == Fraction.water){
            secondTeam.teamHP += advantage
        }
    }
    
    var disadvantage = 15
    
    func getDis() {
            if (firstTeam.fraction == Fraction.fire){
                firstTeam.teamHP -= disadvantage
            } else if (secondTeam.fraction == Fraction.fire){
                secondTeam.teamHP -= disadvantage
            }
    }
    
    override func startBattle() {
        print("*   Welcome to the Waterfall arena  *")
        getAdv()
        getDis()
        super.startBattle()
    }
}

class Volcano: Arena, Advantage, Disadvantage {
    
    var advantage = 15
    
    func getAdv() {
            if (firstTeam.fraction == Fraction.fire){
                firstTeam.teamHP -= disadvantage
            } else if (secondTeam.fraction == Fraction.fire){
                secondTeam.teamHP -= disadvantage
            }
    }
    var disadvantage = 30
    
    func getDis() {
        if (firstTeam.fraction == Fraction.water){
            firstTeam.teamHP += advantage
        } else if (secondTeam.fraction == Fraction.water){
            secondTeam.teamHP += advantage
        }
    }
    
    override func startBattle() {
        print("*   Welcome to the Volcano arena  *")
        getAdv()
        getDis()
        super.startBattle()
    }
}


var team1 = Team(studs: [WaterStudent(name: "Oslo"), WaterStudent(name: "John")])
var team2 = Team(studs: [FireStudent(name: "James"), FireStudent(name: "Alex")])

Waterfall.init(team1: team1, team2: team2).startBattle()
