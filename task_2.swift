import Foundation

struct EmailAddress: Equatable {
    
    let value: String
    
    init?(_ value: String) {
        // Email не должен быть пустым
        guard !value.isEmpty else {
            return nil
        }
        
        // Должна быть ровно одна "@"
        let parts = value.split(separator: "@", omittingEmptySubsequences: false)
        
        guard parts.count == 2 else {
            return nil
        }
        
        // До и после "@" должны быть символы
        guard !parts[0].isEmpty && !parts[1].isEmpty else {
            return nil
        }
        
        self.value = value
    }
}


struct StudentRecord: Equatable {
    
    let id: Int
    let name: String
    let email: EmailAddress
    var grades: [Int]
    
    var averageGrade: Double {
        guard !grades.isEmpty else {
            return 0
        }
        
        let sum = grades.reduce(0, +)
        return Double(sum) / Double(grades.count)
    }
    
    func addingGrade(_ grade: Int) -> StudentRecord? {
        // Оценка должна быть от 1 до 5
        guard (1...5).contains(grade) else {
            return nil
        }
        
        // Создаём копию записи
        var copy = self
        
        // Изменяем только копию
        copy.grades.append(grade)
        
        return copy
    }
}


// MARK: - Проверки EmailAddress

let validEmail = EmailAddress("student@example.com")

assert(validEmail != nil)
assert(validEmail?.value == "student@example.com")

assert(EmailAddress("") == nil)
assert(EmailAddress("@example.com") == nil)
assert(EmailAddress("student@") == nil)
assert(EmailAddress("student@@example.com") == nil)
assert(EmailAddress("student@example@com") == nil)


// MARK: - Проверки StudentRecord

let email = EmailAddress("amina@example.com")!

let student = StudentRecord(
    id: 1,
    name: "Амина",
    email: email,
    grades: [5, 4, 5]
)

assert(student.averageGrade == 14.0 / 3.0)


// Добавляем корректную оценку
let updatedStudent = student.addingGrade(3)

assert(updatedStudent != nil)
assert(updatedStudent?.grades == [5, 4, 5, 3])


// Исходная запись НЕ изменилась
assert(student.grades == [5, 4, 5])
assert(student.averageGrade == 14.0 / 3.0)


// Некорректные оценки
assert(student.addingGrade(0) == nil)
assert(student.addingGrade(6) == nil)
assert(student.addingGrade(-1) == nil)


// Пустой список оценок
let emptyStudent = StudentRecord(
    id: 2,
    name: "Иван",
    email: EmailAddress("ivan@example.com")!,
    grades: []
)

assert(emptyStudent.averageGrade == 0)


// Equatable
let studentCopy = StudentRecord(
    id: 1,
    name: "Амина",
    email: email,
    grades: [5, 4, 5]
)

assert(student == studentCopy)