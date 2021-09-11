
import Foundation


class Fraction {
    var name: String
    var students: [Student]
    init(name: String, students: [Student]) {
        self.name = name
        self.students = students
    }
}


enum Weapon: Int{
    case pistol = 5
    case shotgun = 7
    case rifle = 9
}

protocol Student {
    var hp: Int { get set }
    var weapon: Weapon? { get set }
    var damage: Int { get set }
    var chant: String { get set }
    var name: String { get set }
}
protocol Arena {
    var fraction1: Fraction { get set }
    var fraction2: Fraction { get set }
    
    func startBattle()
}



class highLevelStudent: Student {
    var weapon: Weapon?{
        didSet{
            guard let weaponDamage = weapon?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    var hp: Int = 20
    
    var damage: Int = 3
    
    var chant: String = "В АТАКУ!!!"
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class middleLevelStudent: Student {
    
    var weapon: Weapon?{
        didSet{
            guard let weaponDamage = weapon?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    var hp: Int = 10
    
    var damage: Int = 2
    
    var chant: String = "ГРАААААААА!!!"
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


class lowLevelStudent: Student {
    
    var weapon: Weapon?{
        didSet{
            guard let weaponDamage = weapon?.rawValue else {return}
            damage = weaponDamage
        }
    }
    
    var hp: Int = 5
    
    var damage: Int = 1
    
    var chant: String = "Я ЕСТЬ ВОИИИИИН!!!"
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
