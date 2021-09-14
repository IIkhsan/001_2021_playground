
import Foundation

protocol Student {
    var name: String {get set}
    var hp: Int {get set}
    var damage: Int {get set}
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
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
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
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
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
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
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
    
    init(name: String, hp: Int, damage: Int) {
        self.name = name
        self.hp = hp
        self.damage = damage
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
class RoundInfo {
    var totalPlayers: Int
    var currentPlayers: Int

    init(totalPlayers: Int, currentPlayers: Int) {
        self.totalPlayers = totalPlayers
        self.currentPlayers = currentPlayers
    }
}
func attackProcess(roundInfo: RoundInfo, firstTeam: Team, secondTeam: Team) -> RoundInfo {
    var isAttacked = false
    for member in firstTeam.members {
        if member.alive && !member.madeAttack {
            for enemy in secondTeam.members {
                if enemy.alive{
                    let damage = member.attack()
                    print("Игрок \(member.name) атакует игрока \(enemy.name) и наносит \(damage) урона")
                    enemy.takeDamage(damage: damage)
                    roundInfo.currentPlayers = roundInfo.currentPlayers + 1
                    isAttacked = true
                    break;
                }
            }
        }
        if isAttacked == true {
            break
        }
    }
    return roundInfo
}



func startFight(firstTeam: Team, secondTeam: Team ) -> Int {
    var roundInfo = RoundInfo(totalPlayers: firstTeam.size + secondTeam.size, currentPlayers: 0)
    while roundInfo.currentPlayers != roundInfo.totalPlayers {
        
      roundInfo =  attackProcess(roundInfo: roundInfo, firstTeam: firstTeam, secondTeam: secondTeam)
        var isGameEnded = check(firstTeam: firstTeam, secondTeam: secondTeam)
        if isGameEnded == 1 {
                 return 1
        } else {
            if isGameEnded == 2 {
                return  2
            }
        }
       roundInfo.currentPlayers = count(firstTeam: firstTeam, secondTeam: secondTeam)
        
       roundInfo = attackProcess(roundInfo: roundInfo, firstTeam: secondTeam, secondTeam: firstTeam)
        isGameEnded = check(firstTeam: firstTeam, secondTeam: secondTeam)
        if isGameEnded == 1 {
            return 1
        } else {
            if isGameEnded == 2 {
                return 2
            }
        }
        
        roundInfo.currentPlayers = count(firstTeam: firstTeam, secondTeam: secondTeam)
    }
    return 0
}

func count(firstTeam: Team, secondTeam: Team) -> Int {
    var count = 0
    for member in firstTeam.members {
        if !member.alive || member.madeAttack == true  {
            count = count + 1
        }
    }
    for member in secondTeam.members {
        if !member.alive || member.madeAttack == true  {
            count = count + 1
        }
    }
    return count
}
func  check(firstTeam: Team, secondTeam: Team) -> Int {
    var isAliveFirst = false
    var isAliveSecond = false
    for member in firstTeam.members {
        if member.alive {
            isAliveFirst = true
        }
    }
    for member in secondTeam.members {
        if member.alive {
            isAliveSecond = true
        }
    }
    if isAliveFirst == true && isAliveSecond == false {
        return 1
    } else {
        if isAliveFirst == false && isAliveSecond == true {
            return 2
        }
    }
    return 0
}
func refreshEverything(firstTeam: Team, secondTeam: Team) {
    for member in firstTeam.members {
        member.refreshAttack()
    }
    for member in secondTeam.members {
        member.refreshAttack()
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
