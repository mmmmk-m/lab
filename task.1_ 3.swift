final class Temperature {
    
    // Температура хранится внутри объекта в градусах Цельсия.
    // Снаружи можно прочитать, но нельзя изменить напрямую.
    private(set) var celsius: Double
    
    // Температура в Фаренгейтах.
    // Она не хранится отдельно, а вычисляется из celsius.
    var fahrenheit: Double {
        
        get {
            return celsius * 9 / 5 + 32
        }
        
        set {
            let newCelsius = (newValue - 32) * 5 / 9
            
            if newCelsius >= -273.15 {
                celsius = newCelsius
            }
        }
    }
    
    // Создание температуры
    init?(celsius: Double) {
        guard celsius >= -273.15 else {
            return nil
        }
        
        self.celsius = celsius
    }
    
    // Изменение температуры в Цельсиях
    @discardableResult
    func setCelsius(_ value: Double) -> Bool {
        guard value >= -273.15 else {
            return false
        }
        
        celsius = value
        return true
    }
}