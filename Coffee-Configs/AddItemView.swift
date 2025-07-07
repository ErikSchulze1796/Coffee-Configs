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
    
    var body: some View {
        ItemFormView { item in
            withAnimation {
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
}

/*
#Preview {
    AddItemView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
*/ 
