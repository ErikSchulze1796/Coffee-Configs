import SwiftUI
import SwiftData

struct EditCoffeeConfigView: View {
    @Bindable var coffeeConfig: CoffeeConfiguration
    var body: some View {
        Form {
             Section {
                 TextField("Name", text: $coffeeConfig.name)
                     .textContentType(.name)
                 TextField("Temperature", value: $coffeeConfig.temperature, format: .number)
                     .keyboardType(.numberPad)
             }
             Section {
                 TextField("Notes", text: Binding(
                     get: { coffeeConfig.note ?? "" },
                     set: { coffeeConfig.note = $0.isEmpty ? nil : $0 }
                 ), axis: .vertical)
             }
        }
        .navigationTitle("Edit Config")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EditCoffeeConfigView(
            coffeeConfig: previewer.coffeeConfig)
            .modelContainer(previewer.container)

    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
