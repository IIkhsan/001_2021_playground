import Foundation


protocol StudentProtocol {
    var health: Double { get set }
    var damage: Double { get set }
    var slogan: String { get set }
    var name: String { get set }
    var team: String { get set }
    
    func attack(anotherStudent: StudentProtocol)
}


protocol ArenaProtocol {
    var firstFraction: Fraction { get set }
    var secondFraction: Fraction { get set }
    var platform: Platform { get set }
    func startBattle()
}


class Platform {
    let buffToHealth: Double
    let debuffToHealth: Double
    let debuffToHealthInPercent: Double
    let buffToHealthInPercent: Double
    let name: String
    
    init(buffToHealth: Double, debuffToHealth: Double, debuffToHealthInPercent: Double, buffToHealthInPercent: Double, name: String) {
        self.buffToHealth = buffToHealth
        self.debuffToHealth = debuffToHealth
        self.debuffToHealthInPercent = debuffToHealthInPercent
        self.buffToHealthInPercent = buffToHealthInPercent
        self.name = name
    }
    
    public func getBuffToHealth() -> Double {
        buffToHealth
    }
    
    public func getDebuffToHealth() -> Double {
        debuffToHealth
    }
    
    public func getBuffToHealthInPercent() -> Double {
        buffToHealthInPercent
    }
    
    public func getDebuffToHealthInPercent() -> Double {
        debuffToHealthInPercent
    }
}


class Major: StudentProtocol {
    var health: Double = 20
    var damage: Double = 20
    var slogan: String
    var name: String
    var team: String
    
    init(health: Double, damage: Double, slogan: String, name: String) {
        self.health += health
        self.damage += damage
        self.slogan = slogan
        self.name = name
        self.team = "majors"
    }
    
    func attack(anotherStudent: StudentProtocol) {
        var student = anotherStudent
        student.health -= damage
    }
}


class Meathead: StudentProtocol {
    var health: Double = 50
    var damage: Double = 40
    var slogan: String
    var name: String
    var team: String
    
    init(health: Double, damage: Double, slogan: String, name: String) {
        self.health += health
        self.damage += damage
        self.slogan = slogan
        self.name = name
        self.team = "meatheads"
    }
    
    func attack(anotherStudent: StudentProtocol) {
        var student = anotherStudent
        student.health -= damage
    }
}


class Urban: StudentProtocol {
    var health: Double = 30
    var damage: Double = 30
    var slogan: String
    var name: String
    var team: String
    
    init(health: Double, damage: Double, slogan: String, name: String) {
        self.health += health
        self.damage += damage
        self.slogan = slogan
        self.name = name
        self.team = "urbans"
    }
    
    func attack(anotherStudent: StudentProtocol) {
        var student = anotherStudent
        student.health -= damage
    }
}


class Nerd: StudentProtocol {
    var health: Double = 10
    var damage: Double = 10
    var slogan: String
    var name: String
    var team: String
    
    init(health: Double, damage: Double, slogan: String, name: String) {
        self.health += health
        self.damage += damage
        self.slogan = slogan
        self.name = name
        self.team = "nerds"
    }
    
    func attack(anotherStudent: StudentProtocol) {
        var student = anotherStudent
        student.health -= damage
    }
}


class Fraction {
    var members: [StudentProtocol]
    var type: String
    
    init(members: [StudentProtocol], type: String) {
        self.members = members
        self.type = type
    }
}


class Arena: ArenaProtocol {
    var firstFraction: Fraction
    var secondFraction: Fraction
    var platform: Platform
    
    init(firstFraction: Fraction, secondFraction: Fraction, platform: Platform) {
        self.firstFraction = firstFraction
        self.secondFraction = secondFraction
        self.platform = platform
    }

    func startBattle() -> Void {
        print("LET'S INTRODUCE THE TEAMS!")
        print(String(describing: firstFraction.type) + " VS " + String(describing: secondFraction.type) + " ON THE " + platform.name)
        
        print()
        print("LET'S SEE THE SLOGANS! FIRST TEAM " + String(describing: firstFraction.type) + ":")
        for member in firstFraction.members {
            print(member.name +  ": " + member.slogan)
        }
        
        print()
        print("SECOND TEAM " + String(describing: secondFraction.type) + ":")
        for member in secondFraction.members {
            print(member.name +  ": " + member.slogan)
        }
        
        print()
        print("LET'S START THE BATTLE!")
        
        while firstFraction.members.count != 0, secondFraction.members.count != 0 {
            print()
            let turn = Int.random(in: 0...1)
            
            if turn == 0{
                print("ITS " + String(describing: firstFraction.type) + " TURN!")
                
                for member in firstFraction.members {
                    if secondFraction.members.count != 0 {
                        let toAttack = Int.random(in: 0...(secondFraction.members.count - 1))
                        let attacker = member.name + "[" + String(member.health) + "]" + " FROM " + String(describing:firstFraction.type)
                        let beAttacked = secondFraction.members[toAttack].name + "[" + String(secondFraction.members[toAttack].health) + "]" + " FROM " + String(describing: secondFraction.type)
                        print(attacker + " ATTACKS " + beAttacked)
                        member.attack(anotherStudent: secondFraction.members[toAttack])
                        
                        if secondFraction.members[toAttack].health <= 0 {
                            print(secondFraction.members[toAttack].name + " FROM " + String(describing: secondFraction.type) + " IS DEAD!")
                            secondFraction.members.remove(at: toAttack)
                        }
                    }
                }
                
            } else {
                print("ITS " + String(describing: secondFraction.type) + " TURN!")
                
                for member in secondFraction.members {
                    if firstFraction.members.count != 0 {
                        let toAttack = Int.random(in: 0...(firstFraction.members.count - 1))
                        
                        let beAttacked = firstFraction.members[toAttack].name + "[" + String(firstFraction.members[toAttack].health) + "]" + " FROM " + String(describing: firstFraction.type)
                        let attacker = member.name + "[" + String(member.health) + "]" + " FROM " + String(describing: secondFraction.type)
                        print(attacker + " ATTACKS " + beAttacked)
                        
                        if firstFraction.members[toAttack].health <= 0 {
                            print(firstFraction.members[toAttack].name + " FROM " + String(describing: firstFraction.type) + " IS DEAD!")
                            firstFraction.members.remove(at: toAttack)
                        }
                    }
                }
            }
            
            var firstFractionIndexesToDelete: [Int] = []
            var secondFractionIndexesToDelete: [Int] = []
            print("ALL GET BUFFS FROM THE PLATFORM!")
            
            for i in 0..<firstFraction.members.count {
                firstFraction.members[i].health += platform.buffToHealth
                firstFraction.members[i].health -= platform.debuffToHealth
                firstFraction.members[i].health *= platform.buffToHealthInPercent
                firstFraction.members[i].health /= platform.debuffToHealthInPercent

                if firstFraction.members[i].health <= 0 {
                    firstFractionIndexesToDelete.append(i)
                }
            }

            for i in 0..<secondFraction.members.count {
                secondFraction.members[i].health += platform.buffToHealth
                secondFraction.members[i].health -= platform.debuffToHealth
                secondFraction.members[i].health *= platform.buffToHealthInPercent
                secondFraction.members[i].health /= platform.debuffToHealthInPercent

                if secondFraction.members[i].health <= 0 {
                    secondFractionIndexesToDelete.append(i)
                }
            }
            
            var counter = 0
            for elem in firstFractionIndexesToDelete {
                print(firstFraction.members[elem - counter].name + " FROM " + String(describing: firstFraction.type) + " DIED FROM BUFFS!")
                firstFraction.members.remove(at: elem - counter)
                counter += 1
            }
            
            counter = 0
            for elem in secondFractionIndexesToDelete {
                print(secondFraction.members[elem - counter].name + " FROM " + String(describing: secondFraction.type) + " DIED FROM BUFFS!")
                secondFraction.members.remove(at: elem - counter)
                counter += 1
            }
        }
        print()
        if firstFraction.members.count > 0 {
            print(String(describing: firstFraction.type) + " ARE WINNERS!")
        } else {
            print(String(describing: secondFraction.type) + " ARE WINNERS!")
        }
    }
}


func createStudent(studentType: Int) -> StudentProtocol {
    let randomName = names.randomElement()!
    let randomSlogan = slogans.randomElement()!
    let randomHealth = Double.random(in: 10...50)
    let randomDamage = Double.random(in: 10...50)
    
    switch studentType{
    case 1:
        return Major(health: randomHealth, damage: randomDamage, slogan: randomSlogan, name: randomName)
    case 2:
        return Urban(health: randomHealth, damage: randomDamage, slogan: randomSlogan, name: randomName)
    case 3:
        return Nerd(health: randomHealth, damage: randomDamage, slogan: randomSlogan, name: randomName)
    case 4:
        return Meathead(health: randomHealth, damage: randomDamage, slogan: randomSlogan, name: randomName)
    default:
        return Major(health: randomHealth, damage: randomDamage, slogan: randomSlogan, name: randomName)
    }
}


var names = ["David", "Richard", "Ann", "Artem", "Danil", "Donald", "Steven", "Paul", "Mark", "Edward", "Gary", "Eric", "Stephen", "Justin", "Scott"]
var slogans = ["Time to make a plea to make India defecation free!", "Change is inevitable-except a vending machine!", "Some people do appear brighter until they open their mouths as light travels faster than sounds!", "You will dead!", "I wanna to home!", "Archimedes is considered to be the father of mathematics!", "‘Forty’ is the only number that is spelt as the letters are arranged in alphabetical order!", "Please be sporting and play a game!"]
var platforms = [Platform(buffToHealth: 1, debuffToHealth: 0, debuffToHealthInPercent: 1,                      buffToHealthInPercent: 1, name: "Hospital"),
                 Platform(buffToHealth: 0, debuffToHealth: 10, debuffToHealthInPercent: 1, buffToHealthInPercent: 1, name: "Hood"),
                 Platform(buffToHealth: 0, debuffToHealth: 0, debuffToHealthInPercent: 1.5, buffToHealthInPercent: 1, name: "School"),
                 Platform(buffToHealth: 0, debuffToHealth: 0, debuffToHealthInPercent: 1, buffToHealthInPercent: 1.001, name: "Hell")]
var firstTeam: [StudentProtocol] = []
var secondTeam: [StudentProtocol] = []
var randomFirstStudentType = Int.random(in: 1...4)
var randomSecondStudentType = Int.random(in: 1...4)

if randomFirstStudentType == randomSecondStudentType {
    while randomFirstStudentType == randomSecondStudentType {
        randomSecondStudentType = Int.random(in: 1...4)
    }
}

for _ in 0...5 {
    firstTeam.append(createStudent(studentType: randomFirstStudentType))
}

for _ in 0...4 {
    secondTeam.append(createStudent(studentType: randomSecondStudentType))
}


var firstFraction = Fraction(members: firstTeam, type: firstTeam[0].team)
var secondFraction = Fraction(members: secondTeam, type: secondTeam[0].team)
var arena = Arena(firstFraction: firstFraction, secondFraction: secondFraction, platform: platforms.randomElement()!)

arena.startBattle()
