import SwiftData
import SwiftUI

struct ConfigListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var configs: [CoffeeConfiguration]
    @State private var path = [CoffeeConfiguration]()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(configs) {
                    config in
                    NavigationLink(value: config) {
                        Text(config.name)
                    }
                }
                .onDelete(perform: deleteConfig)
            }
            .navigationTitle("Coffee Configs")
            .navigationDestination(for: CoffeeConfiguration.self) { config in
                EditConfigView(config: config)
                    }
            .toolbar {
                Button("Add Config", systemImage: "plus", action: addCoffeeConfig)
            }
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
    
    func deleteConfig(at offsets: IndexSet) {
        for offset in offsets {
            let config = configs[offset]
            modelContext.delete(config)
        }
    }
}

#Preview {
    ConfigListView().modelContainer(for: CoffeeConfiguration.self)
}
