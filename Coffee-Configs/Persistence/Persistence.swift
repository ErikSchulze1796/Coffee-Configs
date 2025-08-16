import SwiftUI
import SwiftData

@Model
class CoffeeConfiguration: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var attributes: [ConfigAttribute] = []

    init(name: String) {
        self.name = name
        self.createdAt = .now
    }
    
    func attr(for key: String, context: ModelContext) -> ConfigAttribute {
        if let existing = attributes.first(where: { $0.key == key }) { return existing }
        let created =  ConfigAttribute(key: key)
        attributes.append(created)
        context.insert(created)
        return created
    }
}

@Model
final class ConfigAttribute {
    enum Kind: Int, Codable { case text, number, bool, date }
    
    var key: String
    var kindRaw: Int
    var stringValue: String?
    var doubleValue: Double?
    var boolValue: Bool?
    var dateValue: Date?
    
    init(key: String, kind: Kind = .text) {
        self.key = key
        self.kindRaw = kind.rawValue
    }
    
    var kind: Kind {
        get { Kind(rawValue: kindRaw) ?? .text }
        set { kindRaw = newValue.rawValue }
    }
}
