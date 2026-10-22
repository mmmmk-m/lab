import Foundation

final class SalesReport {
    let values: [Double]

    private(set) var buildCount = 0

    lazy var formatted: String = {
        buildCount += 1

        let sum = values.reduce(0, +)

        let average: Double
        if values.isEmpty {
            average = 0
        } else {
            average = sum / Double(values.count)
        }

        return "Сумма: \(sum), Среднее: \(average), Количество: \(values.count)"
    }()

    init(values: [Double]) {
        self.values = values
    }
}

// MARK: - Проверки

let report = SalesReport(values: [10, 20, 30])

// formatted ещё ни разу не запрашивали
assert(report.buildCount == 0)

// Первое обращение к lazy-свойству
let firstResult = report.formatted

assert(report.buildCount == 1)
assert(
    firstResult
        == "Сумма: 60.0, Среднее: 20.0, Количество: 3"
)

// Второе обращение
let secondResult = report.formatted

// Повторного вычисления нет
assert(report.buildCount == 1)

// Результат тот же
assert(firstResult == secondResult)

// MARK: - Дополнительные проверки

let anotherReport = SalesReport(
    values: [5, 15, 25, 35]
)

assert(anotherReport.buildCount == 0)

let anotherResult = anotherReport.formatted

assert(anotherReport.buildCount == 1)
assert(
    anotherResult
        == "Сумма: 80.0, Среднее: 20.0, Количество: 4"
)

// Проверка пустого массива
let emptyReport = SalesReport(values: [])

assert(emptyReport.buildCount == 0)

let emptyResult = emptyReport.formatted

assert(emptyReport.buildCount == 1)
assert(
    emptyResult
        == "Сумма: 0.0, Среднее: 0.0, Количество: 0"
)

assert(emptyReport.formatted == emptyResult)
assert(emptyReport.buildCount == 1)