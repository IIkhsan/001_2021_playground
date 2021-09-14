import Foundation


protocol StudentProtocol{
    var health: Float {get set}
    var damage: Float {get set}
    var slogan: String {get set}
    var name: String {get set}
    
    func attack(anotherStudent: Student)
}


protocol ArenaProtocol{
    var firstFraction: Fraction { get set }
    var secondFraction: Fraction { get set }
    var platform: Platform { get set }
    func startBattle()
}


enum StudentType{
    case majors
    case urbans
    case nerds
    case meatheads
}


class Platform{
    let buffToHealth: Float
    let debuffToHealth: Float
    let debuffToHealthInPercent: Float
    let buffToHealthInPercent: Float
    let name: String
    
    init(buffToHealth: Float, debuffToHealth: Float, debuffToHealthInPercent: Float, buffToHealthInPercent: Float, name: String){
        self.buffToHealth = buffToHealth
        self.debuffToHealth = debuffToHealth
        self.debuffToHealthInPercent = debuffToHealthInPercent
        self.buffToHealthInPercent = buffToHealthInPercent
        self.name = name
    }
    
    public func getBuffToHealth() -> Float{
        buffToHealth
    }
    
    public func getDebuffToHealth() -> Float{
        debuffToHealth
    }
    
    public func getBuffToHealthInPercent() -> Float{
        buffToHealthInPercent
    }
    
    public func getDebuffToHealthInPercent() -> Float{
        debuffToHealthInPercent
    }
}


class Student: StudentProtocol{
    var health: Float
    var damage: Float
    var slogan: String
    var name: String
    
    init(health: Float, damage: Float, slogan: String, name: String){
        self.health = health
        self.damage = damage
        self.slogan = slogan
        self.name = name
    }
    
    func attack(anotherStudent: Student) {
        anotherStudent.health -= damage
    }
}


class Fraction{
    var members: [Student]
    var type: StudentType
    
    init(members: [Student], type: StudentType){
        self.members = members
        self.type = type
    }
}


class Arena: ArenaProtocol{
    var firstFraction: Fraction
    var secondFraction: Fraction
    var platform: Platform
    
    init(firstFraction: Fraction, secondFraction: Fraction, platform: Platform){
        self.firstFraction = firstFraction
        self.secondFraction = secondFraction
        self.platform = platform
    }

    func startBattle() -> Void{
        print("LET'S INTRODUCE THE TEAMS!")
        print(String(describing: firstFraction.type) + " VS " + String(describing: secondFraction.type) + " ON THE " + platform.name)
        
        print()
        print("LET'S SEE THE SLOGANS! FIRST TEAM " + String(describing: firstFraction.type) + ":")
        for i in 0..<firstFraction.members.count{
            print(firstFraction.members[i].name +  ": " + firstFraction.members[i].slogan)
        }
        
        print()
        print("SECOND TEAM " + String(describing: secondFraction.type) + ":")
        for i in 0..<secondFraction.members.count{
            print(secondFraction.members[i].name +  ": " + secondFraction.members[i].slogan)
        }
        
        print()
        print("LET'S START THE BATTLE!")
        
        while firstFraction.members.count != 0, secondFraction.members.count != 0{
            print()
            let turn = Int.random(in: 0...1)
            
            if turn == 0{
                print("ITS " + String(describing: firstFraction.type) + " TURN!")
                
                for i in 0..<firstFraction.members.count{
                    if secondFraction.members.count != 0{
                        let toAttack = Int.random(in: 0...(secondFraction.members.count - 1))
                        let attacker = firstFraction.members[i].name + "[" + String(firstFraction.members[i].health) + "]" + " FROM " + String(describing:firstFraction.type)
                        let beAttacked = secondFraction.members[toAttack].name + "[" + String(secondFraction.members[toAttack].health) + "]" + " FROM " + String(describing: secondFraction.type)
                        print(attacker + " ATTACKS " + beAttacked)
                        firstFraction.members[i].attack(anotherStudent: secondFraction.members[toAttack])
                        
                        if secondFraction.members[toAttack].health <= 0{
                            print(secondFraction.members[toAttack].name + " FROM " + String(describing: secondFraction.type) + " IS DEAD!")
                            secondFraction.members.remove(at: toAttack)
                        }
                    }
                }
                
            } else{
                print("ITS " + String(describing: secondFraction.type) + " TURN!")
                
                for i in 0..<secondFraction.members.count{
                    if firstFraction.members.count != 0 {
                        let toAttack = Int.random(in: 0...(firstFraction.members.count - 1))
                        
                        let beAttacked = firstFraction.members[toAttack].name + "[" + String(firstFraction.members[toAttack].health) + "]" + " FROM " + String(describing: firstFraction.type)
                        let attacker = secondFraction.members[i].name + "[" + String(secondFraction.members[i].health) + "]" + " FROM " + String(describing: secondFraction.type)
                        print(attacker + " ATTACKS " + beAttacked)
                        
                        if firstFraction.members[toAttack].health <= 0{
                            print(firstFraction.members[toAttack].name + " FROM " + String(describing: firstFraction.type) + " IS DEAD!")
                            firstFraction.members.remove(at: toAttack)
                        }
                    }
                }
            }
            
            var firstFractionIndexesToDelete: [Int] = []
            var secondFractionIndexesToDelete: [Int] = []
            print("ALL GET BUFFS FROM THE PLATFORM!")
            
            for i in 0..<firstFraction.members.count{
                firstFraction.members[i].health += platform.buffToHealth
                firstFraction.members[i].health -= platform.debuffToHealth
                firstFraction.members[i].health *= platform.buffToHealthInPercent
                firstFraction.members[i].health /= platform.debuffToHealthInPercent

                if firstFraction.members[i].health <= 0{
                    firstFractionIndexesToDelete.append(i)
                }
            }

            for i in 0..<secondFraction.members.count{
                secondFraction.members[i].health += platform.buffToHealth
                secondFraction.members[i].health -= platform.debuffToHealth
                secondFraction.members[i].health *= platform.buffToHealthInPercent
                secondFraction.members[i].health /= platform.debuffToHealthInPercent

                if secondFraction.members[i].health <= 0{
                    secondFractionIndexesToDelete.append(i)
                }
            }
            
            var counter = 0
            for elem in firstFractionIndexesToDelete{
                print(firstFraction.members[elem - counter].name + " FROM " + String(describing: firstFraction.type) + " DIED FROM BUFFS!")
                firstFraction.members.remove(at: elem - counter)
                counter += 1
            }
            
            counter = 0
            for elem in secondFractionIndexesToDelete{
                print(secondFraction.members[elem - counter].name + " FROM " + String(describing: secondFraction.type) + " DIED FROM BUFFS!")
                secondFraction.members.remove(at: elem - counter)
                counter += 1
            }
        }
    
        print()
        if firstFraction.members.count > 0{
            print(String(describing: firstFraction.type) + " ARE WINNERS!")
        } else{
            print(String(describing: secondFraction.type) + " ARE WINNERS!")
        }
    }
}


func createStudent(studentType: StudentType) -> Student {
    let randomName = names.randomElement()
    let randomSlogan = slogans.randomElement()
    var randomHealth: Float = 0
    var randomDamage: Float = 0
    
    switch studentType{
    case .majors:
        randomHealth = Float.random(in: 70...90)
        randomDamage = Float.random(in: 10...50)
    case .meatheads:
        randomHealth = Float.random(in: 50...100)
        randomDamage = Float.random(in: 30...70)
    case .nerds:
        randomHealth = Float.random(in: 10...50)
        randomDamage = Float.random(in: 10...30)
    case .urbans:
        randomHealth = Float.random(in: 80...100)
        randomDamage = Float.random(in: 40...60)
    }
    
    return Student(health: randomHealth, damage: randomDamage, slogan: randomSlogan!, name: randomName!)
}


func detectStudentType(number: Int) -> StudentType{
    switch number{
    case 1:
        return StudentType.majors
    case 2:
        return StudentType.urbans
    case 3:
        return StudentType.nerds
    case 4:
        return StudentType.meatheads
    default:
        return StudentType.majors
    }
}


var names = ["David", "Richard", "Ann", "Artem", "Danil", "Donald", "Steven", "Paul", "Mark", "Edward", "Gary", "Eric", "Stephen", "Justin", "Scott"]
var slogans = ["Time to make a plea to make India defecation free!", "Change is inevitable-except a vending machine!", "Some people do appear brighter until they open their mouths as light travels faster than sounds!", "You will dead!", "I wanna to home!", "Archimedes is considered to be the father of mathematics!", "‘Forty’ is the only number that is spelt as the letters are arranged in alphabetical order!", "Please be sporting and play a game!"]
var platforms = [Platform(buffToHealth: 1, debuffToHealth: 0, debuffToHealthInPercent: 1,                      buffToHealthInPercent: 1, name: "Hospital"),
                 Platform(buffToHealth: 0, debuffToHealth: 5, debuffToHealthInPercent: 1, buffToHealthInPercent: 1, name: "Hood"),
                 Platform(buffToHealth: 0, debuffToHealth: 0, debuffToHealthInPercent: 1.005, buffToHealthInPercent: 1, name: "School"),
                 Platform(buffToHealth: 0, debuffToHealth: 0, debuffToHealthInPercent: 1, buffToHealthInPercent: 1.001, name: "Hell")]
var firstTeam: [Student] = []
var secondTeam: [Student] = []
var randomFirstStudentType = detectStudentType(number: Int.random(in: 1...4))
var randomSecondStudentType = detectStudentType(number: Int.random(in: 1...4))

for _ in 0...5{
    firstTeam.append(createStudent(studentType: randomFirstStudentType))
}

for _ in 0...4{
    secondTeam.append(createStudent(studentType: randomSecondStudentType))
}

if randomFirstStudentType == randomSecondStudentType{
    while randomFirstStudentType == randomSecondStudentType{
        randomSecondStudentType = detectStudentType(number: Int.random(in: 1...4))
    }
}

var firstFraction = Fraction(members: firstTeam, type: randomFirstStudentType)
var secondFraction = Fraction(members: secondTeam, type: randomSecondStudentType)
var arena = Arena(firstFraction: firstFraction, secondFraction: secondFraction, platform: platforms.randomElement()!)

arena.startBattle()
