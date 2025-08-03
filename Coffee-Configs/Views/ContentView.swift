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
                EditCoffeeConfigView(coffeeConfig: config)
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
