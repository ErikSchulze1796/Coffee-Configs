import SwiftUI
import CoreData

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    @State private var productName = ""
    @State private var brandName = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Coffee Details") {
                    TextField("Product Name", text: $productName)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Brand", text: $brandName)
                        .textFieldStyle(PlainTextFieldStyle())
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
        }
    }

    private func saveChanges() {
        withAnimation {
            item.product = productName
            item.brand = brandName.isEmpty ? nil : brandName
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
