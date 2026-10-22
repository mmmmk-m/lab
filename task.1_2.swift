final class Counter {
    
    // Общее для всех экземпляров класса
    private(set) static var createdCount = 0
    
    // Отдельное значение каждого конкретного счётчика
    private(set) var value = 0
    
    init() {
        Counter.createdCount += 1
    }
    
    // Увеличение на 1
    func increment() {
        value += 1
    }
    
    // Увеличение на указанное положительное число
    func increment(by amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        
        value += amount
        return true
    }
    
    // Сброс значения
    func reset() {
        value = 0
    }
    
    // Возвращает количество созданных счётчиков
    static func howManyCreated() -> Int {
        return Counter.createdCount
    }
}


let firstCounter = Counter()
let secondCounter = Counter()

firstCounter.increment()

assert(firstCounter.value == 1)
assert(secondCounter.value == 0)

assert(Counter.howManyCreated() == 2)