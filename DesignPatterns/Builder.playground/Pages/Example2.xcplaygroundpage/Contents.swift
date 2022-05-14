import XCTest

enum PickupType: String {
    case single = "Single"
    case humbucker = "Humbucker"
}

class Guitar {
    var brand: String?
    var title: String?
    var numberOfPickups: Int?
    var pickupType: PickupType?
    
    func guitarDescription() {
        guard
            let brand = brand,
            let title = title,
            let numberOfPickups = numberOfPickups,
            let pickupType = pickupType
        else { return }

        print("Guitar \(brand) \(title) with \(numberOfPickups) \(pickupType.rawValue) pickups")
    }
}

protocol Builder {
    
    func reset()
    
    func setBrand()
    func setTitle(_ title: String)
    func setPickups(number: Int)
    func setPickup(type: PickupType)
    
    func getGuitar() -> Guitar
}

class GibsonBuilder: Builder {
    
    private var gibsonGuitar = Guitar()
    
    func reset() {
        gibsonGuitar = Guitar()
    }
    
    func setBrand() {
        gibsonGuitar.brand = "Gibson"
    }
    
    func setTitle(_ title: String) {
        gibsonGuitar.title = title
    }
    
    func setPickups(number: Int) {
        gibsonGuitar.numberOfPickups = number
    }
    
    func setPickup(type: PickupType) {
        gibsonGuitar.pickupType = .humbucker
    }
    
    func getGuitar() -> Guitar {
        let result = gibsonGuitar
        reset()
        return result
    }
}

class Director {
    
    private var builder: Builder?

    func setBuilder(builder: Builder) {
        self.builder = builder
    }
    
    func buildBudgetGuitar() {
        guard let builder = builder else { return }
        builder.setBrand()
        builder.setTitle("Les Paul - Studio")
        builder.setPickups(number: 1)
        builder.setPickup(type: .humbucker)
    }
    
    func buildExpensiveGuitar() {
        guard let builder = builder else { return }
        builder.setBrand()
        builder.setTitle("Les Paul - Custom")
        builder.setPickups(number: 2)
        builder.setPickup(type: .humbucker)
    }
    
    func buildCustomGuitar(withTitle title: String) {
        guard let builder = builder else { return }
        builder.setBrand()
        builder.setTitle(title)
        builder.setPickups(number: 2)
        builder.setPickup(type: .humbucker)
    }
}

let builder = GibsonBuilder()
let director = Director()
director.setBuilder(builder: builder)

director.buildBudgetGuitar()
let guitar = builder.getGuitar()
guitar.guitarDescription()

director.buildExpensiveGuitar()
let guitar2 = builder.getGuitar()
guitar2.guitarDescription()

director.buildCustomGuitar(withTitle: "SG - Custom")
let guitar3 = builder.getGuitar()
guitar3.guitarDescription()
