import Foundation

final class Connection {
    let name: String
    private(set) var isOpen: Bool

    private let onClose: (String) -> Void

    init(
        name: String,
        onClose: @escaping (String) -> Void
    ) {
        self.name = name
        self.isOpen = true
        self.onClose = onClose
    }

    func send(_ message: String) -> Bool {
        guard isOpen else {
            return false
        }

        guard !message.isEmpty else {
            return false
        }

        // Имитация отправки сообщения.
        return true
    }

    func close() {
        // Повторный вызов ничего не делает.
        guard isOpen else {
            return
        }

        isOpen = false
        onClose(name)
    }

    deinit {
        close()
    }
}

// MARK: - Явное закрытие

var closedNames: [String] = []

do {
    let connection = Connection(name: "api") {
        closedNames.append($0)
    }

    assert(connection.isOpen)

    assert(connection.send("ping") == true)
    assert(connection.send("") == false)

    connection.close()

    assert(connection.isOpen == false)

    // После закрытия отправка невозможна.
    assert(connection.send("ping") == false)

    // Повторный close() не должен вызывать onClose второй раз.
    connection.close()

    assert(closedNames == ["api"])
}

// После выхода из do объект уничтожен.
// Но onClose уже был вызван явно.
assert(closedNames == ["api"])

// MARK: - Резервное закрытие через deinit

var backupClosedNames: [String] = []

do {
    let connection = Connection(name: "backup") {
        backupClosedNames.append($0)
    }

    assert(connection.isOpen)
    assert(connection.send("hello") == true)

    // close() специально НЕ вызываем.
}

// После выхода из do объект освобождается,
// поэтому должен сработать deinit -> close().
assert(backupClosedNames == ["backup"])

// MARK: - Дополнительные проверки

var testClosedNames: [String] = []

do {
    let connection = Connection(name: "test") {
        testClosedNames.append($0)
    }

    assert(connection.isOpen)

    connection.close()

    assert(connection.isOpen == false)

    assert(connection.send("") == false)
    assert(connection.send("data") == false)

    connection.close()
    connection.close()

    assert(testClosedNames.count == 1)
}

assert(testClosedNames.count == 1)
assert(testClosedNames == ["test"])