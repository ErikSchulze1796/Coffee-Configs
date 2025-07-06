import SwiftUI
import CoreData

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    @State private var productName = ""
    @State private var brandName = ""
    @State private var grindSize = ""
    @State private var brewMethod = ""
    @State private var grinder = ""
    @State private var brewTime = 0
    @State private var beanOrigin = ""
    @State private var showAdvanced = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Coffee Details") {
                    TextField("Product Name", text: $productName)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Brand", text: $brandName)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                Section("Brewing Information") {
                    TextField("Grind Size", text: $grindSize)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Brew Method", text: $brewMethod)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Grinder", text: $grinder)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    HStack {
                        Text("Brew Time (minutes)")
                        Spacer()
                        TextField("0", text: Binding(
                            get: { brewTime == 0 ? "" : "\(brewTime)" },
                            set: { brewTime = Int($0) ?? 0 }
                        ))
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 60)
                    }
                }
                
                Section("Advanced Information") {
                    DisclosureGroup("Bean Origin", isExpanded: $showAdvanced) {
                        TextField("Origin", text: $beanOrigin)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                }
            }
            .navigationTitle("Edit Coffee")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveChanges()
                    }
                }
            }
        }
        .onAppear {
            productName = item.product ?? ""
            brandName = item.brand ?? ""
            grindSize = item.grindSize ?? ""
            brewMethod = item.brewMethod ?? ""
            grinder = item.grinder ?? ""
            brewTime = Int(item.brewTime)
            beanOrigin = item.beanOrigin ?? ""
        }
    }

    private func saveChanges() {
        withAnimation {
            item.product = productName
            item.brand = brandName.isEmpty ? nil : brandName
            item.grindSize = grindSize.isEmpty ? nil : grindSize
            item.brewMethod = brewMethod.isEmpty ? nil : brewMethod
            item.grinder = grinder.isEmpty ? nil : grinder
            item.brewTime = Int32(brewTime)
            item.beanOrigin = beanOrigin.isEmpty ? nil : beanOrigin
        }

        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    request.fetchLimit = 1
    
    do {
        let items = try context.fetch(request)
        if let firstItem = items.first {
            firstItem.product = "Sample Coffee"
            firstItem.brand = "Sample Brand"
            return EditItemView(item: firstItem)
                .environment(\.managedObjectContext, context)
        }
    } catch {
        print("Preview error: \(error)")
    }
    
    // Fallback: create a simple view
    return Text("Preview unavailable")
}
