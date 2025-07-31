import SwiftUI
import SwiftData

struct EditConfigView: View {
    @Bindable var config: CoffeeConfiguration
    var body: some View {
        Form {
                         Section {
                 TextField("Name", text: $config.name)
                     .textContentType(.name)
                 TextField("Temperature", value: $config.temperature, format: .number)
                     .keyboardType(.numberPad)
             }
             Section {
                 TextField("Notes", text: Binding(
                     get: { config.note ?? "" },
                     set: { config.note = $0.isEmpty ? nil : $0 }
                 ), axis: .vertical)
             }
        }
        .navigationTitle("Edit Config")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    EditConfigView()
//}
