import Foundation

struct Temperature: Equatable {
    let celsius: Double

    // Основной инициализатор
    init?(celsius: Double) {
        guard celsius >= -273.15 else {
            return nil
        }

        self.celsius = celsius
    }

    // Инициализация из Фаренгейтов
    init?(fahrenheit: Double) {
        let celsius = (fahrenheit - 32) * 5 / 9

        self.init(celsius: celsius)
    }

    // Инициализация из Кельвинов
    init?(kelvin: Double) {
        let celsius = kelvin - 273.15

        self.init(celsius: celsius)
    }
}


// MARK: - Проверка 0 °C

let freezingC = Temperature(celsius: 0)

let freezingF = Temperature(fahrenheit: 32)

let freezingK = Temperature(kelvin: 273.15)

assert(freezingC != nil)

assert(
    abs((freezingF?.celsius ?? 1) - 0) < 0.0001
)

assert(
    abs((freezingK?.celsius ?? 1) - 0) < 0.0001
)


// MARK: - Проверка абсолютного нуля

assert(
    Temperature(celsius: -273.15) != nil
)

assert(
    Temperature(kelvin: -1) == nil
)


// MARK: - Проверка Фаренгейта

let roomTemperatureF = Temperature(fahrenheit: 68)

assert(
    abs((roomTemperatureF?.celsius ?? 1) - 20) < 0.0001
)


// MARK: - Проверка Кельвина

let roomTemperatureK = Temperature(kelvin: 293.15)

assert(
    abs((roomTemperatureK?.celsius ?? 1) - 20) < 0.0001
)


// MARK: - Проверка некорректной температуры

assert(
    Temperature(celsius: -274) == nil
)

assert(
    Temperature(fahrenheit: -500) == nil
)

assert(
    Temperature(kelvin: -1) == nil
)