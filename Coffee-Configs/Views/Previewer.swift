import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let coffeeConfig: CoffeeConfiguration

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(
            for: CoffeeConfiguration.self,
            configurations: config
        )

        coffeeConfig = CoffeeConfiguration(
            name: "Italian No.1",
            roastGrade: "Medium",
            grindSize: 1/3,
            temperature: 93,
            coffeeWeight: 18.0,
            brewMethod: "Espresso",
            roastery: "Coffeum",
            origin: "Mixed",
            note: "ThIs Is a NoTe"
        )

        container.mainContext.insert(coffeeConfig)
    }
}
