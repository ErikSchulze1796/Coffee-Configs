//
//  AddItemView.swift
//  Coffee-Configs
//
//  Created by Erik Schulze on 06.07.25.
//

import SwiftUI
import CoreData

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
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
            .navigationTitle("Add New Coffee")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addItem()
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.product = productName
            newItem.brand = brandName.isEmpty ? nil : brandName

            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddItemView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
} 
