import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let coffeeConfig: CoffeeConfiguration
    let fieldSchema: FieldSchema
    let fieldSchemas: [FieldSchema]

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(
            for: CoffeeConfiguration.self,
            configurations: config
        )

        coffeeConfig = CoffeeConfiguration(
            name: "Italian No.1",
        )

        // Sample attribute values for all supported kinds
        let origin = coffeeConfig.attr(for: "origin", context: container.mainContext)
        origin.kind = .text
        origin.stringValue = "Ethiopia"

        let roastery = coffeeConfig.attr(for: "roastery", context: container.mainContext)
        roastery.kind = .text
        roastery.stringValue = "Blue Bottle"

        let brewMethod = coffeeConfig.attr(for: "brewMethod", context: container.mainContext)
        brewMethod.kind = .text
        brewMethod.stringValue = "Espresso"

        let roastGrade = coffeeConfig.attr(for: "roastGrade", context: container.mainContext)
        roastGrade.kind = .text
        roastGrade.stringValue = "Medium"

        let grindSize = coffeeConfig.attr(for: "grindSize", context: container.mainContext)
        grindSize.kind = .number
        grindSize.doubleValue = 2.5

        let temperature = coffeeConfig.attr(for: "temperature", context: container.mainContext)
        temperature.kind = .number
        temperature.doubleValue = 93

        let coffeeWeight = coffeeConfig.attr(for: "coffeeWeight", context: container.mainContext)
        coffeeWeight.kind = .number
        coffeeWeight.doubleValue = 18.0

        let isDecaf = coffeeConfig.attr(for: "isDecaf", context: container.mainContext)
        isDecaf.kind = .bool
        isDecaf.boolValue = false

        let roastedOn = coffeeConfig.attr(for: "roastedOn", context: container.mainContext)
        roastedOn.kind = .date
        roastedOn.dateValue = .now

        // A single schema for individual DynamicFieldView previews
        fieldSchema = FieldSchema(
            key: "origin",
            label: "Origin",
            type: .string,
            placeholder: "e.g. Ethiopia",
            options: nil,
            section: "General",
            order: 3
        )

        // A comprehensive set of schemas covering all field types
        fieldSchemas = [
            FieldSchema(key: "brewMethod", label: "Brew Method", type: .string, placeholder: "Espresso", options: nil, section: "General", order: 1),
            FieldSchema(key: "roastery", label: "Roastery", type: .string, placeholder: "Your favorite roaster", options: nil, section: "General", order: 2),
            FieldSchema(key: "origin", label: "Origin", type: .string, placeholder: "Ethiopia", options: nil, section: "General", order: 3),
            FieldSchema(key: "roastGrade", label: "Roast Grade", type: .picker, placeholder: "Light / Medium / Dark", options: ["Light", "Medium", "Dark"], section: "General", order: 4),
            FieldSchema(key: "grindSize", label: "Grind Size", type: .number, placeholder: "2.5", options: nil, section: "General", order: 5),
            FieldSchema(key: "temperature", label: "Temperature", type: .number, placeholder: "93", options: nil, section: "General", order: 6),
            FieldSchema(key: "coffeeWeight", label: "Coffee Weight (g)", type: .number, placeholder: "18.0", options: nil, section: "General", order: 7),
            FieldSchema(key: "isDecaf", label: "Decaf", type: .bool, placeholder: nil, options: nil, section: "General", order: 8),
            FieldSchema(key: "roastedOn", label: "Roasted On", type: .date, placeholder: nil, options: nil, section: "General", order: 9)
        ]

        container.mainContext.insert(coffeeConfig)
    }
}
