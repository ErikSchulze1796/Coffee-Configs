import SwiftData
import SwiftUI

@main
struct Coffee_ConfigsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CoffeeConfiguration.self)
    }
}
