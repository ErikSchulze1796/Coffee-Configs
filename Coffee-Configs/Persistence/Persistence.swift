import SwiftUI
import SwiftData

@Model
class CoffeeConfiguration: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var blend: String
    var roastGrade: String
    var grindSize: String
    var temperature: Int
    var temperatureUnit: String
    var coffeeWeight: Int
    var brewMethod: String
    var roastery: String
    var origin: String
    var note: String?
    var createdAt: Date
    
    init(
        name: String,
        blend: String,
        roastGrade: String,
        grindSize: String,
        temperature: Int,
        temperatureUnit: String,
        coffeeWeight: Int,
        brewMethod: String,
        roastery: String,
        origin: String,
        note: String? = nil,
        createdAt: Date = .now
    ) {
        self.name = name
        self.blend = blend
        self.roastGrade = roastGrade
        self.grindSize = grindSize
        self.temperature = temperature
        self.temperatureUnit = temperatureUnit
        self.coffeeWeight = coffeeWeight
        self.brewMethod = brewMethod
        self.roastery = roastery
        self.origin = origin
        self.note = note
        self.createdAt = createdAt
    }
}
