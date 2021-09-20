//: [Previous](@previous)

import Foundation
//TASK1
//инкапсуляция
class SomePhone {
    private var year: Int
    private var company: String
    init(year: Int, company: String) {
        self.year = year
        self.company = company
    }
    
    private func openConnection() { }
    
    func call() {
        openConnection()
        print("Вызов")
    }
    
    func ring() {
        print("Звонок")
    }
}
class Phone {
    func callMe() {
        print("Ты звонишь мне")
    }
    func call(outputNumber: Int) {
        print("я звоню тебе")
    }
}

//наследование
class CellPhone: Phone {
    var number: Int
    
    required init(number: Int) {
        self.number = number
    }
    
    override func call(outputNumber: Int) {
        print("Вызов по номеру\(outputNumber)")
    }
    
    func ring(inputNumber: Int) {
        print("Звонок от \(inputNumber)")
    }
}

let cellPhone: CellPhone = CellPhone(number: 102132)
cellPhone.callMe()

//полиморфизм
class Smartphone: CellPhone {
    override func call(outputNumber: Int) {
        print("Звонит смартфон")
    }
}

class User {
    func callAntoherPhone(phone: Phone) {
        phone.call(outputNumber: 2132132)
    }
}
let somePhone: Phone = CellPhone(number: 42142)
let someSecondPhone: Phone = Smartphone(number: 2421421)
let user1: User = User()
user1.callAntoherPhone(phone: somePhone)
user1.callAntoherPhone(phone: someSecondPhone)


//TASK 2
struct Drob {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func show(){
        print("\(numerator)/\(denominator)")
    }
    
    
    func NOD() -> Drob{
        var a: Int = numerator
        var b: Int = denominator
        if a > 0 && b > 0 {
            while (a != b){
                if a > b {
                    a = a - b
                }else {
                    b = b - a
                }
            }
        }else {
            a *= -1
            while a != b {
                if a > b {
                    a = a - b
                }else {
                    b = b - a
                }
            }
        }
        
        
        
        return Drob(numerator: numerator/a , denominator: denominator/b)
    }
}

struct Calculator {
    var drob1: Drob
    var drob2: Drob
    
    init(drob1: Drob, drob2: Drob) {
        self.drob1 = drob1
        self.drob2 = drob2
    }
    
    func sum() -> Drob {
        let resultDenominator = drob1.denominator*drob2.denominator;
        let resultNumerator = resultDenominator/drob1.denominator*drob1.numerator + resultDenominator/drob2.denominator*drob2.numerator
        return Drob(numerator: resultNumerator, denominator: resultDenominator).NOD()
    }
    
    func subtraction() -> Drob {
        let resultDenominator = drob1.denominator*drob2.denominator;
        let resultNumerator = resultDenominator/drob1.denominator*drob1.numerator - resultDenominator/drob2.denominator*drob2.numerator
        return Drob(numerator: resultNumerator, denominator: resultDenominator).NOD()
    }
    
    func multiply() -> Drob {
        return Drob(numerator: drob1.numerator*drob2.numerator, denominator: drob1.denominator*drob2.denominator).NOD()
    }
    
    func divide() -> Drob {
        return Drob(numerator: drob1.numerator*drob2.denominator, denominator: drob1.denominator*drob2.numerator).NOD()
    }
}

//Task 3
class Faction {
    let name: String
    let healthBoost: Int
    let damageBoost: Int
    let canUseWeapon: Bool
    let startWeapon: Weapon
    let factionShoutout: String
    var factionMembers: [FactionMember] = []
    
    init(name: String, healthBoost: Int, damageBoost: Int, canUseWeapon: Bool, startWeapon: Weapon, factionShoutout: String) {
        self.name = name
        self.healthBoost = healthBoost
        self.damageBoost = damageBoost
        self.canUseWeapon = canUseWeapon
        self.startWeapon = startWeapon
        self.factionShoutout = factionShoutout
    }
    
}

class Weapon{
    let name: String
    let damage: Int
    init(name: String, damage: Int){
        self.name = name
        self.damage = damage
    }
}

protocol Student {
    var health: Int { get set }
    var damage: Int { get }
    var factionShoutout: String { get set }
    var name: String { get }
    var faction: Faction { get set }
    var weapon: Weapon { get set }
    
    func attack(opponent: FactionMember)
    func useFactionSkill(faction: Faction) -> Int
}

protocol Arena {
    var firstFactionOnFight: Faction { get set }
    var secondFactionOnFight: Faction { get set }
    var availableWeapons: [Weapon] { get set }
    func startBattle()
    func factionFight(firstFactionOnFight: Faction, secondFactionOnFight: Faction) -> Faction?
}

extension Arena {
    func factionFight(firstFactionOnFight: Faction, secondFactionOnFight: Faction) -> Faction? {
        var counter: Int = 0
        var winningFaction: Faction?
        while counter != 15 {
            var firstRandom: Int = Int.random(in: 0..<firstFactionOnFight.factionMembers.count)
            var secondRandom: Int = Int.random(in: 0..<secondFactionOnFight.factionMembers.count)
            firstFactionOnFight.factionMembers[firstRandom].attack(opponent: secondFactionOnFight.factionMembers[secondRandom])
            if secondFactionOnFight.factionMembers[secondRandom].health <= 0 {
                print(secondFactionOnFight.factionMembers[secondRandom].name + " cломали нос! Стычка окончена!")
                winningFaction = firstFactionOnFight
                break
            }
            firstRandom = Int.random(in: 0..<firstFactionOnFight.factionMembers.count)
            secondRandom = Int.random(in: 0..<secondFactionOnFight.factionMembers.count)
            secondFactionOnFight.factionMembers[Int.random(in: 0..<secondFactionOnFight.factionMembers.count)].attack(opponent: firstFactionOnFight.factionMembers[Int.random(in: 0..<firstFactionOnFight.factionMembers.count)])
            if firstFactionOnFight.factionMembers[firstRandom].health <= 0 {
                print(firstFactionOnFight.factionMembers[firstRandom].name + " выбили глаз! Стычка окончена!")
                winningFaction = secondFactionOnFight
                break
            }
            counter += 1
        }
        if counter == 15 {
            print("Палево, пришел директор! Стычка окончена!")
        }
        return winningFaction
    }
}
class FactionMember: Student {
    var weapon: Weapon = Weapon(name: "кулаки", damage: 3)
        
    var health: Int
    
    var damage: Int
    
    var factionShoutout: String
    
    var name: String
    
    var faction: Faction
    
    
    init(health: Int, damage: Int, name: String, faction: Faction) {
        self.faction = faction
        self.health = health + faction.healthBoost
        self.damage = damage + faction.damageBoost
        self.factionShoutout = faction.factionShoutout
        self.name = name
    }
    
    func attack(opponent: FactionMember) {
        print(name + " из " + faction.name + " атакует. Что же он будет делать?")
        let attackingStudentString: String = name + " из " + faction.name
        let opponentStudentString: String = opponent.name + " из " + faction.name
        
        let randomAttack: Int = Int.random(in: 1..<11)
        if randomAttack < 2 {
            print(attackingStudentString + " пытается обозвать " + opponentStudentString + "! " + opponentStudentString +  " не выглядит обиженым. " + attackingStudentString + "Наносит 0 урона")
        } else if randomAttack >= 2 && randomAttack < 6 {
            let damageWithWeapon: Int = weapon.damage + self.damage
            print(attackingStudentString + " использует " + weapon.name + "." + opponentStudentString + " получает " + String(damageWithWeapon) + " урона")
            opponent.health -= damageWithWeapon
        } else if randomAttack >= 6 && randomAttack < 10 {
            print(attackingStudentString + " использует силу фракции! Что же это?")
            opponent.health -= useFactionSkill(faction: self.faction)
        }
    }
    
    func useFactionSkill(faction: Faction) -> Int {
        print("Звучит кричалка фракции " + faction.name)
        print(faction.factionShoutout)
        let factionSkillDamage: Int = Int.random(in: 10..<20)
        print("Фракция наносит " + String(factionSkillDamage) + " урона оппоненту!")
        return factionSkillDamage
    }
    
}

let listOfGameWeapons: [Weapon] = [Weapon(name: "карандаш", damage: 5), Weapon(name: "кулаки", damage: 3), Weapon(name: "пистолет с пластмассовыми пулями", damage: 4)]
let listOfFraction: [Faction] = [Faction(name: "Power Bastards", healthBoost: 10, damageBoost: 15, canUseWeapon: false, startWeapon: listOfGameWeapons[1], factionShoutout: "Мы тебя сожрем, буквально блин! Да, мужики? *вокруг неловкое молчание*"), Faction(name: "Weapon Fucks", healthBoost: 10, damageBoost: 15, canUseWeapon: true, startWeapon: listOfGameWeapons[2], factionShoutout: "Мы на кулаках не выйдем. Только пушки, только легкий путь! Да, мужики? *вокруг выстрелы в потолок из пистолетиков пластмассовыми пульками*")]

listOfFraction[0].factionMembers.append(FactionMember(health: 100, damage: 3, name: "Josh", faction: listOfFraction[0]))
listOfFraction[0].factionMembers.append(FactionMember(health: 100, damage: 3, name: "Johnny", faction: listOfFraction[0]))
listOfFraction[1].factionMembers.append(FactionMember(health: 80, damage: 4, name: "Weaponer", faction: listOfFraction[1]))
listOfFraction[1].factionMembers.append(FactionMember(health: 80, damage: 4, name: "Betty", faction: listOfFraction[1]))

class SchoolHallway: Arena {
    var firstFactionOnFight: Faction
    
    var secondFactionOnFight: Faction
    
    var availableWeapons: [Weapon] = [listOfGameWeapons[0], listOfGameWeapons[1], listOfGameWeapons[2]]
    
    func startBattle() {
        print("Ну вот опять? Началась стычка между " + firstFactionOnFight.name + " и " + secondFactionOnFight.name + "!")
        let winningFaction: Faction? = factionFight(firstFactionOnFight: firstFactionOnFight, secondFactionOnFight: secondFactionOnFight)
        
        var deadMembers: [FactionMember] = []
        for factionMember in firstFactionOnFight.factionMembers {
            if factionMember.health <= 0 {
                deadMembers.append(factionMember)
            }
        }
        
        for factionMember in secondFactionOnFight.factionMembers {
            if factionMember.health <= 0 {
                deadMembers.append(factionMember)
            }
        }
        
        if winningFaction == nil{
            print("Итоги стычки: битва окончилась ничьей.")
        } else {
            print("Итоги стычки: победила фракция " + winningFaction!.name + "! Потери фракций: ")
            for deadMember in deadMembers {
                print(deadMember.name)
            }
        }
    }
    
    
    init(firstFactionOnFight: Faction, secondFactionOnFight: Faction) {
        self.firstFactionOnFight = firstFactionOnFight
        self.secondFactionOnFight = secondFactionOnFight
    }
    
}

class Game {
    func startGame() {
        let schoolHallwayArena: SchoolHallway = SchoolHallway(firstFactionOnFight: listOfFraction[0], secondFactionOnFight: listOfFraction[1])
        schoolHallwayArena.startBattle()
    }
    func preparingGame() {
        
    }
}


let game: Game = Game()
game.startGame()

//: [Next](@next)
