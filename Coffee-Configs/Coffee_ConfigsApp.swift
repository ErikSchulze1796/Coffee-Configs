import SwiftData
import SwiftUI

@main
struct Coffee_ConfigsApp: App {
    var body: some Scene {
        WindowGroup {
            ConfigListView()
        }
        .modelContainer(for: CoffeeConfiguration.self)
    }
}
