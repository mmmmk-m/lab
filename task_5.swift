import Foundation

struct Money: Equatable {
    let amount: Decimal
    let currency: String

    init?(amount: Decimal, currency: String) {
        guard amount >= 0 else {
            return nil
        }

        guard !currency.isEmpty else {
            return nil
        }

        self.amount = amount
        self.currency = currency
    }
}

struct Product: Equatable {
    let id: UUID
    let name: String
    let price: Money

    init?(id: UUID = UUID(), name: String, price: Money) {
        guard !name.isEmpty else {
            return nil
        }

        self.id = id
        self.name = name
        self.price = price
    }
}

struct OrderItem: Equatable {
    let product: Product
    var quantity: Int

    init?(product: Product, quantity: Int) {
        guard quantity > 0 else {
            return nil
        }

        self.product = product
        self.quantity = quantity
    }

    var subtotal: Decimal {
        return product.price.amount * Decimal(quantity)
    }
}

final class ShoppingCart {
    let id: UUID
    private(set) var items: [OrderItem] = []

    var total: Decimal {
        return items.reduce(0) { result, item in
            result + item.subtotal
        }
    }

    init(id: UUID = UUID()) {
        self.id = id
    }

    @discardableResult
    func add(_ product: Product, quantity: Int = 1) -> Bool {
        guard quantity > 0 else {
            return false
        }

        if let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) {
            items[index].quantity += quantity
        } else {
            guard let item = OrderItem(
                product: product,
                quantity: quantity
            ) else {
                return false
            }

            items.append(item)
        }

        return true
    }

    @discardableResult
    func remove(productID: UUID) -> Bool {
        guard let index = items.firstIndex(where: {
            $0.product.id == productID
        }) else {
            return false
        }

        items.remove(at: index)
        return true
    }
}


// MARK: - Проверка Money

let price = Money(
    amount: Decimal(string: "1499.90")!,
    currency: "RUB"
)

assert(price != nil)
assert(price?.amount == Decimal(string: "1499.90")!)
assert(price?.currency == "RUB")

assert(
    Money(
        amount: Decimal(string: "-10")!,
        currency: "RUB"
    ) == nil
)

assert(
    Money(
        amount: Decimal(string: "100")!,
        currency: ""
    ) == nil
)


// MARK: - Проверка Product

let product = Product(
    name: "Наушники",
    price: price!
)!

assert(product.name == "Наушники")
assert(product.price.amount == Decimal(string: "1499.90")!)

assert(
    Product(
        name: "",
        price: price!
    ) == nil
)


// MARK: - Проверка OrderItem

let item = OrderItem(
    product: product,
    quantity: 2
)!

assert(item.quantity == 2)
assert(item.subtotal == Decimal(string: "2999.80")!)

assert(
    OrderItem(
        product: product,
        quantity: 0
    ) == nil
)

assert(
    OrderItem(
        product: product,
        quantity: -1
    ) == nil
)


// MARK: - Проверка ShoppingCart

let cart = ShoppingCart()

assert(cart.items.isEmpty)
assert(cart.total == 0)

assert(cart.add(product) == true)

assert(cart.items.count == 1)
assert(cart.items[0].quantity == 1)
assert(cart.total == Decimal(string: "1499.90")!)


// Повторное добавление того же товара

assert(cart.add(product, quantity: 2) == true)

assert(cart.items.count == 1)
assert(cart.items[0].quantity == 3)
assert(cart.total == Decimal(string: "4499.70")!)


// Добавление другого товара

let secondProduct = Product(
    name: "Клавиатура",
    price: Money(
        amount: Decimal(string: "2500")!,
        currency: "RUB"
    )!
)!

assert(cart.add(secondProduct, quantity: 2) == true)

assert(cart.items.count == 2)

assert(
    cart.total == Decimal(string: "9499.70")!
)


// Некорректное количество

assert(cart.add(product, quantity: 0) == false)
assert(cart.add(product, quantity: -5) == false)


// Удаление товара

assert(cart.remove(productID: product.id) == true)

assert(cart.items.count == 1)
assert(cart.items[0].product.id == secondProduct.id)
assert(cart.total == Decimal(string: "5000")!)


// Попытка удалить отсутствующий товар

let unknownID = UUID()

assert(cart.remove(productID: unknownID) == false)


// MARK: - Ссылочная семантика ShoppingCart

let firstCart = ShoppingCart()

assert(firstCart.add(product, quantity: 2) == true)

let sameCart = firstCart

assert(firstCart === sameCart)

assert(sameCart.items.count == 1)
assert(sameCart.items[0].quantity == 2)

assert(sameCart.add(secondProduct, quantity: 1) == true)

assert(firstCart.items.count == 2)
assert(sameCart.items.count == 2)

assert(firstCart.total == sameCart.total)


// MARK: - Вторая корзина

let anotherCart = ShoppingCart()

assert(anotherCart.add(product, quantity: 2) == true)
assert(anotherCart.add(secondProduct, quantity: 1) == true)

assert(firstCart !== anotherCart)

assert(firstCart.id != anotherCart.id)

assert(firstCart.items == anotherCart.items)
assert(firstCart.total == anotherCart.total)