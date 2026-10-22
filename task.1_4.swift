final class BankAccount {
    
    // Номер задаётся только при создании объекта
    // и после этого изменить его нельзя.
    let number: String
    
    // Баланс можно читать снаружи,
    // но изменять напрямую нельзя.
    private(set) var balance: Double
    
    // Скрытый номер счёта
    var maskedNumber: String {
        let lastFour = String(number.suffix(4))
        return "****" + lastFour
    }
    
    // Создание банковского счёта
    init?(number: String, initialBalance: Double = 0) {
        
        // Убираем пробелы по краям и проверяем,
        // что строка не пустая и не состоит только из пробелов.
        let trimmedNumber = number.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedNumber.isEmpty else {
            return nil
        }
        
        // Начальный баланс не может быть отрицательным.
        guard initialBalance >= 0 else {
            return nil
        }
        
        self.number = number
        self.balance = initialBalance
    }
    
    // Пополнение счёта
    @discardableResult
    func deposit(_ amount: Double) -> Bool {
        guard amount > 0 else {
            return false
        }
        
        balance += amount
        return true
    }
    
    // Снятие денег со счёта
    @discardableResult
    func withdraw(_ amount: Double) -> Bool {
        guard amount > 0 && amount <= balance else {
            return false
        }
        
        balance -= amount
        return true
    }
    
    // Описание счёта
    func description() -> String {
        return "Счёт \(maskedNumber): \(balance)"
    }
}