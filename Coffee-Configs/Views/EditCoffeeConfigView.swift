import SwiftUI
import SwiftData

struct EditCoffeeConfigView: View {
    @Bindable var coffeeConfig: CoffeeConfiguration
    var body: some View {
        Form {
             Section {
                 TextField("Name", text: $coffeeConfig.name)
                     .textContentType(.name)
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
