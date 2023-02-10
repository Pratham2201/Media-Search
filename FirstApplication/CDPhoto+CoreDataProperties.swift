//
//  CDPhoto+CoreDataProperties.swift
//  FirstApplication
//
//  Created by Pratham Gupta on 09/02/23.
//
//

import Foundation
import CoreData


extension CDPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPhoto> {
        return NSFetchRequest<CDPhoto>(entityName: "CDPhoto")
    }

    @NSManaged public var photoID: Int16
    @NSManaged public var photographer: String?
    @NSManaged public var photoUrl: String?
    @NSManaged public var photoDetails: String?

}

extension CDPhoto : Identifiable {

}
