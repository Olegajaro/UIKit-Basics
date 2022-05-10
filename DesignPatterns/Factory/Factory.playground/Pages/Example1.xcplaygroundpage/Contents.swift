// Simple Factory

enum ClothesType {
    case head
    case shoes
    case pants
}

protocol Clothes {
    var title: String { get }
    var type: ClothesType { get }
    var color: String { get }
    
    func putOn()
}

class Hat: Clothes {
    var title: String = "Hat"
    var type: ClothesType = .head
    var color: String = "black"
    
    func putOn() {
        print("Put on a \(color) \(title)")
    }
}

class Shoes: Clothes {
    var title: String = "Shoes"
    var type: ClothesType = .shoes
    var color: String = "White"
    
    func putOn() {
        print("Put on a \(color) \(title)")
    }
}

class Jeans: Clothes {
    var title: String = "Jeans"
    var type: ClothesType = .pants
    var color: String = "Blue"
    
    func putOn() {
        print("Put on a \(color) \(title)")
    }
}

class ClothesFactory {
    static let shared = ClothesFactory()
    private init() {}
    
    func createClothes(type: ClothesType) -> Clothes {
        switch type {
        case .head:
            return Hat()
        case .shoes:
            return Shoes()
        case .pants:
            return Jeans()
        }
    }
}

let hat = ClothesFactory.shared.createClothes(type: .head)
let shoes = ClothesFactory.shared.createClothes(type: .shoes)
let hat2 = ClothesFactory.shared.createClothes(type: .head)
let jeans = ClothesFactory.shared.createClothes(type: .pants)

var clothes: [Clothes] = [hat, shoes, hat2]
clothes.append(jeans)

clothes.forEach { clothes in
    clothes.putOn()
}
