import SwiftData
import SwiftUI


struct DynamicFieldView: View {
    @Environment(\.modelContext) private var context
    @Bindable var coffeeConfig: CoffeeConfiguration
    let field: FieldSchema
    
    var body: some View {
        VStack(alignment: .leading) {
            if field.type != .bool {
                Text(field.label).font(.caption).foregroundStyle(.secondary)
            }
            switch field.type {
            case .string:
                TextField(field.placeholder ?? "", text: bindingString())
            case .number:
                Text("test")
            case .bool:
                Text("test")
            case .date:
                Text("test")
            case .picker:
                Text("test")
            }
        }
    }
    
    private func bindingString() -> Binding<String> {
        Binding(
            get: {
                let a = coffeeConfig.attr(for: field.key, context: context)
                a.kind = .text
                return a.stringValue ?? ""
            },
            set: {
                let a = coffeeConfig.attr(for: field.key, context: context)
                a.kind = .text
                a.stringValue = $0
            }
        )
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return DynamicFieldView(
            coffeeConfig: previewer.coffeeConfig,
            field: previewer.fieldSchema
        )
        .modelContainer(previewer.container)

    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
