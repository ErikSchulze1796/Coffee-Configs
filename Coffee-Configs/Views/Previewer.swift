import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let coffeeConfig: CoffeeConfiguration
    let fieldSchema: FieldSchema

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(
            for: CoffeeConfiguration.self,
            configurations: config
        )

        coffeeConfig = CoffeeConfiguration(
            name: "Italian No.1",
        )
        let origin = coffeeConfig.attr(for: "origin", context: container.mainContext)
        origin.kind = .text
        origin.stringValue = "Ethiopia"
        
        fieldSchema = FieldSchema(
            key: "origin",
            label: "Origin",
            type: .string,
            placeholder: "e.g. Ethiopia",
            options: nil,
            section: nil,
            order: nil
        )

        container.mainContext.insert(coffeeConfig)
    }
}
