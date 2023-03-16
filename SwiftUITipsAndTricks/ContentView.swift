//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

protocol Fuel {
    associatedtype FuelType where FuelType==Self
    static func purchase() -> FuelType
}

struct Gasoline: Fuel {
    static func purchase() -> Gasoline { Gasoline() }
}

struct Diesel: Fuel {
    static func purchase() -> Diesel { Diesel() }
}

protocol Vehicle: Equatable {
    associatedtype FuelType: Fuel
    func fillTank(with fuel: FuelType)
    func startEngine()
}

struct Car: Vehicle {
    let number: Int
    init(number: Int = 0) {
        self.number = number
    }
    func fillTank(with fuel: Gasoline) {}
    func startEngine() {}
}

struct Bus: Vehicle {
    func fillTank(with fuel: Diesel) {}
    func startEngine() {}
}


extension Car {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.number == rhs.number
    }
}

extension Bus {
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}


/*
let vehicles: [Vehicle]//Use of protocol 'Vehicle' as a type must be written 'any Vehicle'
*/
let differentVehicles: [any Vehicle] = [Car(), Bus()]

/*
let theSameVehicles: [some Vehicle] = [Car(), Bus()] //Type of expression is ambiguous without more context
*/

let theSameVehicles: [some Vehicle] = [Car(), Car()] //Type of expression is ambiguous without more context

func startAllEngines(for vehicles: [any Vehicle]) {
    vehicles.forEach { vehicle in
        vehicle.startEngine()
    }
}

func createAnyVehicle() -> any Vehicle {
    if (Int.random(in: 1...10) % 2) == 0 {
        return Car()
    } else {
        return Bus()
    }
}

let anyVehicle1 = createAnyVehicle()
let anyVehicle2 = createAnyVehicle()
/*
Does not compile:
 let anyVehiclesEqual = anyVehicle1 == anyVehicle2
*/

func createSomeVehicle() -> some Vehicle {
    print("Called: createSomeVehicle() -> some Vehicle")
    if (Int.random(in: 1...10) % 2) == 0 {
        return Car(number: 0)
    } else {
        return Car(number: 1)
    }
}

/*
func createSomeVehicle() -> Car {
    print("Called: createSomeVehicle() -> Car")
    if (Int.random(in: 1...10) % 2) == 0 {
        return Car(number: 0)
    } else {
        return Car(number: 1)
    }
}*/

//func fillAllTanks(for vehicles: [any Vehicle]) //error
func fillAllTanks(for vehicles: [some Vehicle]) {
    vehicles.forEach { vehicle in
        let fuel = type(of: vehicle).FuelType.purchase()
        vehicle.fillTank(with: fuel)
    }
}

//func fillAllTanks<V:Vehicle>(for vehicles: [V]) { //Invalid redeclaration of 'fillAllTanks(for:)'
func fillAllTanks2<V:Vehicle>(for vehicles: [V]) {
    vehicles.forEach { vehicle in
        let fuel = type(of: vehicle).FuelType.purchase()
        vehicle.fillTank(with: fuel)
    }
}

final class ContentViewModel: ObservableObject {
}

struct ContentView: View {
   
    let anyViews: [any View] = [Button("Tap me") {}, Text("Hello") ]
    //Different types can be mixed in 'any' collection
    
    /* Compilation error: "Type of expression is ambiguous without more context"
    let someViews: [some View] = [Button("Tap me") {}, Text("Hello") ]
    Different types can not be mixed in 'some' collection
    */
    let someViews: [some View] = [Text("Hello"), Text("World")]

    var body: some View {
        VStack {
            AnyView(anyViews[0])
            someViews[0]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
