import SwiftUI
import CoreData

struct ItemFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let item: Item?
    let isEditing: Bool
    let onSave: (Item) -> Void
    
    @State private var formData = ItemFormData()
    @State private var showAdvanced = false
    
    init(item: Item? = nil, onSave: @escaping (Item) -> Void) {
        self.item = item
        self.isEditing = item != nil
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Basic Information
                Section("Coffee Details") {
                    TextField("Product Name", text: $formData.product)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Brand", text: $formData.brand)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                // Brewing Information
                Section("Brewing Information") {
                    TextField("Grind Size", text: $formData.grindSize)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Brew Method", text: $formData.brewMethod)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    TextField("Grinder", text: $formData.grinder)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    HStack {
                        Text("Brew Time (minutes)")
                        Spacer()
                        TextField("0", text: Binding(
                            get: { formData.brewTime == 0 ? "" : "\(formData.brewTime)" },
                            set: { formData.brewTime = Int($0) ?? 0 }
                        ))
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 60)
                    }
                }
                
                // Advanced Information
                Section("Advanced Information") {
                    DisclosureGroup("Bean Origin", isExpanded: $showAdvanced) {
                        TextField("Origin", text: $formData.beanOrigin)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Coffee" : "Add New Coffee")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Save" : "Add") {
                        saveItem()
                    }
                }
            }
        }
        .onAppear {
            if let item = item {
                formData.loadFrom(item: item)
            }
        }
    }
    
    private func saveItem() {
        let targetItem: Item
        
        if let existingItem = item {
            targetItem = existingItem
        } else {
            targetItem = Item(context: viewContext)
            targetItem.timestamp = Date()
        }
        
        formData.saveTo(item: targetItem)
        onSave(targetItem)
    }
}

// MARK: - Form Data Model
class ItemFormData: ObservableObject {
    @Published var product = ""
    @Published var brand = ""
    @Published var grindSize = ""
    @Published var brewMethod = ""
    @Published var grinder = ""
    @Published var brewTime = 0
    @Published var beanOrigin = ""
    
    func loadFrom(item: Item) {
        product = item.product ?? ""
        brand = item.brand ?? ""
        grindSize = item.grindSize ?? ""
        brewMethod = item.brewMethod ?? ""
        grinder = item.grinder ?? ""
        brewTime = Int(item.brewTime)
        beanOrigin = item.beanOrigin ?? ""
    }
    
    func saveTo(item: Item) {
        item.product = product.isEmpty ? nil : product
        item.brand = brand.isEmpty ? nil : brand
        item.grindSize = grindSize.isEmpty ? nil : grindSize
        item.brewMethod = brewMethod.isEmpty ? nil : brewMethod
        item.grinder = grinder.isEmpty ? nil : grinder
        item.brewTime = Int32(brewTime)
        item.beanOrigin = beanOrigin.isEmpty ? nil : beanOrigin
    }
}

#Preview {
    ItemFormView { item in
        print("Saved item: \(item)")
    }
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
} 