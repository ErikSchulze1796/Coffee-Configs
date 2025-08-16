import SwiftData
import SwiftUI

struct CoffeeConfigListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var configs: [CoffeeConfiguration]
    
    init(
        searchString: String = "",
        sortOrder: [SortDescriptor<CoffeeConfiguration>] = []
    )  {
        _configs = Query(filter: #Predicate { config in
            if searchString.isEmpty {
                true
            } else {
                config.name.localizedStandardContains(searchString)
//                || config.roastery.localizedStandardContains(searchString)
//                || config.origin.localizedStandardContains(searchString)
//                || config.note?.localizedStandardContains(searchString) ?? false
//                || config.brewMethod.localizedStandardContains(searchString)
//                || config.roastGrade.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        List {
            ForEach(configs) {
                config in
                NavigationLink(value: config) {
                    Text(config.name)
                }
            }
            .onDelete(perform: deleteConfig)
        }
    }

    func deleteConfig(at offsets: IndexSet) {
        for offset in offsets {
            let config = configs[offset]
            modelContext.delete(config)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return CoffeeConfigListView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
