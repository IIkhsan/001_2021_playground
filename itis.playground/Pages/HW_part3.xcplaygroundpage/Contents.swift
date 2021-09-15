import Foundation

protocol Student {
    var name: String { get set }
    var hp: Int { get set }
    var dmg: Int { get set }
    var shout: String { get set }
    
    func makeDamage(attacker: Student)
}

class Damage: Student {
    var name = "Штурм"
    var hp = 100
    var dmg = 50
    var shout = "Никто не догонит, никто не остановит!"
    
    func makeDamage(attacker: Student) {
        let ph = Int.random(in: 0...9)
        if (ph > 4) {
            self.hp-=attacker.dmg
            print("Урон прошёл! Теперь у жертвы \(self.hp) HP")

        } else {
            print("Урон не прошёл")
        }
    }
}

class Tank: Student {
    var name = "Танк"
    var hp = 150
    var dmg = 30
    var shout = "Турбосвинство!"
    
    func makeDamage(attacker: Student) {
        let ph = Int.random(in: 0...9)
        if (ph > 3){
            self.hp-=attacker.dmg
            print("Урон прошёл! Теперь у жертвы \(self.hp) HP")

        } else {
            print("Урон не прошёл")
        }
    }
    
}

class Defense: Student {
    var name = "Оборона"
    var hp = 80
    var dmg = 60
    var shout = "Застыньте, не шевелитесь!"
    
    func makeDamage(attacker: Student) {
        let ph = Int.random(in: 0...9)
        if (ph > 5){
            self.hp-=attacker.dmg
            print("Урон прошёл! Теперь у жертвы \(self.hp) HP")

        } else {
            print("Урон не прошёл")
        }
    }
}

class Support: Student {
    var name = "Поддержка"
    var hp = 100
    var dmg = 30
    var shout = "Герои не умирают!"
    
    func makeDamage(attacker: Student) {
        let ph = Int.random(in: 0...9)
        if (ph > 3){
            self.hp-=attacker.dmg
            print("Урон прошёл! Теперь у жертвы \(self.hp) HP")
            let ph2 = Int.random(in: 0...9)
            if (ph2 > 5){
                print("Противник восстановил себе здоровье, текущий уровень: \(self.hp)")
                self.hp+=attacker.dmg
            }

        } else {
            print("Урон не прошёл")
        }
    }
}


class Fraction {
    var studentsArray : [Student] = []

    init() {
        let randomStudentsCount = Int.random(in: 4...7)
        for _ in 1...randomStudentsCount{
            let ph = Int.random(in: 1...4)
            switch ph {
            case 1:
                studentsArray.append(Damage.init())
            case 2:
                studentsArray.append(Tank.init())
            case 3:
                studentsArray.append(Defense.init())
            case 4:
                studentsArray.append(Support.init())
            default:
                studentsArray.append(Damage.init())
            }
        }
    }
    
    
}

protocol Arena {
    var round: Int { get set }
    var fraction1: [Student] { get set }
    var fraction2: [Student] { get set }
    
    func startBattle()
}

class VolskayaIndustries: Arena {
    var round: Int = 1
    var fraction1: [Student] = []
    var fraction2: [Student] = []
    
    func startBattle() {
        print("     Бррр, в КБ Вольской сегодня холодновато! У всех игроков понижен уровень здоровья и атаки")
        let team1 = Fraction.init()
        for i in 0...team1.studentsArray.count - 1 {
            team1.studentsArray[i].hp -= 35
            team1.studentsArray[i].dmg -= 15
        }
        fraction1 = team1.studentsArray
        let team2 = Fraction.init()
        for i in 0...team2.studentsArray.count - 1 {
            team2.studentsArray[i].hp -= 35
            team2.studentsArray[i].dmg -= 15
        }
        fraction2 = team2.studentsArray

        
        var stillPlaying: Bool = true
        while stillPlaying {
            print("             Раунд \(round) начался")

            let randomPlayer1 = Int.random(in: 0...team1.studentsArray.count-1)
            let randomPlayer2 = Int.random(in: 0...team2.studentsArray.count-1)

            let target = team2.studentsArray[randomPlayer2]
            
            
            print("Игрок \(randomPlayer1+1) из фракции \(fraction1[randomPlayer1].name) атакует игрока \(randomPlayer2+1) из фракции \(fraction2[randomPlayer2].name)")
            print()
            print("Один из игроков кричит: \((fraction1[randomPlayer1].shout))")
            print("А голос ему в ответ: \((fraction2[randomPlayer2].shout))")

            
            target.makeDamage(attacker: fraction1[randomPlayer1])
            if target.hp<1  {
                print("Жертва убита")
                team2.studentsArray.remove(at: randomPlayer2)
                if (team2.studentsArray.count < 1){
                    print("Матч завершен!")
                    print("Победила команда 1. Вот наши чемпионы слева направо: ")
                    Technical.init().showEndgameScoreboard(winnerArray: team1.studentsArray)
                    stillPlaying = false
                    break
                }
            } else {
                print("             Раунд \(round) окончен")
                round += 1
            }
            
        }
    }
        
}



var volskaya = VolskayaIndustries.init()
volskaya.startBattle()

class Technical {
    func showEndgameScoreboard(winnerArray: [Student]) {
        for i in 0...winnerArray.count - 1 {
            print(winnerArray[i].name,"- остаток здоровья: \(winnerArray[i].hp) HP")
        }
    }
}
