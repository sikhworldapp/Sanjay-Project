import CoreData



class CoreDataStack {
    static let shared = CoreDataStack()

    
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "LocalDB") // Ensure this matches your model file name
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
    
    func updateProdId(prodId: Int, pName: String)
    {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "pName == %@", pName)

        do {
            let results = try context.fetch(fetchRequest)
            if let entityToUpdate = results.first {
                entityToUpdate.pName = pName
                CoreDataStack.shared.saveContext()
            }
        } catch {
            print("Failed to fetch entities: \(error)")
        }
   }
    
    func delete()
    {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "attribute1 == %@", "Value")

        do {
            let results = try context.fetch(fetchRequest)
            if let entityToDelete = results.first {
                context.delete(entityToDelete)
                CoreDataStack.shared.saveContext()
            }
        } catch {
            print("Failed to fetch entities: \(error)")
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getNextProdId() -> Int64 {
           let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProductsTable")
           fetchRequest.fetchLimit = 1
           fetchRequest.sortDescriptors = [NSSortDescriptor(key: "prodId", ascending: false)]
           fetchRequest.resultType = .dictionaryResultType

           do {
               if let result = try context.fetch(fetchRequest).first as? [String: Int64], let maxId = result["prodId"] {
                   return maxId + 1
               } else {
                   return 1
               }
           } catch {
               print("Failed to fetch max prodId: \(error)")
               return 1
           }
       }
    
    func insertProduct(model: ProductModel)
    {
        let context = context
        let newEntity = ProductsTable(context: context)
        newEntity.pName = model.pName
        newEntity.price = model.price
        newEntity.prodId = Int16(getNextProdId())

        saveContext()

    }
    
    func readAllProducts() -> [ProductsTable] {
        let fetchRequest: NSFetchRequest<ProductsTable> = ProductsTable.fetchRequest()
        var products: [ProductsTable] = []

        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch entities: \(error)")
        }

        return products
    }

}
