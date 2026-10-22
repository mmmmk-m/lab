import Foundation

struct UserAccount: Equatable {
    let username: String
    let email: String
    let age: Int

    init?(username: String, email: String, age: Int) {
        // Нормализуем имя и email
        let normalizedUsername = username.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let normalizedEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        // Проверяем имя
        guard normalizedUsername.count >= 3 else {
            return nil
        }

        // Проверяем возраст
        guard (14...120).contains(age) else {
            return nil
        }

        // Проверяем email
        let parts = normalizedEmail.split(
            separator: "@",
            omittingEmptySubsequences: false
        )

        guard parts.count == 2 else {
            return nil
        }

        guard !parts[0].isEmpty && !parts[1].isEmpty else {
            return nil
        }

        // Только после всех проверок создаём корректный экземпляр
        self.username = normalizedUsername
        self.email = normalizedEmail
        self.age = age
    }
}


// MARK: - Успешный сценарий

let account = UserAccount(
    username: "  amina  ",
    email: " USER@EXAMPLE.COM ",
    age: 20
)

let expectedAccount = UserAccount(
    username: "amina",
    email: "user@example.com",
    age: 20
)

assert(account == expectedAccount)

assert(account?.username == "amina")
assert(account?.email == "user@example.com")
assert(account?.age == 20)


// MARK: - Некорректное имя

assert(
    UserAccount(
        username: "ab",
        email: "a@b.com",
        age: 20
    ) == nil
)


// MARK: - Некорректный email

assert(
    UserAccount(
        username: "amina",
        email: "wrong",
        age: 20
    ) == nil
)


// MARK: - Некорректный возраст

assert(
    UserAccount(
        username: "amina",
        email: "a@b.com",
        age: 10
    ) == nil
)

assert(
    UserAccount(
        username: "amina",
        email: "a@b.com",
        age: 121
    ) == nil
)


// MARK: - Дополнительные проверки email

assert(
    UserAccount(
        username: "amina",
        email: "@example.com",
        age: 20
    ) == nil
)

assert(
    UserAccount(
        username: "amina",
        email: "amina@",
        age: 20
    ) == nil
)

assert(
    UserAccount(
        username: "amina",
        email: "amina@example@com",
        age: 20
    ) == nil
)


// MARK: - Дополнительные проверки имени

assert(
    UserAccount(
        username: "   ",
        email: "a@b.com",
        age: 20
    ) == nil
)


// MARK: - Проверка границ возраста

assert(
    UserAccount(
        username: "amina",
        email: "a@b.com",
        age: 14
    ) != nil
)

assert(
    UserAccount(
        username: "amina",
        email: "a@b.com",
        age: 120
    ) != nil
)