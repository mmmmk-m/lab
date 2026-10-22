import Foundation

final class Address {
    var city: String
    
    init(city: String) {
        self.city = city
    }
}

struct OrderDraft {
    var number: Int
    var address: Address
}


// MARK: - Исходная модель

let address = Address(city: "Нальчик")

var first = OrderDraft(
    number: 1,
    address: address
)

var second = first

second.number = 2
second.address.city = "Москва"


// MARK: - Проверка

assert(first.number == 1)
assert(second.number == 2)

// Address — класс, поэтому объект адреса общий
assert(first.address.city == "Москва")
assert(second.address.city == "Москва")