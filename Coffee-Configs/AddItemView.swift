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
            newItem.grindSize = grindSize.isEmpty ? nil : grindSize
            newItem.brewMethod = brewMethod.isEmpty ? nil : brewMethod
            newItem.grinder = grinder.isEmpty ? nil : grinder
            newItem.brewTime = Int32(brewTime)
            newItem.beanOrigin = beanOrigin.isEmpty ? nil : beanOrigin

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
