// Abstract Factory

// Outerwear
protocol Top {
    var title: String { get }
    
    func putOn()
}

class Jacket: Top {
    var title: String = "Jacket"
    
    func putOn() {
        print("Put on a \(title)")
    }
}

class Windbreaker: Top {
    var title: String = "Windbreaker"
    
    func putOn() {
        print("Put on a \(title)")
    }
}

// Pants
protocol Pants {
    var title: String { get }
    var color: String { get }
    
    func putOn()
}

class Trousers: Pants {
    var title: String = "trousers"
    var color: String = "blue"
    
    func putOn() {
        print("Put on a \(color) \(title)")
    }
}

class Sweatpants: Pants {
    var title: String = "sweatpants"
    var color: String = "Green"
    
    func putOn() {
        print("Put on a \(color) \(title)")
    }
}

// Create factories
protocol AbstractFactory {
    func createTop() -> Top
    func createPants() -> Pants
}

class CasualFactory: AbstractFactory {
    func createTop() -> Top {
        return Jacket()
    }
    
    func createPants() -> Pants {
        return Trousers()
    }
}

class SportFactory: AbstractFactory {
    func createTop() -> Top {
        return Windbreaker()
    }
    
    func createPants() -> Pants {
        return Sweatpants()
    }
}

// Example
enum Situation {
    case meeting
    case sport
}

var top: Top?
var pants: Pants?

var factory: AbstractFactory?

func howToDressAccordingToThe(situation: Situation) {
    switch situation {
    case .meeting:
        factory = CasualFactory()
    case .sport:
        factory = SportFactory()
    }
    
    top = factory?.createTop()
    pants = factory?.createPants()
}

howToDressAccordingToThe(situation: .sport)
top?.putOn()
pants?.putOn()

howToDressAccordingToThe(situation: .meeting)
top?.putOn()
pants?.putOn()
