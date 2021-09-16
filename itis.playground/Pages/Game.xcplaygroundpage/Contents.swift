/*
 Правила
 В игре присутствует 4 класса
 Каждый бой состоит из нескольких раундов, игра заканчивается, когда все игроки одной из команд погибают
 В каждом раунде сражается случайный игрок из первой команды - с случайным игроком из второй команды
 Команды - это две случайные фракции по 4 игрока в каждой
 Сражение происходит на землях первой команды, у случайного игрока из этой команды может быть преимущество локации - шанс 50%(один раз за игру)
 Сила удара у каждого игрока случайна
 У каждого игрока есть суперсила(зависит от класса) - можно использовать 1 раз за раунд(шанс 50%)
 У каждого класса существует различная выносливость(после определенного уровня здоровья сила удара игрока снижается на 30%)
 */

import UIKit

protocol Student {
    var nameOfFraction: String { get }
    var name: String { get }
    var nickname: String? { get set }
    var healthPoint: Int { get set }
    var damagePower: Int { get set}
    var cheer: String { get }
    
    func attack() -> Int
    func peculiarity()
}

protocol Arena {
    var firstTeam: [Student] { get set }
    var secondTeam: [Student] { get set }
    
    func startBattle()
}

class Human: Student {
    let nameOfFraction = "Люди"
    let name: String
    var nickname: String?
    var healthPoint = 100
    var damagePower = Int.random(in: 20...30)
    let cheer: String
    
    func attack() -> Int {
        guard self.healthPoint > 40 else {
            return Int(Double(damagePower) * 0.7)
        }
        
        return damagePower
    }
    
    func peculiarity() {
        print("\(self.name) воспользовался мудростью Властелина Тьмы и повысил уровень урона на 15%")
        self.damagePower = Int(Double(damagePower) * 1.15)
    }
    
    init(name: String, nickname: String?, cheer: String ) {
        self.name = name
        self.nickname = nickname
        self.cheer = cheer
    }
}

class Elves: Student {
    let nameOfFraction = "Эльфы"
    let name: String
    var nickname: String?
    var healthPoint = 100
    var damagePower = Int.random(in: 18...33)
    let cheer: String
    
    init(name: String, nickname: String?, cheer: String ) {
        self.name = name
        self.nickname = nickname
        self.cheer = cheer
    }
    
    func attack() -> Int {
        guard self.healthPoint > 50 else {
            return Int(Double(damagePower) * 0.7)
        }
        
        return damagePower
    }
    
    func peculiarity() {
        print("\(self.name) переродился и с новыми силами вступил в бой")
    }
}

class Hobbit: Student {
    let nameOfFraction = "Хоббиты"
    let name: String
    var nickname: String?
    var healthPoint = 100
    var damagePower = Int.random(in: 24...28)
    let cheer: String
    var fatugueConfidat = 0.7
    
    init(name: String, nickname: String?, cheer: String ) {
        self.name = name
        self.nickname = nickname
        self.cheer = cheer
    }
    
    func attack() -> Int {
        guard self.healthPoint > 60 else {
            return Int(Double(damagePower) * fatugueConfidat)
        }
        
        return damagePower
    }
    
    func peculiarity() {
        print("\(self.name) выпил зелье и получил заряд бодрости")
        fatugueConfidat = 1.3
    }
}

class Orc: Student {
    let nameOfFraction = "Орики"
    let name: String
    var nickname: String?
    var healthPoint = 100
    var damagePower = Int.random(in: 20...30)
    let cheer: String
    
    init(name: String, nickname: String?, cheer: String ) {
        self.name = name
        self.nickname = nickname
        self.cheer = cheer
    }
    
    func attack() -> Int {
        guard self.healthPoint > 20 else {
            return Int(Double(damagePower) * 0.7)
        }
        
        return damagePower
    }
    
    func peculiarity() {
        print("\(self.nickname ?? self.name)с помощью магии увеличил силу урона на 30 единиц")
        self.damagePower += 30
    }
}

struct Place {
    static let nameOfPlaces: [String: String] = ["Люди": "Валинор", "Эльфы": "Аман", "Орки": "Нуменор", "Хоббиты": "Эребор"]
    
    var fraction:String
    var name:String
    
    init(fraction: String) {
        self.fraction = fraction
        self.name = Place.nameOfPlaces[fraction] ?? "Общие земли"
    }
    
    func bonus(student: Student) {
        if let human = student as? Human {
            print("\nСражение происходит на человечиских землях - 'Валинор'")
            
            if Bool.random(){
                print("\(human.name) воспользовался лечебными свойства вод Валинора - поплнил запас здоровья на 20 единиц")
                human.healthPoint += 20
            }
        }
        else if let elves = student as? Elves {
            print("\nСражение происходит на земле Эльфов - 'Аман'")
            
            if Bool.random(){
                print("\(elves.name) воспользовался помощью народа Эльдары")
                elves.damagePower += 20
            }
        }
        else if let hobbit = student as? Hobbit {
            print("\nСражениие происходит на земле Хоббитов - 'Эребор'")
            
            if Bool.random(){
                print("Свежий воздух горы открыл 'второе дызание' у студента '\(hobbit.name)'")
                hobbit.fatugueConfidat = 2
            }
        }
        else if let orc = student as? Orc {
            print("\nСражениие происходит на земле Орков - 'Нуменор'")
            
            if Bool.random(){
                print("Предки древних земель Нуменора подарили новые доспехи - студенту '\(orc.name)'")
                orc.healthPoint += 50
            }
        }
    }
}

class Battle: Arena {
    static let names = ["Арагорн", "Бильбо Бэггинс", "Том Бомбадил", "Боромир", "Водный Страж", "Галадриэль", "Гэндальф", "Даин II Железностоп", "Исилдур", "Келеборн", "Кирдан Корабел", "Леголас", "Мериадок Брендибак", "Перегрин Тук", "Теоден", "Фингон"]
    var firstTeam = [Student]()
    var secondTeam = [Student]()
    
    func startBattle() {
        let firstClass = Int.random(in: 1..<5)
        var secondClass = Int.random(in: 1..<5)
        while firstClass == secondClass {
            secondClass = Int.random(in: 1..<5)
        }
        
        print("Начало боя!")
        print("\nПервая команда:")
        firstTeam = teamRecruitment(numOfClass: firstClass)
        print("\nВторая команда:")
        secondTeam = teamRecruitment(numOfClass: secondClass)
        
        let place = Place(fraction: firstTeam[0].nameOfFraction)
        place.bonus(student: firstTeam[0])
        
        battleProcess()
        
    }
    
    func battleProcess () {
        var numberOfRound = 1
        
        while firstTeam.count != 0 && secondTeam.count != 0 {
            print("\n------------РАУНД \(numberOfRound)---------------")
            
            numberOfRound += 1
            
            let numberFirst = Int.random(in: 0..<firstTeam.count)
            var playerFromFirst = firstTeam[numberFirst]
            
            let numberSecond = Int.random(in: 0..<secondTeam.count)
            var playerFromSecond = secondTeam[numberSecond]
            
            print("В этом раунде сражается \(playerFromFirst.name) из 1-ой команды против \(playerFromSecond.name) из 2-ой команды!")
            
            playerFromSecond.healthPoint  -= hit(first: playerFromFirst, second: playerFromSecond)
            guard playerFromSecond.healthPoint > 0 else {
                secondTeam.remove(at: numberSecond)
                continue
            }
            
            playerFromFirst.healthPoint -= hit(first: playerFromSecond, second: playerFromFirst)
            guard playerFromFirst.healthPoint > 0 else {
                firstTeam.remove(at: numberSecond)
                continue
            }
        }
        
        if firstTeam.count > 0 {
            print("\nПобеду одержала команда - '\(firstTeam[0].nameOfFraction)'")
        }
        else{
            print("\nПобеду одержала команда - '\(secondTeam[0].nameOfFraction)'")
        }
        print("\nКонец боя!")
    }
    
    func hit(first: Student, second: Student) -> Int {
        if Bool.random() {
            first.peculiarity()
        }
        
        if second.healthPoint <= first.damagePower {
            print("\(first.name)  сокрушительным ударом уничтожил \(second.name)")
        }
        return first.attack()
    }
    
    func teamRecruitment(numOfClass: Int) -> [Student] {
        var array: [Student] = []
        switch numOfClass {
        case 1:
            for _ in 0..<4 {
                array.append(Human(name: Battle.names[Int.random(in: 0..<Battle.names.count)], nickname: "", cheer: "В бой!"))
                print("\(array.last!.name) - класс 'Люди'")
            }
        case 2:
            for _ in 0..<4 {
                array.append(Elves(name: Battle.names[Int.random(in: 0..<Battle.names.count)], nickname: "", cheer: "Соберемся воедино!"))
                print("\(array.last!.name) - класс 'Эльфы'")
            }
        case 3:
            for _ in 0..<4 {
                array.append(Hobbit(name: Battle.names[Int.random(in: 0..<Battle.names.count)], nickname: "", cheer: "За победой!"))
                print("\(array.last!.name) - класс 'Хоббиты'")
            }
        case 4:
            for _ in 0..<4 {
                array.append(Orc(name: Battle.names[Int.random(in: 0..<Battle.names.count)], nickname: "", cheer: "Ура!"))
                print("\(array.last!.name) - класс 'Орки'")
            }
        default:
            break
        }
        return array
    }
}


var game = Battle()
game.startBattle()


