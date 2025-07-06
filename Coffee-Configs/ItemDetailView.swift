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
                
                // Details
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(title: "Product", value: item.product ?? "Not specified")
                    DetailRow(title: "Brand", value: item.brand ?? "Not specified")
                    DetailRow(title: "Added", value: item.timestamp?.formatted(date: .abbreviated, time: .shortened) ?? "Unknown")
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
        ItemDetailView(item: Item())
    }
} 