import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [CoffeeConfiguration]()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\CoffeeConfiguration.createdAt)]
    
    var body: some View {
        NavigationStack(path: $path) {
            CoffeeConfigListView(searchString: searchText, sortOrder: sortOrder)
            .navigationTitle("Coffee Configs")
            .navigationDestination(for: CoffeeConfiguration.self) { config in
                EditCoffeeConfigView(coffeeConfig: config)
                    }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name (A-Z)")
                            .tag([SortDescriptor(\CoffeeConfiguration.name)])
                        Text("Name (Z-A)")
                            .tag([SortDescriptor(\CoffeeConfiguration.name, order: .reverse)])
                        Text("Created at (latest first)")
                            .tag([SortDescriptor(\CoffeeConfiguration.createdAt)])
                        Text("Created at (latest last)")
                            .tag([SortDescriptor(\CoffeeConfiguration.createdAt, order: .reverse)])
                    }
                }
                Button("Add Config", systemImage: "plus", action: addCoffeeConfig)
            }
            .searchable(text: $searchText)
        }
    }
    
    func addCoffeeConfig() {
        let config = CoffeeConfiguration(
            name: "New Configuration",
            roastGrade: "",
            grindSize: 0,
            temperature: 93,
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
    do {
        let previewer = try Previewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
