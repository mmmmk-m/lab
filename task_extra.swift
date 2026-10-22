import Foundation

class Command {
    let name: String

    required init(name: String) {
        self.name = name
    }
}

final class PrintCommand: Command {
    let outputFormat: String

    required init(name: String) {
        self.outputFormat = "text"
        super.init(name: name)
    }
}

final class SaveCommand: Command {
    let destination: String

    required init(name: String) {
        self.destination = "default"
        super.init(name: name)
    }
}

// MARK: - Функция создания команды

func makeCommand(_ type: Command.Type, name: String) -> Command {
    return type.init(name: name)
}

// MARK: - Проверки

let command = makeCommand(Command.self, name: "Базовая команда")

assert(command.name == "Базовая команда")

let printCommand = makeCommand(
    PrintCommand.self,
    name: "Печать"
)

assert(printCommand.name == "Печать")

let actualPrintCommand = printCommand as! PrintCommand
assert(actualPrintCommand.outputFormat == "text")

let saveCommand = makeCommand(
    SaveCommand.self,
    name: "Сохранение"
)

assert(saveCommand.name == "Сохранение")

let actualSaveCommand = saveCommand as! SaveCommand
assert(actualSaveCommand.destination == "default")

// Проверяем, что функция действительно создаёт разные типы
assert(printCommand is PrintCommand)
assert(saveCommand is SaveCommand)
assert(command is Command)