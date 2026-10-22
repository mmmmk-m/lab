final class Rectangle {
    
    // Стороны прямоугольника.
    // Читать снаружи можно, изменять напрямую — нельзя.
    private(set) var width: Double
    private(set) var height: Double
    
    // Площадь
    var area: Double {
        return width * height
    }
    
    // Периметр
    var perimeter: Double {
        return 2 * (width + height)
    }
    
    // Является ли прямоугольник квадратом
    var isSquare: Bool {
        return width == height
    }
    
    // Инициализатор
    init?(width: Double, height: Double) {
        // Стороны должны быть больше нуля
        guard width > 0 && height > 0 else {
            return nil
        }
        
        self.width = width
        self.height = height
    }
    
    // Изменение размера прямоугольника
    func scale(by factor: Double) -> Bool {
        // Коэффициент должен быть больше нуля
        guard factor > 0 else {
            return false
        }
        
        width *= factor
        height *= factor
        
        return true
    }
}


let rectangle = Rectangle(width: 3, height: 4)

assert(rectangle?.area == 12)
assert(rectangle?.perimeter == 14)
assert(rectangle?.isSquare == false)

assert(Rectangle(width: 0, height: 4) == nil)

assert(rectangle?.scale(by: 2) == true)
assert(rectangle?.area == 48)

assert(rectangle?.scale(by: -1) == false)