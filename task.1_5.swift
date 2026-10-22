import Foundation

struct LibraryBook: Equatable {
    let id: UUID
    let title: String
}

final class LibraryMember {
    
    let id: UUID
    let name: String
    
    private(set) var borrowedBooks: [LibraryBook] = []
    
    var borrowedCount: Int {
        return borrowedBooks.count
    }
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    @discardableResult
    func borrow(_ book: LibraryBook) -> Bool {
        // Нельзя взять больше 5 книг
        guard borrowedBooks.count < 5 else {
            return false
        }
        
        // Нельзя взять одну и ту же книгу повторно
        guard !hasBorrowed(bookID: book.id) else {
            return false
        }
        
        borrowedBooks.append(book)
        return true
    }
    
    @discardableResult
    func returnBook(id: UUID) -> Bool {
        guard let index = borrowedBooks.firstIndex(where: { $0.id == id }) else {
            return false
        }
        
        borrowedBooks.remove(at: index)
        return true
    }
    
    func hasBorrowed(bookID: UUID) -> Bool {
        return borrowedBooks.contains { $0.id == bookID }
    }
    
    func summary() -> String {
        let titles = borrowedBooks.map { $0.title }
        
        if titles.isEmpty {
            return "Читатель \(name) не взял книг."
        }
        
        return "Читатель \(name) взял книги: \(titles.joined(separator: ", "))"
    }
}