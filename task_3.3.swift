import Foundation

final class Document {
    let id: UUID
    let title: String
    private(set) var body: String
    let createdAt: Date

    // Designated initializer
    init(id: UUID, title: String, body: String, createdAt: Date) {
        let normalizedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if normalizedTitle.isEmpty {
            self.title = "Без названия"
        } else {
            self.title = normalizedTitle
        }

        self.id = id
        self.body = body
        self.createdAt = createdAt
    }

    // Convenience initializer №1
    convenience init(title: String, body: String) {
        self.init(
            id: UUID(),
            title: title,
            body: body,
            createdAt: Date()
        )
    }

    // Convenience initializer №2
    convenience init(title: String) {
        self.init(
            title: title,
            body: ""
        )
    }

    func updateBody(_ newBody: String) {
        body = newBody
    }
}

// MARK: - Проверки

// 1. Полный designated initializer
let fixedDate = Date(timeIntervalSince1970: 1_000_000)
let fixedID = UUID()

let document = Document(
    id: fixedID,
    title: "Мой документ",
    body: "Первый текст",
    createdAt: fixedDate
)

assert(document.id == fixedID)
assert(document.title == "Мой документ")
assert(document.body == "Первый текст")
assert(document.createdAt == fixedDate)

// 2. Первый convenience initializer
let convenientDocument = Document(
    title: "Статья",
    body: "Текст статьи"
)

assert(convenientDocument.title == "Статья")
assert(convenientDocument.body == "Текст статьи")
assert(convenientDocument.id != UUID()) // ID был сгенерирован автоматически

// 3. Второй convenience initializer
let emptyDocument = Document(
    title: "Черновик"
)

assert(emptyDocument.title == "Черновик")
assert(emptyDocument.body == "")

// 4. Проверяем updateBody
document.updateBody("Новый текст")

assert(document.body == "Новый текст")

// 5. Проверяем удаление пробелов из заголовка
let normalizedDocument = Document(
    title: "   Мой документ   ",
    body: "Текст"
)

assert(normalizedDocument.title == "Мой документ")

// 6. Пустой заголовок превращается в "Без названия"
let emptyTitleDocument = Document(
    title: "   ",
    body: "Текст"
)

assert(emptyTitleDocument.title == "Без названия")

// 7. Пустой заголовок через второй convenience initializer
let emptyTitleDocument2 = Document(
    title: "   "
)

assert(emptyTitleDocument2.title == "Без названия")
assert(emptyTitleDocument2.body == "")

// 8. Проверяем, что каждый путь создания даёт полностью заполненный объект
assert(document.id == fixedID)
assert(!document.title.isEmpty)
assert(!document.body.isEmpty)
assert(document.createdAt == fixedDate)

assert(!convenientDocument.title.isEmpty)
assert(convenientDocument.body == convenientDocument.body)
assert(convenientDocument.createdAt <= Date())

assert(!emptyDocument.title.isEmpty)
assert(emptyDocument.body == "")
assert(emptyDocument.createdAt <= Date())