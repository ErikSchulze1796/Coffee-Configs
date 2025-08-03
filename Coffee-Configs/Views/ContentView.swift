import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [CoffeeConfiguration]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            CoffeeConfigListView(searchString: searchText)
            .navigationTitle("Coffee Configs")
            .navigationDestination(for: CoffeeConfiguration.self) { config in
                EditConfigView(config: config)
                    }
            .toolbar {
                Button("Add Config", systemImage: "plus", action: addCoffeeConfig)
            }
            .searchable(text: $searchText)
        }
    }
    
    func addCoffeeConfig() {
        let config = CoffeeConfiguration(
            name: "New Configuration",
            blend: "",
            roastGrade: "",
            grindSize: "",
            temperature: 93,
            temperatureUnit: "Celsius",
            coffeeWeight: 0,
            brewMethod: "",
            roastery: "",
            origin: ""
        )
        modelContext.insert(config)
        path.append(config)
    }
}

#Preview {
    ContentView().modelContainer(for: CoffeeConfiguration.self)
}
