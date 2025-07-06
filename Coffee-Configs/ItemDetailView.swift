//
//  ItemDetailView.swift
//  Coffee-Configs
//
//  Created by Erik Schulze on 06.07.25.
//

import SwiftUI
import CoreData

struct ItemDetailView: View {
    @State private var showingEditItemView = false
    @State private var showAdvanced = false
    let item: Item
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.product ?? "Unknown Product")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let brand = item.brand {
                        Text(brand)
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.bottom)
                
                // Basic Details
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(title: "Product", value: item.product ?? "Not specified")
                    DetailRow(title: "Brand", value: item.brand ?? "Not specified")
                    DetailRow(title: "Added", value: item.timestamp?.formatted(date: .abbreviated, time: .shortened) ?? "Unknown")
                }
                
                // Brewing Information
                VStack(alignment: .leading, spacing: 16) {
                    Text("Brewing Information")
                        .font(.headline)
                        .padding(.top)
                    
                    if let grindSize = item.grindSize, !grindSize.isEmpty {
                        DetailRow(title: "Grind Size", value: grindSize)
                    }
                    
                    if let brewMethod = item.brewMethod, !brewMethod.isEmpty {
                        DetailRow(title: "Brew Method", value: brewMethod)
                    }
                    
                    if let grinder = item.grinder, !grinder.isEmpty {
                        DetailRow(title: "Grinder", value: grinder)
                    }
                    
                    if item.brewTime > 0 {
                        DetailRow(title: "Brew Time", value: "\(item.brewTime) minutes")
                    }
                }
                
                // Advanced Information
                VStack(alignment: .leading, spacing: 16) {
                    DisclosureGroup("Advanced Information", isExpanded: $showAdvanced) {
                        VStack(alignment: .leading, spacing: 16) {
                            if let beanOrigin = item.beanOrigin, !beanOrigin.isEmpty {
                                DetailRow(title: "Bean Origin", value: beanOrigin)
                            } else {
                                DetailRow(title: "Bean Origin", value: "Not specified")
                            }
                        }
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.headline)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Coffee Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditItemView = true
                }
            }
        }
        .sheet(isPresented: $showingEditItemView) {
            EditItemView(item: item)
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            
            Text(value)
                .font(.body)
        }
    }
}



#Preview {
    NavigationView {
        ItemDetailView(item: createSampleItem())
    }
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

private func createSampleItem() -> Item {
    let context = PersistenceController.preview.container.viewContext
    let sampleItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
    sampleItem.product = "Sample Coffee"
    sampleItem.brand = "Sample Brand"
    sampleItem.grindSize = "Medium"
    sampleItem.brewMethod = "Pour Over"
    sampleItem.grinder = "Hario V60"
    sampleItem.brewTime = 4
    sampleItem.beanOrigin = "Ethiopia"
    sampleItem.timestamp = Date()
    return sampleItem
}

