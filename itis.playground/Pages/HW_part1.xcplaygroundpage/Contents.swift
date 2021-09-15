import Foundation

protocol AbstractSmartSpeaker {
    var yearOfDevelopment: Int { get }
    
    func triggerVoiceAssistant() -> Void
}

class YandexStation: AbstractSmartSpeaker {
    var yearOfDevelopment: Int
    private var serialNumber: Int
    
    init(yearOfDevelopment: Int, serialNumber: Int) {
        self.yearOfDevelopment = yearOfDevelopment
        self.serialNumber = serialNumber
    }
    
    func triggerVoiceAssistant() {
        print("Привет, меня зовут Алиса! Я живу в вашей Яндекс.Станции")
    }
}

class AmazonEcho: AbstractSmartSpeaker {
    var yearOfDevelopment: Int
    private var serialNumber: Int
    
    init(yearOfDevelopment: Int, serialNumber: Int) {
        self.yearOfDevelopment = yearOfDevelopment
        self.serialNumber = serialNumber
    }
    func triggerVoiceAssistant() {
        print("Hi, I'm Alexa!")
    }
}

class YandexStationMAX: YandexStation {
    override func triggerVoiceAssistant() {
        print("Привет, меня зовут Алиса! Я живу в вашей Яндекс.Станции МАКС")
    }
}

var yaStation = YandexStation(yearOfDevelopment: 2018, serialNumber: 5432)
var echo = AmazonEcho(yearOfDevelopment: 2016, serialNumber: 7657)
var yaStationMax = YandexStationMAX(yearOfDevelopment: 2021, serialNumber: 13)

yaStation.triggerVoiceAssistant()
yaStationMax.triggerVoiceAssistant()

