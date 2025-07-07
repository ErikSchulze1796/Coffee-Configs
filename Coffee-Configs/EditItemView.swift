import SwiftUI
import CoreData

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let item: Item

    var body: some View {
        ItemFormView(item: item) { _ in
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
*/
