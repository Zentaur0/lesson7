//
//  main.swift
//  lesson7
//
//  Created by Антон Сивцов on 11.01.2021.
//

import Foundation

struct CarPrices {
    var car: KindsOfCars
    var price: Int
}

struct KindsOfCars {
    let name: String
}

enum RoadError: Error {
    case carBaned
    case noMoney(moneyNeded: Int)
}

class Road {
    var human = [
        "Виктор": CarPrices(car: KindsOfCars(name: "Mazda C6"), price: 10),
        "Рената": CarPrices(car: KindsOfCars(name: "Zil"), price: 20),
        "Бэн": CarPrices(car: KindsOfCars(name: "Kia Rio"), price: 7),
        "Савелий": CarPrices(car: KindsOfCars(name: "Lada Priora"), price: 5),
    ]
    
    var money = 10
    func passThrough(driver name: String) throws -> KindsOfCars {
        guard let carCameToGo = human[name] else {
            throw RoadError.carBaned
        }
        
        guard carCameToGo.price <= money else {
            throw RoadError.noMoney(moneyNeded: carCameToGo.price - money)
        }
        
        money -= carCameToGo.price
        var newCar = carCameToGo
        newCar.price -= 1
        human[name] = newCar
        print("Водитель \(name). Доступ разрешен.")
        return newCar.car
    }
}

var road = Road()
do {
    _ = try road.passThrough(driver: "Виктор")
} catch RoadError.carBaned {
    print("Машине въезд запрещен")
} catch RoadError.noMoney(let moneyNeded) {
    print("Недостаточно денег для проезда по этой дороге. Нужно добавить \(moneyNeded)")
} catch let error {
    print(error.localizedDescription)
}
