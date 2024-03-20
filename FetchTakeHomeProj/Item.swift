import Foundation

struct Item: Decodable, Identifiable {
    var id: Int
    var listId: Int
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, listId, name
    }
}

extension Item: Comparable {
    static func < (lhs: Item, rhs: Item) -> Bool {
        if lhs.listId == rhs.listId {
            // Provide default values for nil or empty names, ensuring they sort as desired
            let lhsName = lhs.name ?? ""
            let rhsName = rhs.name ?? ""
            return lhsName < rhsName
        }
        return lhs.listId < rhs.listId
    }
}


