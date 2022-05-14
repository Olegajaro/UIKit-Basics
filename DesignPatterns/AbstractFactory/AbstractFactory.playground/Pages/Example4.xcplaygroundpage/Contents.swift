protocol Button {
    func paint()
}

class WinButton: Button {
    func paint() {
        print("Draw a button in Windows style")
    }
}

class MacButton: Button {
    func paint() {
        print("Draw a button in MacOS style")
    }
}

protocol Checkbox {
    func paint()
}

class WinCheckbox: Checkbox {
    func paint() {
        print("Draw a checkbox in Windows style")
    }
}

class MacCheckbox: Checkbox {
    func paint() {
        print("Draw a checkbox in MacOS style")
    }
}

protocol GUIFactory {
    func createButton() -> Button
    func createCheckbox() -> Checkbox
}

class WinFactory: GUIFactory {
    func createButton() -> Button {
        return WinButton()
    }
    
    func createCheckbox() -> Checkbox {
        return WinCheckbox()
    }
}

class MacFactory: GUIFactory {
    func createButton() -> Button {
        return MacButton()
    }
    
    func createCheckbox() -> Checkbox {
        return MacCheckbox()
    }
}

class Application {
    private var factory: GUIFactory?
    private var button: Button?
    private var checkBox: Checkbox?
    
    init(factory: GUIFactory) {
        self.factory = factory
    }
    
    func createUI() {
        button = factory?.createButton()
        checkBox = factory?.createCheckbox()
    }
    
    func paint() {
        button?.paint()
        checkBox?.paint()
    }
}

enum OSType {
    case windows
    case macOS
}

let windowsApp = Application(factory: WinFactory())
windowsApp.createUI()
windowsApp.paint()

let macApp = Application(factory: MacFactory())
macApp.createUI()
macApp.paint()
