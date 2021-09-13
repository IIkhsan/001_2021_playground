
import Foundation

//MARK OOP
class User{
    
    var name:String
    var email:String
    var age:Int
    
    init(_ name:String,_ email:String,_ age:Int) {
        self.name=name
        self.email=email
        self.age=age
    }
    
    func repostAction(action:Action) {
        print(name," reposted: \n",action.show())
    }
    
    func greeting(){
        print("Hello world! I am ", name, " and I am new here...")
    }
    
    func greeting(anotherUser:User){
        print("Hello, ",anotherUser.name,"! I am ", name, ".")
    }
    
}

class Admin: User{
    
    var adminLevel:Int
    
    init(_ name:String,_ email:String,_ age:Int,_ adminLevel:Int) {
        self.adminLevel = adminLevel
        super.init(name, email, age)
    }
    
    override func greeting(){
        print("Hello users! I am ", name, " and I am admin here!")
    }
}

class Action{
    var user:User
    
    init(_ user:User) {
        self.user = user
    }
    
    func show(){}
}

class Message:Action{
    var text:String
    
    init(_ user:User,_ text:String) {
        self.text = text
        super.init(user)
    }
    
    override func show() {
        print(user.name,"sent a message: ",text)
    }
    
}

class Image:Action{
    var verticalPixels:Int
    var horizontalPixels:Int
    
    init(_ user:User, _ vertical:Int,_ horizontal:Int) {
        self.verticalPixels = vertical
        self.horizontalPixels = horizontal
        super.init(user)
    }
    
    override func show() {
        print(user.name,"sent an image. Its resolution is",horizontalPixels,"*",verticalPixels)
    }
    
}

var u1 = User("Peter", "efeeev", 13)
var u2 = Admin("Terence", "fgrg", 30,2)
var act1 = Image(u1, 1920,1080)
u2.greeting(anotherUser: u1)
u2.repostAction(action: act1)


//MARK fractions
struct Fraction {
    var numerator:Int
    var denominator:Int
    
    init(_ numerator:Int,_ denominator:Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func show() {
        print(numerator,"/",denominator)
        
    }
    
    static func +(_ left: Fraction, _ right: Fraction) -> Fraction {
        
        var editedLeft = left
        var editedRight = right
        if left.denominator != right.denominator {
            editedLeft = Fraction(left.numerator * right.denominator, left.denominator * right.denominator)
            editedRight = Fraction(right.numerator * left.denominator,right.denominator * left.denominator)
        }
        
        var newFraction = Fraction(editedLeft.numerator + editedRight.numerator, editedLeft.denominator)
        newFraction.NOD()
        return newFraction
    }
    
    static func -(_ left: Fraction, _ right: Fraction) -> Fraction {
        
        var editedLeft = left
        var editedRight = right
        if left.denominator != right.denominator {
            editedLeft = Fraction(left.numerator * right.denominator, left.denominator * right.denominator)
            editedRight = Fraction(right.numerator * left.denominator,right.denominator * left.denominator)
        }
        
        var newFraction = Fraction(editedLeft.numerator - editedRight.numerator, editedLeft.denominator)
        newFraction.NOD()
        return newFraction
    }
    
    static func *(_ left: Fraction, _ right: Fraction) -> Fraction {
        
        var newFraction = Fraction(left.numerator * right.numerator, left.denominator*right.denominator)
        newFraction.NOD()
        return newFraction
    }
    
    static func /(_ left: Fraction, _ right: Fraction) -> Fraction {
        
        var newFraction = Fraction(left.numerator * right.denominator, left.denominator*right.numerator)
        newFraction.NOD()
        return newFraction
    }
    
    
    //Сокращение дробей
    mutating func NOD() {
        var a_a:Int = numerator
        var b_b:Int = denominator
        var buf:Int
        while (b_b != 0) {
            buf = b_b;
            b_b = a_a % b_b;
            a_a = buf;
        }
        numerator = numerator / a_a
        denominator = denominator / a_a
    }
}

var f1:Fraction = Fraction(1,2)
f1.show()

var f2:Fraction = Fraction(1, 3)

var f3:Fraction = f1 + f2
f3.show()


//MARK Bully
protocol Student{
    var name:String { get set }
    var health:Int { get set }
    var damage:Int { get set }
    var scream:String {get set}
    
    func getAttacked(student:Student)
    
    func showInfo()
}

class Player:Student{
    
    var name:String
    var health:Int
    var damage:Int
    var scream:String
    
    init(name:String,health:Int, damage:Int) {
        self.name = name
        self.health = health
        self.damage = damage
        self.scream = ""
    }
    
    func getAttacked(student: Student) {
        if self.health > student.damage {
            print(student.name," attacked ",self.name," and dealt ",student.damage," dmg")
            self.health -= student.damage
        }else{
            print(student.name," attacked ",self.name," and dealt ",self.health," dmg")
            self.health = 0
        }
    }
    
    func showInfo(){
        print(self.name,":===============")
        print(self.health,":hp  ",self.damage,":dmg")
        print("======================")
    }
}

class Team{
    
    var students:[Student]
    var name:String
    var scream:String
    
    init(name:String,scream:String,students:[Student]) {
        self.students = students
        self.scream = scream
        self.name = name
        for var student in self.students {
            student.scream = scream
        }
    }
    
    func showInfo(){
        print(self.students.count," students left")
        for player in self.students {
            player.showInfo()
        }
    }
    
    func removeDeadPlayers(){
        var alivePlayers:[Student] = []
        for student in self.students {
            if student.health > 0{
                alivePlayers.append(student)
            }else{
                print("-\(student.name)  is dead :(")
            }
        }
        self.students = alivePlayers
    }
}

protocol Arena{
    
    var teams: [Team] {get set}
    
    func startBattle()
    
}

class Forest:Arena{
    var teams: [Team]
    
    func startBattle(){
        var round = 1
        while teams.count > 1 {
            print("Round ",round," began!")
            print(teams[0].name," : ",teams[0].scream)
            print(teams[1].name," : ",teams[1].scream)
            print("======================")
            
            for student in teams[0].students{
                let target = teams[1].students.shuffled().first
                target?.getAttacked(student: student)
            }
            for student in teams[1].students{
                let target = teams[0].students.shuffled().first
                target?.getAttacked(student: student)
            }
            
            removeDeadTeams()
            print("======================")
            print("Round ",round," ended. Stats:\n")
            showStats()
            round+=1
        }
        print("Battle is over! Team",teams[0].name," won!!!")
    }
    
   private func removeDeadTeams(){
        var aliveTeams:[Team] = []
        for team in teams {
            team.removeDeadPlayers()
            if team.students.count > 0 {
                aliveTeams.append(team)
            } else{
                print("-\(team.name) is dead :(")
            }
        }
        teams = aliveTeams
    }
    
    init(firstTeam: Team, secondTeam: Team) {
        teams = []
        teams.append(firstTeam)
        teams.append(secondTeam)
    }
    
    private func showStats(){
        for team in teams {
            team.showInfo()
            print()
        }
    }
}

var players1: [Player] = []
players1.append(Player(name: "Peter", health: 100, damage: 10))
players1.append(Player(name: "John", health: 100, damage: 10))
players1.append(Player(name: "Mike", health: 100, damage: 4))
players1.append(Player(name: "Andrew", health: 300, damage: 2))
players1.append(Player(name: "Oleg", health: 100, damage: 10))

var players2: [Player] = []
players2.append(Player(name: "Tim", health: 100, damage: 10))
players2.append(Player(name: "Tom", health: 100, damage: 10))
players2.append(Player(name: "Derp", health: 100, damage: 8))
players2.append(Player(name: "Will", health: 100, damage: 5))
players2.append(Player(name: "Leila", health: 100, damage: 9))


var team1 = Team(name: "Speakers",scream: "go go speak speak!", students:players1)
var team2 = Team(name: "Bikers",scream: "bikes bikes for a rise!", students: players2)

var forest = Forest(firstTeam: team1, secondTeam: team2)
forest.startBattle()
