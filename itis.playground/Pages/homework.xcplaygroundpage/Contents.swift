
import Foundation


// MARK: - ООП
protocol PTransport{
    var brand: String { get  }
    var speed: Int { get  }
}

class Transport: PTransport{
    private (set) var brand: String
    private (set) var speed: Int
    
    
    func drive(){
        print("Driving \(brand) with speed: \(speed)")
    }
    
    init(speed: Int, brand: String) {
        self.speed = speed
        self.brand = brand
    }
}

class LandTransport: Transport{
    private var hasEngine: Bool
    
    init(speed: Int, brand: String, hasEngine: Bool) {
        self.hasEngine = hasEngine
        super.init(speed: speed, brand: brand)
    }
    
    override func drive(){
        if(hasEngine == true)
        {
            startTransport()
        }
        super.drive()
    }
    
    func bumpInto(transport: PTransport){
        print("Bump into \(transport.brand)")
    }
    
    private func startTransport(){
        print("The transport is started")
    }
}

class AirTransport: Transport{
    var forWar: Bool
    
    init(speed: Int, brand: String, forWar: Bool) {
        self.forWar = forWar
        super.init(speed: speed, brand: brand)
    }
}

//var MyCar = LandTransport(speed: 10, brand: "audi", hasEngine: true)
//MyCar.drive()
//
//var MyAirPlane = AirTransport(speed: 200, brand: "Boeing", forWar: false)
//MyAirPlane.drive()



// MARK: - Реализовать структуру данных дробное число в виде (4/5, где 4 числитель, а 5 знаменатель). Добавить операции умножения, деления, вывода, сложения, вычитания

class Faction{
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func multiplyBy(faction: Faction) {
        numerator = numerator * faction.numerator
        denominator = denominator * faction.denominator
    }
    
    func divideBy(faction: Faction) {
        numerator = numerator * faction.denominator
        denominator = denominator * faction.numerator
    }
    
    func addWith(faction: Faction) {
        numerator = numerator * faction.denominator + denominator * faction.numerator
        denominator = denominator * faction.denominator
    }
    
    func substractFrom(faction: Faction) {
        numerator = numerator * faction.denominator - denominator * faction.numerator
        denominator = denominator * faction.denominator
    }
    
    func print(){
        Swift.print("\(numerator) / \(denominator)")
    }
}

var a = Faction(numerator: 2, denominator: 3)
var b = Faction(numerator: 2, denominator: 3)

//a.addWith(faction: b)
//a.print()
//a.substractFrom(faction: b)
//a.print()
//a.divideBy(faction: b)
//a.print()
//a.multiplyBy(faction: b)
//a.print()

// MARK: - Bully

//Вводные данные: есть протокол учеников Student от которого мы можем создать других учеников и протокол Arena, который имеет массив из двух фракции и метод startBattle()
//У каждого ученика есть Здоровье, Урон, Кричалка, Имя (зависит от фракции). Так же ученики могут атаковать можете придумать дополнительные методы.
//Студенты могут принадлежать одной из 4 фракций (сами придумаете)

//Бой:
//Мы будем реализовывать сценарий схватки двух фракций в которых есть N учеников в одной фракции и M учеников во второй фракции.
//Бой может проходить на разных площадках (придумайте сами), которые могут иметь или не иметь свои пагубные и положительные последствия для учеников (в общем ваша фантазия не ограничена).
//После начала битвы можно услышать кричалки и увидеть кто на кого полез драться
//Правила битвы описываете сами, главное, чтобы по результатам битвы в консоль было выведено: какая фракция победила и какие потери понесли фракции. Критерии победы можете придумать сами.



let NAMES = ["Liam", "Olivia", "Noah", "Emma", "Oliver", "Ava", "Elijah", "Charlotte", "William", "Sophia", "James", "Amelia", "Benjamin", "Lucas", "Mia", "Henry", "Evelyn", "Alexander", "Harper"]

protocol Student{
    var name: String { get set }
    var health: Int { get set }
    var damage: Int { get set }
    var luck: Int { get set }
    
    init(name: String)
    
    func attack(student: Student)
    func isAlive() -> Bool
}

protocol Arena{
    var factionOne: [Student] { get set }
    var factionTwo: [Student] { get set }
    var description: String { get set }
    
    func startBattle(attacker: Team, defender: Team) -> Team
}

extension Arena{
    // return killed team
    func startBattle(attacker: Team, defender: Team) -> Team{
        while attacker.isAlive() && defender.isAlive() {
            
            var attackerPlayer = attacker.students.randomElement()
            var defenderPlayer = defender.students.randomElement()
            attackerPlayer?.attack(student: defenderPlayer!)
            
            print("\(attackerPlayer?.name ?? "") напал на \(defenderPlayer?.name ?? "")")
            if !defenderPlayer!.isAlive() {
                print("\(defenderPlayer?.name ?? "") умер в ходе битвы")
                if let index = defender.students.firstIndex(of: defenderPlayer!) {
                    defender.students.remove(at: index)
                }
            }
            
            attackerPlayer = attacker.students.randomElement()
            defenderPlayer = defender.students.randomElement()
            defenderPlayer?.attack(student: attackerPlayer!)
            
            print("\(defenderPlayer?.name ?? "") напал на \(attackerPlayer?.name ?? "")")
            if !attackerPlayer!.isAlive() {
                print("\(attackerPlayer?.name ?? "") умер в ходе битвы")
                if let index = attacker.students.firstIndex(of: attackerPlayer!) {
                    attacker.students.remove(at: index)
                }
            }
        }
        
        if attacker.isAlive() {
            return attacker
        }
        return defender
    }
}

class Guy: Student, Equatable{
    var name: String
    var health: Int
    var damage: Int
    var luck: Int
    
    required init(name: String) {
        self.name = name
        self.health = 20
        self.damage = 4
        self.luck = 2
    }
    
    func attack(student: Student){
        if student.isAlive() {
            if (Int.random(in: 0...9) > 4){
                var opponent = student
                opponent.health -= damage
            }
        }
    }
    
    func isAlive() -> Bool{
        if health > 0 {
            return true
        }
        return false
    }
    
    static func == (lhs: Guy, rhs: Guy) -> Bool {
        return lhs.name == rhs.name
    }
}

class Hooligan: Guy{
    required init(name: String) {
        super.init(name: name)
        health = 22
        damage = 5
        luck = 0
    }
}

class Botanist: Guy{
    required init(name: String) {
        super.init(name: name)
        health = 17
        damage = 4
        luck = 3
    }
}

class Clown: Guy{
    required init(name: String) {
        super.init(name: name)
        health = 19
        damage = 3
        luck = 5
    }
}

class Major: Guy{
    required init(name: String) {
        super.init(name: name)
        health = 25
        damage = 3
        luck = 2
    }
}

class Toilet: Arena{
    var factionOne: [Student] = []
    var factionTwo: [Student] = []
    var description: String = "Туалет"
}

class СhemistryСlass: Arena{
    var factionOne: [Student] = []
    var factionTwo: [Student] = []
    var description: String = "Кабинет химии"
}

class Tsum: Arena{
    var factionOne: [Student] = []
    var factionTwo: [Student] = []
    var description: String = "ЦУМ"
}

class StandUpClub: Arena{
    var factionOne: [Student] = []
    var factionTwo: [Student] = []
    var description: String = "СтэндапКлуб"
}

class Team{
    var name: String
    var description = ""
    var students = [Guy]()
    
    init(faction: [Guy], name: String) {
        self.name = name
        let rand = Int.random(in: 3...6)
        
        for _ in 0...rand{
            let student = Guy(name: NAMES[Int.random(in: 0...18)])
            
            students.append(student)
            description.append("\(student.name) ")
        }
    }
    
    func isAlive() -> Bool{
        if students.count > 1
        {
            return true
        }
        return false
    }
    
    func buff(){
        for student in 0...students.count{
            students[student].health += 2
        }
    }
}

class GameController{
    var hooligans = [Hooligan]()
    var botanists = [Botanist]()
    var clowns = [Clown]()
    var majors = [Major]()
    var teams = [Team]()
    var survivedTeams = [Team]()
    var arenas: [Arena] = [Toilet(), Tsum(), StandUpClub(), СhemistryСlass()]
    
    private func preparing(){
        print("Создание команд...")
        
        teams.append(Team(faction: hooligans, name: "Killers"))
        teams.append(Team(faction: botanists, name: "Сhemists"))
        teams.append(Team(faction: clowns, name: "Jokers"))
        teams.append(Team(faction: majors, name: "Millionaires"))
        
        print("Команды готовы к битве!\n")
    }
    
    func start(){
        preparing()
        
        print("Команды высадились на остров")
        while teams.count > 1 {
            print("___Поиск лута___")
            lootSearching()
            print("___Поиск лута завершен___")
            print()
            
            for i in 0..<teams.count where i % 2 == 0 {
                let firstTeam = teams[i]
                let secondTeam = teams[i + 1]
                
                let randArena = Int.random(in: 0...arenas.count)
                let arena = arenas[randArena]
                print("___Команда \(firstTeam.name) напала на команду \(secondTeam.name) в \(arena.description)")
                
                let newSurvivedTeam = arena.startBattle(attacker: firstTeam, defender: secondTeam)
                
                print("-После битвы у команды \(newSurvivedTeam.name) осталось \(newSurvivedTeam.students.count) студента-")
                survivedTeams.append(newSurvivedTeam)
                
                print("===Команда \(newSurvivedTeam.name) победила===\n")
            }
            CreateNewTournament()
        }
        print("Команда \(teams.first!.name) победила")
    }
    
    func lootSearching(){
        for i in 0...teams.count - 1 {
            for _ in teams[i].students{
                let found = Int.random(in: 0...2)
                
                if(found == 0){
                    let damage = Int.random(in: 1...3)
                    let player = teams[i].students.randomElement()
                    player?.health -= damage
                    print("Студент \(player?.name ?? "ERROR") попал в ловушку, к жизням -\(damage)")
                }
                
                if(found == 1){
                    let weapon = Int.random(in: 1...3)
                    let player = teams[i].students.randomElement()
                    player?.damage += weapon
                    print("Студент \(player?.name ?? "ERROR") получил к урону +\(weapon)")
                }
                
                if(found == 2){
                    let heal = Int.random(in: 1...3)
                    let player = teams[i].students.randomElement()
                    player?.damage += heal
                    print("Студент \(player?.name ?? "ERROR") получил к жизням +\(heal)")
                }
            }
        }
    }
    
    func CreateNewTournament()
    {
        teams.removeAll()
        for team in survivedTeams {
            teams.append(team)
        }
        survivedTeams.removeAll()
    }
}

var game = GameController()
game.start()
