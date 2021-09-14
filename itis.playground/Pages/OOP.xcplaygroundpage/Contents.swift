import Foundation


// Это абстракция, так как класс машины - выделение "общего" среди всех машин
class Car{
    private var speed: Int // Инкапсуляция - мы сокрыли данные реализации от пользователя при помощи модификатора доступа
    private var distance: Int = 0
    
    init(speed: Int){
        self.speed = speed;
    }
    
    public func go() -> Void{ // Инкапсуляция - здесь мы определили, что этот метод будет публичным
        distance += speed
        print(distance)
    }
}


// Абстракция - здесь мы как бы "уточнение" класса Car
class Truck : Car{
    // Наследование - мы использовали класс Car для реализации Truck. Мы используем поле speed и метод go из Car
    private var capacity: Int = 10
}


class Utils {
    // Полиморфизм - мы используем один интерфейс для разных сущностей. Сюда может прийти все, что либо является Car, либо наследуется от Car
    public static func anyCarGo(car: Car){
        car.go()
    }
}


var truck = Truck(speed: 10)
truck.go()

Utils.anyCarGo(car: truck)





