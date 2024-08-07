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
    
    func insertProductWithImage(pName: String, price: Double, imageData: Data?, completion: @escaping (Bool) -> Void) {
        let newProduct = ProductsTable(context: context)
        newProduct.prodId = getNextProdId()
        newProduct.pName = pName
        newProduct.price = price
        
        // Save image data if available
        if let imageData = imageData {
            newProduct.prodImage = imageData
        }
        
        do {
            try context.save()
            completion(true)
        } catch {
            print("Failed to save product: \(error)")
            completion(false)
        }
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
    func updateProduct(oldPName: String, newPName: String?, prodImage: Data?,  newPrice: Double?, doneUpdating: (Bool) ->()) {
        do {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pName == %@", oldPName)

      
            let results = try context.fetch(fetchRequest)
            if let product = results.first {
                if let newName = newPName
                {
                    product.pName = newName
                }
                
                if let img = prodImage
                {
                    product.prodImage = img
                }
                
                if let newPrice1 = newPrice
                {
                    product.price = newPrice1
                }
                
                
                
                saveContext()
                doneUpdating(true)
                
            }
        } catch {
            print("Failed to fetch entities: \(error)")
            doneUpdating(false)
        }
    }

    func deleteProduct(pName: String, isDeleted: (Bool) ->()) {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pName == %@", pName)

        do {
            let results = try context.fetch(fetchRequest)
            if let product = results.first {
                context.delete(product)
                saveContext()
                isDeleted(true)
            }
        } catch {
            print("Failed to fetch entities: \(error)")
            isDeleted(false)
        }
    }
}
