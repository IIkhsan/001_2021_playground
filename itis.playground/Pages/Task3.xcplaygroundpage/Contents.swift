//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
protocol Student {
    var name: String {get set}
    var hp: Int {get set}
    var damage: Int {get set}
//    var scream: String {get set}
    var alive: Bool {get set}
    var madeAttack: Bool {get set}
    
    func takeDamage(damage: Int)
    func shout()
    func attack() -> Int
    func refreshAttack()
}

class Fraction {
    var team: [Student]
    var name: String
    init(team: [Student], name: String) {
        self.team = team
        self.name = name
    }
}

class GachiStudent: Student {
    var madeAttack = false
    var alive = true
    var name: String
    var hp: Int
    var damage: Int
//    var scream: String
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
//        self.scream = scream
    }
    
    func takeDamage(damage: Int) {
        if damage == 1 {
            hp = hp - 1
        } else{
            hp = hp - (damage / 2 )
        }
        
        if hp <= 0 {
            print(" Cмерть настигла \(name) ! Покойся с миром , dungeon master....")
            alive = false
        }
    }
    
    func shout() {
        print("Игрок \(name) произносит боевой клич : I am boss of this GYM!")
    }
    
    func attack() -> Int {
        shout()
        madeAttack = true

        return damage
    }
    func refreshAttack() {
        madeAttack = false
    }
    
    

}


class BiologicStudent: Student {
    
    var madeAttack = false
    var alive = true
    var name: String
    var hp: Int
    var damage: Int
//    var scream: String
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
//        self.scream = scream
    }
    
    func takeDamage(damage: Int) {
        
        let randomInt = Int.random(in: 1...10)
        
        if randomInt < 2 {
            print("\(name) смог создать лечебное зелье, он полностью восстановит полученный урон!")
            
        } else {
            hp = hp - damage
            if hp <= 0 {
                print(" Cмерть настигла \(name) ! Покойся с миром , великий алхимик....")
                alive = false
            }
        }
        
    }
    func attack() -> Int {
        shout()
        madeAttack = true


        return damage
    }
    
    func shout() {
        print("Игрок \(name) произносит боевой клич : H - Водород, O - Кислород, Я.....")
    }
    func refreshAttack() {
        madeAttack = false
    }
    
}

class TechnologicalStudent: Student {
    
    var madeAttack = false
    var alive = true
    var name: String
    var hp: Int
    var damage: Int
//    var scream: String
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
//        self.scream = scream
    }
    
    
    func takeDamage(damage: Int) {
       
            hp = hp - damage
            if hp <= 0 {
                print(" Cмерть настигла \(name) ! Покойся с миром , мастер на все руки....")
                alive = false
            }
    }
    
    func attack() -> Int {
        shout()

        let randomInt = Int.random(in: 1...10)
        
        if randomInt < 2 {
            print("\(name) смог создать топор и нанесет двойной урон!")
            madeAttack = true

            return damage * 2
        } else {
            madeAttack = true

            return damage
        }
    }
    
    
    func shout() {
        print(" Игрок \(name) произносит боевой клич : Сделаю шапку из твоего  скальпа!")
    }
    func refreshAttack() {
        madeAttack = false
    }
}

class CookStudent: Student {
    
    
    
    
    var madeAttack: Bool = false
    var alive = true
    var name: String
    var hp: Int
    var damage: Int
//    var scream: String
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
//        self.scream = scream
    }
    
    func takeDamage(damage: Int) {
        hp = hp - damage
        if hp <= 0 {
            print(" Cмерть настигла \(name) ! Покойся с миром , dungeon master....")
            alive = false
        }
    }
    
    func shout() {
        
        print("Время обеда!")
    }
    
    func attack() -> Int {
        
        shout()
        
        let randomInt = Int.random(in: 1...20)
        
        if randomInt < 6 {
            print("\(name) испек вкусный пирог, здоровье всех его товарищей повышается на 2!")
        
        } else {
            if randomInt == 19 {
                print("\(name) испек ужасный тортик, здоровье всех его товарищей уменьшается на 2!")

            }
            
        }
        madeAttack = true

        return damage
    }
    
    func refreshAttack() {
        madeAttack = false
    }
    
}
class Team {
    var members: [Student]
    var name: String
    var size: Int
    
    init(members: [Student], name:String, size: Int) {
        self.members = members
        self.name = name
        self.size = size
    }
    
    
}
protocol Arena {
    
    var firstTeam: Team {get set}
    var secondTeam: Team {get set}
    var arenaName: String {get}
    
}

class Toilet: Arena {
    var firstTeam: Team
    var secondTeam: Team
    var arenaName = "Туалет"

    init(firstTeam: Team, secondTeam: Team) {
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
    }
    
    
    
    
}

class Circus: Arena {
    var firstTeam: Team
    var secondTeam: Team
    var arenaName: String = "Цирк"
    
    init(firstTeam: Team, secondTeam: Team) {
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
        
    }
    
   
}

func  startWar(firstTeam: Team, secondTeam: Team)  {
    
    let arena = generateArena(firstTeam: firstTeam, secondTeam: secondTeam)
    print("В смертельной схватке участвует команда \(firstTeam.name) и команда \(secondTeam.name). И сразятся они на арене " + arena.arenaName)
    print("Удачи бойцам!")
    print("------------------------- СТАРТ -------------------------")
    battleManager(arena: arena)
}

func generateArena(firstTeam: Team, secondTeam: Team) -> Arena {
    
    let randomInt = Int.random(in: 1...2)
    switch randomInt {
    case 1: return Circus(firstTeam: firstTeam, secondTeam: secondTeam)
    case 2: return Toilet(firstTeam: firstTeam, secondTeam: secondTeam)
    
    default:
        return Circus(firstTeam: firstTeam, secondTeam: secondTeam)
    }
}

func startFight(firstTeam: Team, secondTeam: Team ) -> Int {
    let totalPlayers = firstTeam.size + secondTeam.size
    var currentPlayers = 0
   
    
    var flag3 = false
    while currentPlayers != totalPlayers {
//        var k = firstTeam.size - 1
        var firstFighterIndex = 0
        var secondFighterIndex = 0
        for i in firstTeam.members {
            
            if i.alive && !i.madeAttack {
                for j in secondTeam.members {
                    if j.alive{
                        
                        
                        let damage = i.attack()
                        print("Игрок \(i.name) атакует игрока \(j.name) и наносит \(damage) урона")
                        j.takeDamage(damage: damage)
                        currentPlayers = currentPlayers + 1
                        flag3 = true
                        break;
                        
                    }
                }
            }
            
            firstFighterIndex = firstFighterIndex + 1
            if flag3 == true {
                break
            }
            
        }
        flag3 = false
      
        
        let checkk1 = check(firstTeam: firstTeam, secondTeam: secondTeam)
        if checkk1 == 1 {
                 return 1
            
        } else {
            if checkk1 == 2 {
                return  2
            }
        }
         currentPlayers = count(firstTeam: firstTeam, secondTeam: secondTeam)
        
        
        
        for i in secondTeam.members {
        
            
            if i.alive && !i.madeAttack {
                for j in firstTeam.members {
                    if j.alive{
                       
                       let damage = i.attack()
                        print("Игрок \(i.name) атакует игрока \(j.name) и наносит \(damage) урона")
                        j.takeDamage(damage: damage)
                        currentPlayers = currentPlayers + 1
                        flag3 = true
                       break
                    }
                }
                
            }
            secondFighterIndex = secondFighterIndex + 1
            if flag3 == true {
                break
            }
        }
        flag3 = false
        

        
        let checkk2 = check(firstTeam: firstTeam, secondTeam: secondTeam)
        if checkk2 == 1 {
            return 1
        } else {
            if checkk2 == 2 {
                return 2
            }
        }
        
        currentPlayers = count(firstTeam: firstTeam, secondTeam: secondTeam)
        
        

    }
   
    return 0
    
}

func count(firstTeam: Team, secondTeam: Team) -> Int {
    var count = 0
    for i in firstTeam.members {
        if !i.alive || i.madeAttack == true  {
            count = count + 1
        }
    }
    for i in secondTeam.members {
        if !i.alive || i.madeAttack == true  {
            count = count + 1
        }
    }
    return count
}





func  check(firstTeam: Team, secondTeam: Team) -> Int {
    var flag1 = false
    var flag2 = false
    
    for i in firstTeam.members {
        if i.alive {
            flag1 = true
        }
    }
    for i in secondTeam.members {
        if i.alive {
            flag2 = true
        }
    }
    if flag1 == true && flag2 == false {
        return 1
    } else {
        if flag1 == false && flag2 == true {
            return 2
        }
    }
    return 0
}

func refreshEverything(firstTeam: Team, secondTeam: Team) {
    
    for i in firstTeam.members {
        i.refreshAttack()
    }
    for j in secondTeam.members {
        j.refreshAttack()
    }
    
}

func battleManager(arena: Arena) {
    var end = false
    var count = 1
    while !end {
        print("Начало раунда \(count) !")
        print("//////////////////////////////////////////////////////////")

        let code = startFight(firstTeam: arena.firstTeam, secondTeam: arena.secondTeam)
        
        if code == 1 {
            print("------------------------- КОНЕЦ -------------------------")
            print("Битва завершена! Победила команда \(arena.firstTeam.name)")
             end = true
        } else {
            if code == 2 {
                print("------------------------- КОНЕЦ -------------------------")
                print("Битва завершена! Победила команда \(arena.secondTeam.name)")
                 end = true
            }
        }
        refreshEverything(firstTeam: arena.firstTeam, secondTeam: arena.secondTeam)
        count = count + 1
        print("//////////////////////////////////////////////////////////")
        
    }
    
    
}

var firstTeam = Team(members: [TechnologicalStudent(name: "Марат", hp: 3, damage: 1),
                            CookStudent(name: "Чарльз", hp: 4, damage: 1),
                            GachiStudent(name: "Владимир", hp: 5, damage: 1)
                             ],name: "МОЩНЫЕ ", size: 3)
var secondTeam = Team(members: [TechnologicalStudent(name: "Саня", hp: 3, damage: 1),
                            CookStudent(name: "Григорий", hp: 4, damage: 1),
                            BiologicStudent(name: "Шпинат", hp: 5, damage: 1)
                             ],name: "СРЕДНИЕ ", size: 3)

startWar(firstTeam: firstTeam, secondTeam: secondTeam)




//: [Next](@next)



