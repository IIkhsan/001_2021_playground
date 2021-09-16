import UIKit
import Foundation

var numberOfTeams = 4

class Team {
    var players: [Optional<Player>] = [Optional<Player>]()
    var isInvoked = false
    var isAlive = true
    var name: Int
    init(name: Int) {
        for i in 1...5 {
            players.append(Player(name: i, teamName: name))
        }
        self.name = name
    }
    
    var numOfPlayers: Int{
        var s = 0
        for player in players{
            if(player != nil){
                s+=1
            }
        }
        return s
    }
    
    func commonDamage() -> Int {
        if self.isAlive {
            var result = 0;
            for p in players{
                result+=p?.damage ?? 0
            }
            return result
        }else {
            return 0
        }
    }
    
    func commonHP() -> Int {
        var result = 0
        for p in players{
            result+=p?.hp ?? 0
        }
        return result
    }
    
    func getDamage(bigDamage: Int) -> Void {
        if bigDamage != 0{
            print("--Команда ", name, " получает урон ", bigDamage)
            let numberOfPlayers = numOfPlayers
            
            if bigDamage>=self.commonHP() {
                print("\n^ ^ ^ ^ ^ Спасибо за участие, команда ", name, "! На сегодня это всё ^ ^ ^ ^ ^")
                isAlive = false
            } else{
                let damage = bigDamage / numberOfPlayers
                players[Int.random(in: 0..<numberOfPlayers)]?.getDamage(damage: bigDamage % numberOfPlayers)
                
                for i in 0..<numberOfPlayers {
                    players[i]?.getDamage(damage: damage)
                    if !(players[i]?.isAlive ?? false) {
                        players[i] = nil
                    }
                }
            }
        }
    }
}

class Player{
    var hp: Int
    var damage: Int
    var isAlive = true
    var name: Int
    var teamName: Int
    
    init(name: Int, teamName: Int) {
        self.hp = Int.random(in: 50..<63)
        self.damage = Int.random(in: 15..<22)
        self.name = name
        self.teamName = teamName
    }
    
    func getDamage(damage: Int) -> Void {
        if hp<=damage {
            print("Попрощаемся с Игроком ", name, " из команды ", teamName, ". Для него эта игра окончена")
            isAlive = false
        } else{
            hp-=damage
        }
    }
    
    func getHP(hp: Int) -> Void {
        self.hp+=hp
    }
    
    func getLoot(loot: Int) -> Void {
        self.damage+=loot
    }
}

var teams: [Team] = [Team]()

for i in 1...numberOfTeams {
    teams.append(Team(name: i))
}

func fight(opponent1 t1: Team, opponont2 t2: Team)->Team{
    print("\nДа начнется бой между командами ", t1.name, " ", t2.name, "\n")
    var winner: Team
    while t1.isAlive, t2.isAlive {
        t1.getDamage(bigDamage: t2.commonDamage())
        t2.getDamage(bigDamage: t1.commonDamage())
    }
    winner = t1.isAlive ? t1 : t2
    
    print(" * * * Поприветствуем победителя этой схватки! Команда ", winner.name, ", приглашаем в следующий тур! * * * \n")
    return winner
}

func round(teams: [Team])->[Team]{
    print("ВНИМАНИЕ! Начинается новый тур!")
    var winners = [Team]()
    
    let numberOfFights = teams.count/2
    
    for _ in 0..<numberOfFights{
        winners.append(fight(opponent1: randomOpponent(teams: teams), opponont2: randomOpponent(teams: teams)))
    }
    
    func randomOpponent(teams: [Team])->Team{
        let n = teams.count
        var numOfTeam: Int
        var result: Team
        repeat{
            numOfTeam = Int.random(in: 0..<n)
            result = teams[numOfTeam]
        }while result.isInvoked
        teams[numOfTeam].isInvoked = true
        return result
    }
    
    return winners
}

func searching(team: Team){
    print("команда ", team.name, " призы за внимательный поиск")
    for player in team.players {
        if player != nil {
            var exp: Experience
            switch Int.random(in: 0...2) {
            case 0:
                exp = goodExperience[Int.random(in: 0...2)]
            case 1:
                exp = badExperience[Int.random(in: 0...2)]
            default:
                exp = neutralExperience[Int.random(in: 0...2)]
            }
            
            print(" ", player!.name, exp.event)
            if(exp.isForTeam){
                for player in team.players{
                    player?.getDamage(damage: exp.damage)
                    player?.getHP(hp: exp.hp)
                }
            }else{
                player?.getHP(hp: exp.hp)
                player?.getLoot(loot: exp.loot)
            }
        }
    }
}

struct Experience{
    let event: String
    let damage: Int
    let hp: Int
    let loot: Int
    let isForTeam: Bool
}

var goodExperience = [Experience]()
goodExperience.append(Experience(event: " нашел бронежилет, в кармане которого обнаружились пули\n",
                                 damage: 0, hp: 15, loot: 4, isForTeam: false))
goodExperience.append(Experience(event: " набрел на лагерь целителей\n",
                                 damage: 0, hp: 50, loot: 0, isForTeam: false))
goodExperience.append(Experience(event: " обнаружил целебные травы и сделал отвар для всей команды\n",
                                 damage: 0, hp: 7, loot: 0, isForTeam: true))

var badExperience = [Experience]()
badExperience.append(Experience(event: " сломал ногу. Зайцу. Отвлекся на писк и не заметил ядовитый плющ перед лицом\n",
                                 damage: 10, hp: 0, loot: 0, isForTeam: false))
badExperience.append(Experience(event: " наткнулся на вражеское снаряжение. Отряд не заметил потери бойца\n",
                                 damage: 500, hp: 50, loot: 0, isForTeam: false))
badExperience.append(Experience(event: " упал в яму и вся команда потратила время и силы на то, чтобы его оттуда достать\n",
                                 damage: 4, hp: 0, loot: 0, isForTeam: true))

var neutralExperience = [Experience]()
neutralExperience.append(Experience(event: " зазевался и пропустил весь поиск лута\n",
                                 damage: 0, hp: 0, loot: 0, isForTeam: false))
neutralExperience.append(Experience(event: " бегал за бабочками, ибо рыскать в лесу в поисках снаряжения выше его достоинства\n",
                                 damage: 0, hp: 0, loot: 0, isForTeam: false))
neutralExperience.append(Experience(event: " честно пытался найти что-то полезное, но не всем везёт в этой игре\n",
                                 damage: 0, hp: 0, loot: 0, isForTeam: false))

while(teams.count != 1){
    for team in teams {
        searching(team: team)
        team.isInvoked = false
    }
    
    teams = round(teams: teams)
}
print("\n \n \nПоздравляем с победой команду ", teams.remove(at: 0).name, "!!!")
print("\nСпасибо всем за участие, приглашаем команды на праздничный фуршет в холле.\n \n \n")
