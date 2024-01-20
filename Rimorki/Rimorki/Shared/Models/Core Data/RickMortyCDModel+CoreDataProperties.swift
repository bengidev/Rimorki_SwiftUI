//
//  RickMortyCDModel+CoreDataProperties.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//
//

import Foundation
import CoreData


extension RickMortyCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RickMortyCDModel> {
        return NSFetchRequest<RickMortyCDModel>(entityName: "RickMortyCDModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?
    @NSManaged public var origin: String?
    @NSManaged public var location: String?
    @NSManaged public var image: String?
    @NSManaged public var isFavorite: Bool

    var wrappedID: Int {
        Int(id)
    }
    
    var wrappedName: String {
        name ?? ""
    }
    
    var wrappedStatus: String {
        status ?? ""
    }
    
    var wrappedSpecies: String {
        species ?? ""
    }
    
    var wrappedType: String {
        type ?? ""
    }
    
    var wrappedGender: String {
        gender ?? ""
    }
    
    var wrappedOrigin: String {
        origin ?? ""
    }
    
    var wrappedLocation: String {
        location ?? ""
    }
    
    var wrappedImage: String {
        image ?? ""
    }
}

extension RickMortyCDModel : Identifiable {

}
