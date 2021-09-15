import UIKit

var countOfCommands: Int = 8
var countPeopleInCommand: Int = 5
var buf: Int = 0
var words: [String] = []


words.append("🔥💥Не дави на кнопочку, а то уколешь попочку.💥🔥")
words.append("🔥💥Мы не панки, не шпана, мы ребята Оба-На💥🔥")
words.append("🔥💥Обломаем все крючки - мы крутые червячки!💥🔥")
words.append("🔥💥Мы Бегущие в Ночи, если видел, то молчи.💥🔥")
words.append("🔥💥Нам всё до лампочки💥🔥")
words.append("🔥💥А у нас девиз таков - не пускать в дупло врагов!💥🔥")
words.append("🔥💥Петухи и курочки - разные фигурочки💥🔥")
words.append("🔥💥Ходим ночью, ходим, днем, мы никогда не устаем.💥🔥")
words.append("🔥💥Ветер дует в паруса , юность верит а чудеса.💥🔥")


struct SimplePlayer {
    var hp: Int
    var damage: Int
    var isAlive: Bool = true
    var bufPerson: Int = 0
}

enum Place: String, CaseIterable{
    case City
    case Field
    case Swamp
    case Mountains
    
    func setBuf() {
        buf = Int.random(in: -2...2)
    }
    
}

let randomPlace = Place.allCases.randomElement()!

class Command {
    var random = Int.random(in: 0...2)
    var name: String
    var allPlayers = [SimplePlayer]()
    var slogans: String
    
    init(name: String) {
        self.name = name
        self.slogans = words[random]
    }
    
    func powerOfTeam() -> Int {
        var power = 0
        
        for player in allPlayers {
            power += player.damage
        }
        return power
    }
    
    func setPower(power: Int) {
        for i in 0..<allPlayers.count {
            allPlayers[i].damage += buf
        }
    }
}

var allComands = [Command]()


class Game {
    func createACommads() { // заполнение команд играками
        for i in 0..<countOfCommands {
            allComands.append(Command.init(name: "Command \(i + 1)"))
            for _ in 0..<countPeopleInCommand {
                allComands[i].allPlayers.append(SimplePlayer.init(hp: Int.random(in: 1...10), damage: Int.random(in: 1...5)))
            }
        }
    }
    
    func round() { // раунды самой игры
        
        var newCommand = [Command]()
        
        for i in 0..<allComands.count / 2 {
            let secondCount = allComands.count - i - 1
            print("⚔️🛡\(allComands[i].name) and \(allComands[secondCount].name) figting🛡⚔️")
            if allComands[i].powerOfTeam() > allComands[secondCount].powerOfTeam() {
                let firstRandom: Int = Int.random(in: 0...1)
                if firstRandom == 0 {
                    print("        🎖\(allComands[i].name) win🎖")
                } else {
                    print("\(allComands[i].name) won and shouts its slogan \(allComands[i].slogans)")
                    print("        🎖\(allComands[i].name) win🎖")
                }
                newCommand.append(allComands[i])
            } else {
                let secondRandom: Int = Int.random(in: 0...1)
                if secondRandom == 0 {
                    print("        🎖\(allComands[secondCount].name) win🎖")
                } else{
                    print("\(allComands[secondCount].name) won and shouts its slogan \(allComands[secondCount].slogans)")
                    print("        🎖\(allComands[secondCount].name) win🎖")
                }
                newCommand.append(allComands[secondCount])
            }
        }
        allComands = newCommand
    }
}

var count = 0
var secondCountOfComand = countOfCommands

while(secondCountOfComand != 1){
    secondCountOfComand = secondCountOfComand / 2
    count += 1
}


var game = Game.init()
game.createACommads()
print("Figting on map '\(randomPlace)'")
for i in 0..<count{
    print()
    print("start \(i+1) round")
    randomPlace.setBuf()
    // выбирается рандомная команда на которую подействует карта
    let flag = Int.random(in: 1...allComands.count)
    print("\(allComands[flag - 1].name) was affected by the map")
    print("Damage before affect: \(allComands[flag - 1].powerOfTeam())")
    if buf > 0 {
        print("        💉💊Affect: Plus \(buf) to damage💊💉")
    } else {
        print("            💀💀Affect: \(buf) to damage💀💀")
    }
    
    allComands[flag - 1].setPower(power: buf)
    print("Damage after affect: \(allComands[flag - 1].powerOfTeam())")
    print()
    game.round()
}


