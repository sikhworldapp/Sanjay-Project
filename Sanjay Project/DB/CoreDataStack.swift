import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalDB")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            if let url = description.url {
                print("Core Data file location: \(url)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getNextProdId() -> Int16 {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "prodId", ascending: false)]

        do {
            let results = try context.fetch(fetchRequest)
            if let maxProduct = results.first {
                return maxProduct.prodId + 1
            } else {
                return 1
            }
        } catch {
            print("Failed to fetch max prodId: \(error)")
            return 1
        }
    }
    
    // Insert product along with its image
    func insertProductWithImage(pName: String, price: Double, imageData: Data?, saved: ()->()) {
        let newProduct = ProductsTable(context: context)
        newProduct.prodId = getNextProdId()
        newProduct.pName = pName
        newProduct.price = price
        
        // Save image data if available
        if let imageData = imageData {
            newProduct.prodImage = imageData
        }
        
        saveContext()
        saved()
    }

    func insertProduct(model: ProductModel) {
        let newProduct = ProductsTable(context: context)
        newProduct.prodId = getNextProdId()
        newProduct.pName = model.pName
        newProduct.price = model.price

        saveContext()
    }

    func readAllProducts() -> [ProductsTable] {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch entities: \(error)")
            return []
        }
    }

    // Example for updating and deleting if needed
    func updateProduct(pName: String, newPrice: Double) {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pName == %@", pName)

        do {
            let results = try context.fetch(fetchRequest)
            if let product = results.first {
                product.price = newPrice
                saveContext()
            }
        } catch {
            print("Failed to fetch entities: \(error)")
        }
    }

    func deleteProduct(pName: String) {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pName == %@", pName)

        do {
            let results = try context.fetch(fetchRequest)
            if let product = results.first {
                context.delete(product)
                saveContext()
            }
        } catch {
            print("Failed to fetch entities: \(error)")
        }
    }
}
