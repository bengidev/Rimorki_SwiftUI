//
//  RickMortyCD.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import CoreData

struct RickMortyCD {

    static let shared = RickMortyCD()

    private init() {}
    
    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "RickMortyCDModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of data store failed: \(error)")
            }
        }

        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    @discardableResult
    func createRickMortyCD(_ rickMorty: RickMortyAPIModel.Result, isFavorite: Bool = false) -> RickMortyCDModel? {
        let context = persistentContainer.viewContext
        let newRickMorty: RickMortyCDModel = .init(context: context)
        
        newRickMorty.id = Int64(rickMorty.id)
        newRickMorty.name = rickMorty.name
        newRickMorty.status = rickMorty.status
        newRickMorty.species = rickMorty.species
        newRickMorty.type = rickMorty.type
        newRickMorty.gender = rickMorty.gender
        newRickMorty.origin = rickMorty.origin.name
        newRickMorty.location = rickMorty.location.name
        newRickMorty.image = rickMorty.image
        newRickMorty.isFavorite = isFavorite
        
        print("Core Data New RickMorty: \(newRickMorty.id)")
        
        do {
            try context.save()
            return newRickMorty
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    @discardableResult
    func fetchRickMortyDataCD() -> [RickMortyCDModel]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<RickMortyCDModel>(entityName: "RickMortyCDModel")

        do {
            let data = try context.fetch(fetchRequest)
            
            print("Core Data Fetch Results: \(data.count)")
            
            return data
        } catch let error {
            print("Failed to fetch CDAlphaTasks: \(error)")
        }

        return nil
    }
    
    @discardableResult
    func fetchRickMortyDataCD(with name: String) -> [RickMortyCDModel]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<RickMortyCDModel>(entityName: "RickMortyCDModel")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "name", name)

        do {
            let data = try context.fetch(fetchRequest)
            return data
        } catch let error {
            print("Failed to fetch CDAlphaTasks: \(error)")
        }

        return nil
    }

    func fetchRickMortyDataCD(withID id: Int) -> RickMortyCDModel? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<RickMortyCDModel>(entityName: "RickMortyCDModel")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", id)

        do {
            let data = try context.fetch(fetchRequest)
            
            print("Core Data Fetch Results: \(data)")
            
            return data.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }

    func updateRickMortyDataCD(id: Int, with rickMorty: RickMortyAPIModel.Result, isFavorite: Bool = false) {
        let context = persistentContainer.viewContext

        let willUpdateRickMorty = self.fetchRickMortyDataCD(withID: rickMorty.id)
        
        willUpdateRickMorty?.id = Int64(rickMorty.id)
        willUpdateRickMorty?.name = rickMorty.name
        willUpdateRickMorty?.status = rickMorty.status
        willUpdateRickMorty?.species = rickMorty.species
        willUpdateRickMorty?.type = rickMorty.type
        willUpdateRickMorty?.gender = rickMorty.gender
        willUpdateRickMorty?.origin = rickMorty.origin.name
        willUpdateRickMorty?.location = rickMorty.location.name
        willUpdateRickMorty?.image = rickMorty.image
        willUpdateRickMorty?.isFavorite = isFavorite
        
        print("Core Data Update Task: \(String(describing: willUpdateRickMorty?.wrappedID))")
        
        do {
            try context.save()
        } catch let error {
            print("Failed to update Alpha Task: \(error)")
        }
    }

    func deleteRickMortyDataCD(_ rickMorty: RickMortyAPIModel.Result) {
        let context = persistentContainer.viewContext
        
        let willDeleteRickMorty = self.fetchRickMortyDataCD(withID: rickMorty.id) ?? .init(context: context)
        
        print("Core Data Delete Task: \(String(describing: willDeleteRickMorty))")
        
        context.delete(willDeleteRickMorty)
        do {
            try context.save()
        } catch let error {
            print("Failed to delete CDAlphaTask: \(error)")
        }
    }
}
