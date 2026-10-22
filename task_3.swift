import Foundation

final class Playlist {
    
    let id: Int
    var name: String
    
    private(set) var tracks: [String] = []
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    @discardableResult
    func add(_ track: String) -> Bool {
        // Пустые названия добавлять нельзя
        guard !track.isEmpty else {
            return false
        }
        
        // Дубликаты добавлять нельзя
        guard !tracks.contains(track) else {
            return false
        }
        
        tracks.append(track)
        return true
    }
    
    @discardableResult
    func remove(_ track: String) -> Bool {
        guard let index = tracks.firstIndex(of: track) else {
            return false
        }
        
        tracks.remove(at: index)
        return true
    }
}


// MARK: - Проверка ссылочной семантики

let playlist = Playlist(id: 1, name: "Учёба")

let sharedPlaylist = playlist

playlist.add("Swift Basics")

assert(sharedPlaylist.tracks == ["Swift Basics"])
assert(playlist === sharedPlaylist)


// MARK: - Проверка другого объекта

let anotherPlaylist = Playlist(id: 1, name: "Учёба")

assert(playlist !== anotherPlaylist)


// MARK: - Проверка add(_:)

assert(playlist.add("Swift Basics") == false)
assert(playlist.add("") == false)
assert(playlist.add("Swift Classes") == true)

assert(playlist.tracks == [
    "Swift Basics",
    "Swift Classes"
])


// MARK: - Проверка remove(_:)

assert(playlist.remove("Swift Basics") == true)
assert(playlist.tracks == ["Swift Classes"])

assert(playlist.remove("Unknown Track") == false)