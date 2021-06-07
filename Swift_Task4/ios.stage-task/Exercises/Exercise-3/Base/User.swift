import Foundation

struct User: Equatable {
    let id: UUID
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
