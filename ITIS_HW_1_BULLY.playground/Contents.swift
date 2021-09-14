import UIKit

protocol Fraction{
    var name: String {get set}
    var aliveStudents: [Student] {get set}
    var deadStudents: [Student] {get set}
    
    func isDead() -> Bool
    
    func Attack(attackedFraction: Fraction)
    
    func lookForLoot()
    
    func updateInfoAboutStudents()
    
    func reviveAllStudents()
}

protocol Student{
    var hp: Int {get set}
    var hpMax: Int{get set}
    var damage: Int {get set}
    var fraction: String {get set}
    var shoutOut: String {get set}
    
    func isDead()->Bool
    
    func AttackBully(student: Bully)
    func AttackNerd(student: Nerd)
    func AttackPunk(student: Punk)
    func AttackJock(student: Jock)
    
    func lookForLoot()
}

protocol Arena{
    var fractionsForBattle: [Fraction] {get set}
    func startBattle(fractions: [Fraction])
}


class Bullies: Fraction{
    var name: String
    var aliveStudents: [Student]
    var deadStudents: [Student]
    
    init(name: String, students: [Student]){
        self.name = name
        self.aliveStudents = students
        deadStudents = []
    }
    
    func isDead() -> Bool{
        if aliveStudents.isEmpty{
            return true
        }
        return false
    }
    
    
    func Attack(attackedFraction: Fraction){
        for attackingStudent in self.aliveStudents{
            let attackedStudentNumber = Int.random(in: 0..<attackedFraction.aliveStudents.count)
            print("Студент из \(self.name) атакует Студента из \(attackedFraction.name)...")
            
            switch attackedFraction.name{
            case "Bullies":
                attackingStudent.AttackBully(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Bully)
                break
            case "Nerds":
                attackingStudent.AttackNerd(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Nerd)
                break
            case "Punks":
                attackingStudent.AttackPunk(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Punk)
                break
            case "Jocks":
                attackingStudent.AttackJock(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Jock)
                break
            default:
                break

            }
            
            
            if attackedFraction.aliveStudents[attackedStudentNumber].isDead(){
                print("Для студента из \(attackedFraction.name) это был критический урон!")
            }
            
            attackedFraction.updateInfoAboutStudents()
            if attackedFraction.isDead(){
                break
            }
        }
    }
    
    func lookForLoot(){
        print("\(self.name):")
        for player in self.aliveStudents{
            player.lookForLoot()
        }
    }
    
    func updateInfoAboutStudents(){
        var studentCounter = 0
        while studentCounter < self.aliveStudents.count{
            if self.aliveStudents[studentCounter].isDead(){
                self.deadStudents.append(self.aliveStudents[studentCounter])
                self.aliveStudents.remove(at: studentCounter)
                studentCounter -= 1
            }
            studentCounter += 1
        }
    }
    
    func reviveAllStudents(){
        for student in self.deadStudents{
            self.aliveStudents.append(student)
            deadStudents.removeAll()
        }
    }
}

class Bully: Student{
    var hp: Int = 12
    var hpMax: Int = 12
    var damage: Int = 6
    var fraction: String = "Bullies"
    var shoutOut: String = "BULLIES ARE COOL!"
    
    func isDead()->Bool {
        if self.hp < 1{
            return true
        }
        return false
    }
    
    func AttackBully(student: Bully){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackNerd(student: Nerd){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackPunk(student: Punk){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackJock(student: Jock){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func lookForLoot(){
        let randomValue = Int.random(in: 0..<12)
        if randomValue >= 0 && randomValue < 4{
            self.damage += 6
            print("Студент нашел артефакт на +6 дамага!")
        }
        if randomValue >= 4 && randomValue < 8{
            self.hp += 16
            print("Студент нашел артефакт на +16 HP!")
        }
        if randomValue >= 8 && randomValue < 10{
            self.damage += 12
            print("Студент нашел артефакт на +12 дамага!")
        }
        if randomValue >= 10 && randomValue < 12{
            self.hp += 24
            print("Студент нашел артефакт на +24 HP!")
        }
    }
}

class Nerds: Fraction{
    var name: String
    var aliveStudents: [Student]
    var deadStudents: [Student]
    
    init(name: String, students: [Student]){
        self.name = name
        self.aliveStudents = students
        deadStudents = []
    }
    
    func isDead() -> Bool{
        if aliveStudents.isEmpty{
            return true
        }
        return false
    }
    
    
    func Attack(attackedFraction: Fraction){
        for attackingStudent in self.aliveStudents{
            let attackedStudentNumber = Int.random(in: 0..<attackedFraction.aliveStudents.count)
            print("Студент из \(self.name) атакует Студента из \(attackedFraction.name)...")
            
            switch attackedFraction.name{
            case "Bullies":
                attackingStudent.AttackBully(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Bully)
                break
            case "Nerds":
                attackingStudent.AttackNerd(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Nerd)
                break
            case "Punks":
                attackingStudent.AttackPunk(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Punk)
                break
            case "Jocks":
                attackingStudent.AttackJock(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Jock)
                break
            default:
                break

            }
            
            
            if attackedFraction.aliveStudents[attackedStudentNumber].isDead(){
                print("Для студента из \(attackedFraction.name) это был критический урон!")
            }
            
            attackedFraction.updateInfoAboutStudents()
            if attackedFraction.isDead(){
                break
            }
        }
    }
    
    func lookForLoot(){
        print("\(self.name):")
        for player in self.aliveStudents{
            player.lookForLoot()
        }
    }
    
    func updateInfoAboutStudents(){
        var studentCounter = 0
        while studentCounter < self.aliveStudents.count{
            if self.aliveStudents[studentCounter].isDead(){
                self.deadStudents.append(self.aliveStudents[studentCounter])
                self.aliveStudents.remove(at: studentCounter)
                studentCounter -= 1
            }
            studentCounter += 1
        }
    }
    
    func reviveAllStudents(){
        for student in self.deadStudents{
            self.aliveStudents.append(student)
            deadStudents.removeAll()
        }
    }
}

class Nerd: Student{
    var hp: Int = 8
    var hpMax: Int = 8
    var damage: Int = 2
    var fraction: String = "Nerds"
    var shoutOut: String = "WE ARE THE SMARTEST!"
    
    func isDead()->Bool {
        if self.hp < 1{
            return true
        }
        return false
    }
    
    func AttackBully(student: Bully){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackNerd(student: Nerd){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackPunk(student: Punk){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackJock(student: Jock){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func lookForLoot(){
        let randomValue = Int.random(in: 0..<12)
        if randomValue >= 0 && randomValue < 4{
            self.damage += 6
            print("Студент нашел артефакт на +6 дамага!")
        }
        if randomValue >= 4 && randomValue < 8{
            self.hp += 16
            print("Студент нашел артефакт на +16 HP!")
        }
        if randomValue >= 8 && randomValue < 10{
            self.damage += 12
            print("Студент нашел артефакт на +12 дамага!")
        }
        if randomValue >= 10 && randomValue < 12{
            self.hp += 24
            print("Студент нашел артефакт на +24 HP!")
        }
    }
}

class Punks: Fraction{
    var name: String
    var aliveStudents: [Student]
    var deadStudents: [Student]
    
    init(name: String, students: [Student]){
        self.name = name
        self.aliveStudents = students
        deadStudents = []
    }
    
    func isDead() -> Bool{
        if aliveStudents.isEmpty{
            return true
        }
        return false
    }
    
    
    func Attack(attackedFraction: Fraction){
        for attackingStudent in self.aliveStudents{
            let attackedStudentNumber = Int.random(in: 0..<attackedFraction.aliveStudents.count)
            print("Студент из \(self.name) атакует студента из \(attackedFraction.name)...")
            
            switch attackedFraction.name{
            case "Bullies":
                attackingStudent.AttackBully(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Bully)
                break
            case "Nerds":
                attackingStudent.AttackNerd(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Nerd)
                break
            case "Punks":
                attackingStudent.AttackPunk(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Punk)
                break
            case "Jocks":
                attackingStudent.AttackJock(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Jock)
                break
            default:
                break

            }
            
            
            if attackedFraction.aliveStudents[attackedStudentNumber].isDead(){
                print("Для студента из \(attackedFraction.name) это был критический урон!")
            }
            
            attackedFraction.updateInfoAboutStudents()
            if attackedFraction.isDead(){
                break
            }
        }
    }
    
    func lookForLoot(){
        print("\(self.name):")
        for player in self.aliveStudents{
            player.lookForLoot()
        }
    }
    
    func updateInfoAboutStudents(){
        var studentCounter = 0
        while studentCounter < self.aliveStudents.count{
            if self.aliveStudents[studentCounter].isDead(){
                self.deadStudents.append(self.aliveStudents[studentCounter])
                self.aliveStudents.remove(at: studentCounter)
                studentCounter -= 1
            }
            studentCounter += 1
        }
    }
    
    func reviveAllStudents(){
        for student in self.deadStudents{
            self.aliveStudents.append(student)
            deadStudents.removeAll()
        }
    }
}

class Punk: Student{
    var hp: Int = 10
    var hpMax: Int = 10
    var damage: Int = 5
    var fraction: String = "Punks"
    var shoutOut: String = "STREET LIFE IS FOR US!"
    
    func isDead()->Bool {
        if self.hp < 1{
            return true
        }
        return false
    }
    
    func AttackBully(student: Bully){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackNerd(student: Nerd){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackPunk(student: Punk){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackJock(student: Jock){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func lookForLoot(){
        let randomValue = Int.random(in: 0..<12)
        if randomValue >= 0 && randomValue < 4{
            self.damage += 6
            print("Студент нашел артефакт на +6 дамага!")
        }
        if randomValue >= 4 && randomValue < 8{
            self.hp += 16
            print("Студент нашел артефакт на +16 HP!")
        }
        if randomValue >= 8 && randomValue < 10{
            self.damage += 12
            print("Студент нашел артефакт на +12 дамага!")
        }
        if randomValue >= 10 && randomValue < 12{
            self.hp += 24
            print("Студент нашел артефакт на +24 HP!")
        }
    }
}

class Jocks: Fraction{
    var name: String
    var aliveStudents: [Student]
    var deadStudents: [Student]
    
    init(name: String, students: [Student]){
        self.name = name
        self.aliveStudents = students
        deadStudents = []
    }
    
    func isDead() -> Bool{
        if aliveStudents.isEmpty{
            return true
        }
        return false
    }
    
    
    func Attack(attackedFraction: Fraction){
        for attackingStudent in self.aliveStudents{
            let attackedStudentNumber = Int.random(in: 0..<attackedFraction.aliveStudents.count)
            print("Студент из \(self.name) атакует Студента из \(attackedFraction.name)...")
            
            switch attackedFraction.name{
            case "Bullies":
                attackingStudent.AttackBully(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Bully)
                break
            case "Nerds":
                attackingStudent.AttackNerd(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Nerd)
                break
            case "Punks":
                attackingStudent.AttackPunk(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Punk)
                break
            case "Jocks":
                attackingStudent.AttackJock(student: attackedFraction.aliveStudents[attackedStudentNumber] as! Jock)
                break
            default:
                break

            }
            
            
            if attackedFraction.aliveStudents[attackedStudentNumber].isDead(){
                print("Для студента из \(attackedFraction.name) это был критический урон!")
            }
            
            attackedFraction.updateInfoAboutStudents()
            if attackedFraction.isDead(){
                break
            }
        }
    }
    
    func lookForLoot(){
        print("\(self.name):")
        for player in self.aliveStudents{
            player.lookForLoot()
        }
    }
    
    func updateInfoAboutStudents(){
        var studentCounter = 0
        while studentCounter < self.aliveStudents.count{
            if self.aliveStudents[studentCounter].isDead(){
                self.deadStudents.append(self.aliveStudents[studentCounter])
                self.aliveStudents.remove(at: studentCounter)
                studentCounter -= 1
            }
            studentCounter += 1
        }
    }
    
    func reviveAllStudents(){
        for student in self.deadStudents{
            self.aliveStudents.append(student)
            deadStudents.removeAll()
        }
    }
}

class Jock: Student{
    var hp: Int = 14
    var hpMax: Int = 14
    var damage: Int = 4
    var fraction: String = "Jocks"
    var shoutOut: String = "WANNA BE LIKE ARNOLD SCHWARZENEGGER!"
    
    func isDead()->Bool {
        if self.hp < 1{
            return true
        }
        return false
    }
    
    func AttackBully(student: Bully){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackNerd(student: Nerd){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackPunk(student: Punk){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func AttackJock(student: Jock){
        student.hp -= self.damage
        print("Студент из \(self.fraction) ударил студента из \(student.fraction)")
    }
    
    func lookForLoot(){
        let randomValue = Int.random(in: 0..<12)
        if randomValue >= 0 && randomValue < 4{
            self.damage += 6
            print("Студент нашел артефакт на +6 дамага!")
        }
        if randomValue >= 4 && randomValue < 8{
            self.hp += 16
            print("Студент нашел артефакт на +16 HP!")
        }
        if randomValue >= 8 && randomValue < 10{
            self.damage += 12
            print("Студент нашел артефакт на +12 дамага!")
        }
        if randomValue >= 10 && randomValue < 12{
            self.hp += 24
            print("Студент нашел артефакт на +24 HP!")
        }
    }
}


class Game{
    var aliveFractions: [Fraction] = []
    var deadFractions: [Fraction] = []
    
    func start(){
        var fractions: [Fraction] = []
        
        fractions.append(Bullies(name: "Bullies",
                                students: getStudents(fraction: "Bullies", amount: 5)))
        fractions.append(Nerds(name: "Nerds",
                                         students: getStudents(fraction: "Nerds", amount: 5)))
        fractions.append(Punks(name: "Punks",
                                 students: getStudents(fraction: "Punks", amount: 5)))
        fractions.append(Jocks(name: "Jocks",
                                 students: getStudents(fraction: "Jocks", amount: 5)))
        
            action(fractions: fractions)
    }
    
    func action(fractions: [Fraction])->Void{
        aliveFractions = fractions
        
        var roundCounter = 1
        while self.aliveFractions.count != 1{
            round(roundCounter: roundCounter)
            updateInfoAboutFractions()
            
            print("-----------------------------------------------")
            print("Выжившие фракции:")
            showAliveFractions()
            print("-----------------------------------------------")
            print("Выжившие студенты оживили своих союзников!")
            reviveAliveTeams()
            print("-----------------------------------------------")
            print("Все студенты восстановили HP")
            healAllStudents()
            print("-----------------------------------------------")
            print("Все студенты начали поиск лута...")
            loot()
            print("-----------------------------------------------")
            
            
            roundCounter += 1
            
        }
        
        print("Выиграла фракция \(aliveFractions[0].name)!")
    }
    
    func round(roundCounter: Int){
        print("Раунд - \(roundCounter)")
        
        for i in 0..<aliveFractions.count where i % 2 == 0{
            let firstTeamNumber = Int.random(in: i..<i+2)
            var secondTeamNumber = 0
            if firstTeamNumber == i{
                secondTeamNumber = i+1
            } else{
                secondTeamNumber = i
            }
            fight(firstFraction: self.aliveFractions[firstTeamNumber], secondFraction: self.aliveFractions[secondTeamNumber])
        }
    }
    
    func fight(firstFraction: Fraction, secondFraction: Fraction)->Void{
        while !firstFraction.isDead() && !secondFraction.isDead(){
            firstFraction.Attack(attackedFraction: secondFraction)
            if secondFraction.isDead(){
                print("\(secondFraction.name) повержена командой \(firstFraction.name)!")
                break
            }
            print("\(firstFraction.name) закончила ход")
            secondFraction.Attack(attackedFraction: firstFraction)
            if firstFraction.isDead(){
                print("\(firstFraction.name) повержена командой \(secondFraction.name)!")
                break
            }
            print("\(firstFraction.name) закончила ход")
        }
    }
    
    func loot(){
        for fraction in self.aliveFractions{
            fraction.lookForLoot()
        }
    }
    
    func reviveAliveTeams(){
        for fraction in self.aliveFractions{
            fraction.reviveAllStudents()
        }
    }
    
    func healAllStudents(){
        for fraction in self.aliveFractions{
            for var student in fraction.aliveStudents{
                student.hp = student.hpMax
            }
        }
    }
    
    func updateInfoAboutFractions() -> Void{
        var fractionCounter = 0
        while fractionCounter < self.aliveFractions.count{
            if self.aliveFractions[fractionCounter].isDead(){
                self.deadFractions.append(self.aliveFractions[fractionCounter])
                self.aliveFractions.remove(at: fractionCounter)
                fractionCounter -= 1
            }
            fractionCounter += 1
        }
    }
    
    func showAliveFractions() -> Void{
        for fraction in self.aliveFractions{
            print(fraction.name)
        }
    }
    func showDeadFractions() -> Void{
        print("Dead Teams:")
        for fraction in self.deadFractions{
            print(fraction.name)
        }
    }
    
    func getStudents(fraction: String, amount: Int) -> [Student]{
        var students: [Student] = []
        
        switch fraction{
        case "Bullies":
            for _ in 1...amount{
                students.append(Bully())
            }
            break
        case "Nerds":
            for _ in 1...amount{
                students.append(Nerd())
            }
            break
        case "Punks":
            for _ in 1...amount{
                students.append(Punk())
            }
            break
        case "Jocks":
            for _ in 1...amount{
                students.append(Jock())
            }
            break
        default:
            break
        }
        
        return students
    }
}

let newGame: Game = Game()
newGame.start()

