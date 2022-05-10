import Foundation


protocol Button {
    
    func render()
    func onClick(action: String)
}

class WindowsButton: Button {
    func render() {
        print("отрисовать кнопку в стиле Windows")
    }
    
    func onClick(action: String) {
        print("навесить на кнопку обработчик событий Windows - \(action)")
    }
}

class HTMLButton: Button {
    func render() {
        print("Вернуть HTML-код кнопки")
    }
    
    func onClick(action: String) {
        print("навесить на кнопку обработчик событий браузера - \(action)")
    }
}

protocol DialogFactory {
    func render()
    func createButton() -> Button
}

extension DialogFactory {
    func render() {
        let okButton = createButton()
        okButton.onClick(action: "Закрыть диалог")
        okButton.render()
    }
}

class WindowsDialog: DialogFactory {
    func createButton() -> Button {
        return WindowsButton()
    }
}

class WebDialog: DialogFactory {
    func createButton() -> Button {
        return HTMLButton()
    }
}

enum OSType {
    case windows
    case web
}

class Application {
    
    var dialog: DialogFactory!
    
    func initialize(withOS type: OSType) {
        switch type {
        case .windows:
            dialog = WindowsDialog()
        case .web:
            dialog = WebDialog()
        }
    }
}

let application1 = Application()
let application2 = Application()

application1.initialize(withOS: .windows)
application1.dialog.render()

application2.initialize(withOS: .web)
application2.dialog.render()
