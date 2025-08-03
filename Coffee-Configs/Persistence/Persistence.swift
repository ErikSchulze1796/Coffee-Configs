import SwiftUI
import SwiftData

@Model
class CoffeeConfiguration: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var roastGrade: String
    var grindSize: Float
    var temperature: Int
    var coffeeWeight: Float
    var brewMethod: String
    var roastery: String
    var origin: String
    var note: String?
    var createdAt: Date
    
    init(
        name: String,
        roastGrade: String,
        grindSize: Float,
        temperature: Int,
        coffeeWeight: Float,
        brewMethod: String,
        roastery: String,
        origin: String,
        note: String? = nil,
        createdAt: Date = .now
    ) {
        self.name = name
        self.roastGrade = roastGrade
        self.grindSize = grindSize
        self.temperature = temperature
        self.coffeeWeight = coffeeWeight
        self.brewMethod = brewMethod
        self.roastery = roastery
        self.origin = origin
        self.note = note
        self.createdAt = createdAt
    }
}
