import Foundation

class Vehicle {
    let identifier: String
    private(set) var mileage: Int

    init?(identifier: String, mileage: Int = 0) {
        let normalizedIdentifier = identifier.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !normalizedIdentifier.isEmpty else {
            return nil
        }

        guard mileage >= 0 else {
            return nil
        }

        self.identifier = normalizedIdentifier
        self.mileage = mileage
    }

    func drive(kilometers: Int) -> Bool {
        guard kilometers >= 0 else {
            return false
        }

        mileage += kilometers
        return true
    }
}

final class ElectricCar: Vehicle {
    let batteryCapacity: Int
    private(set) var chargeLevel: Int

    init?(
        identifier: String,
        mileage: Int = 0,
        batteryCapacity: Int,
        chargeLevel: Int = 100
    ) {
        guard batteryCapacity > 0 else {
            return nil
        }

        guard (0...100).contains(chargeLevel) else {
            return nil
        }

        // Первая фаза:
        // сначала инициализируем собственные свойства ElectricCar.
        self.batteryCapacity = batteryCapacity
        self.chargeLevel = chargeLevel

        // Затем вызываем designated initializer родительского класса.
        super.init(
            identifier: identifier,
            mileage: mileage
        )
    }

    convenience init?(identifier: String, batteryCapacity: Int) {
        self.init(
            identifier: identifier,
            mileage: 0,
            batteryCapacity: batteryCapacity,
            chargeLevel: 100
        )
    }

    func charge() {
        chargeLevel = 100
    }
}

// MARK: - Проверки Vehicle

let vehicle = Vehicle(
    identifier: "  CAR-001  ",
    mileage: 10
)!

assert(vehicle.identifier == "CAR-001")
assert(vehicle.mileage == 10)

assert(vehicle.drive(kilometers: 50) == true)
assert(vehicle.mileage == 60)

assert(vehicle.drive(kilometers: 0) == true)
assert(vehicle.mileage == 60)

assert(vehicle.drive(kilometers: -1) == false)
assert(vehicle.mileage == 60)

// Некорректный идентификатор
assert(
    Vehicle(
        identifier: "   ",
        mileage: 10
    ) == nil
)

// Отрицательный пробег
assert(
    Vehicle(
        identifier: "CAR-002",
        mileage: -1
    ) == nil
)

// MARK: - Проверки ElectricCar

let electricCar = ElectricCar(
    identifier: "  TESLA-001  ",
    mileage: 100,
    batteryCapacity: 75,
    chargeLevel: 80
)!

assert(electricCar.identifier == "TESLA-001")
assert(electricCar.mileage == 100)
assert(electricCar.batteryCapacity == 75)
assert(electricCar.chargeLevel == 80)

// Проверяем drive(), унаследованный от Vehicle
assert(electricCar.drive(kilometers: 25) == true)
assert(electricCar.mileage == 125)

assert(electricCar.drive(kilometers: 0) == true)
assert(electricCar.mileage == 125)

assert(electricCar.drive(kilometers: -1) == false)
assert(electricCar.mileage == 125)

// Проверяем charge()
electricCar.charge()

assert(electricCar.chargeLevel == 100)

// MARK: - Границы batteryCapacity

assert(
    ElectricCar(
        identifier: "CAR-001",
        batteryCapacity: 1
    ) != nil
)

assert(
    ElectricCar(
        identifier: "CAR-002",
        batteryCapacity: 0
    ) == nil
)

assert(
    ElectricCar(
        identifier: "CAR-003",
        batteryCapacity: -1
    ) == nil
)

// MARK: - Границы chargeLevel

assert(
    ElectricCar(
        identifier: "CAR-004",
        batteryCapacity: 50,
        chargeLevel: 0
    ) != nil
)

assert(
    ElectricCar(
        identifier: "CAR-005",
        batteryCapacity: 50,
        chargeLevel: 100
    ) != nil
)

assert(
    ElectricCar(
        identifier: "CAR-006",
        batteryCapacity: 50,
        chargeLevel: -1
    ) == nil
)

assert(
    ElectricCar(
        identifier: "CAR-007",
        batteryCapacity: 50,
        chargeLevel: 101
    ) == nil
)

// MARK: - Границы mileage

assert(
    ElectricCar(
        identifier: "CAR-008",
        mileage: 0,
        batteryCapacity: 50
    ) != nil
)

assert(
    ElectricCar(
        identifier: "CAR-009",
        mileage: -1,
        batteryCapacity: 50
    ) == nil
)

// MARK: - Граница identifier

assert(
    ElectricCar(
        identifier: "   ",
        batteryCapacity: 50
    ) == nil
)

// MARK: - Convenience initializer

let convenientCar = ElectricCar(
    identifier: "CAR-010",
    batteryCapacity: 60
)!

assert(convenientCar.identifier == "CAR-010")
assert(convenientCar.mileage == 0)
assert(convenientCar.batteryCapacity == 60)
assert(convenientCar.chargeLevel == 100)