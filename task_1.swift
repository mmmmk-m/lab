import Foundation

struct Vector2D: Equatable {
    
    var x: Double
    var y: Double
    
    // Длина вектора
    var length: Double {
        return sqrt(x * x + y * y)
    }
    
    // Изменяет текущий вектор
    @discardableResult
    mutating func scale(by factor: Double) -> Bool {
        guard factor > 0 else {
            return false
        }
        
        x *= factor
        y *= factor
        
        return true
    }
    
    // Возвращает новую копию, не изменяя исходный вектор
    func scaled(by factor: Double) -> Vector2D? {
        guard factor > 0 else {
            return nil
        }
        
        return Vector2D(
            x: x * factor,
            y: y * factor
        )
    }
}


// MARK: - Проверки

var original = Vector2D(x: 3, y: 4)

var copy = original

copy.scale(by: 2)

assert(original == Vector2D(x: 3, y: 4))
assert(copy == Vector2D(x: 6, y: 8))
assert(original.length == 5)

// Проверяем length
assert(Vector2D(x: 3, y: 4).length == 5)

// Проверяем scale(by:)
var vector = Vector2D(x: 2, y: 3)

assert(vector.scale(by: 2) == true)
assert(vector == Vector2D(x: 4, y: 6))

// Неположительный коэффициент должен быть отклонён
assert(vector.scale(by: 0) == false)
assert(vector.scale(by: -2) == false)

// Проверяем scaled(by:)
let scaledVector = Vector2D(x: 2, y: 3).scaled(by: 2)

assert(scaledVector == Vector2D(x: 4, y: 6))

// Исходный вектор не изменяется
let source = Vector2D(x: 2, y: 3)
let result = source.scaled(by: 3)

assert(source == Vector2D(x: 2, y: 3))
assert(result == Vector2D(x: 6, y: 9))

// Некорректный коэффициент
assert(Vector2D(x: 2, y: 3).scaled(by: 0) == nil)
assert(Vector2D(x: 2, y: 3).scaled(by: -1) == nil)