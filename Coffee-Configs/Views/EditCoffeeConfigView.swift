import SwiftUI
import SwiftData

struct EditCoffeeConfigView: View {
    @Environment(\.modelContext) private var context
    @Bindable var coffeeConfig: CoffeeConfiguration
    let schemas: [FieldSchema]
    
    var body: some View {
        Form {
            ForEach(schemas) { fieldSchema in
                DynamicFieldView(coffeeConfig: coffeeConfig, field: fieldSchema)
            }
        }
        .navigationTitle(coffeeConfig.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save") { try? context.save() }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EditCoffeeConfigView(
            coffeeConfig: previewer.coffeeConfig,
            schemas: previewer.fieldSchemas
        )
        .modelContainer(previewer.container)

    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
