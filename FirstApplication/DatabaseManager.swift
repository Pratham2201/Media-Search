//
//  DatabaseManager.swift
//  FirstApplication
//
//  Created by Pratham Gupta on 09/02/23.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    static let shared : DatabaseManager = DatabaseManager()
    var managedContext: NSManagedObjectContext?
    
    private init() {
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        print("Path", NSPersistentContainer.defaultDirectoryURL)
    }
    
    func savePhoto(photo: Photo)
    {
        let entity = NSEntityDescription.entity(forEntityName: "CDPhoto", in: managedContext!)
        let photoObject = NSManagedObject.init(entity: entity!, insertInto: managedContext!)
        photoObject.setValue(photo.id, forKey: "photoID")
        photoObject.setValue(photo.src?.tiny, forKey: "photoUrl")
        photoObject.setValue(photo.alt, forKey: "photoDetails")
        photoObject.setValue(photo.photographer, forKey: "photographer")
        do {
            try managedContext?.save()
        }
        catch {
            print("Save to Database Failed")
        }
    }
    
    func getData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CDPhoto")
        do {
            let data = try managedContext?.fetch(request)
            let photoData = (data as? [CDPhoto])![0]
            print(photoData.photoDetails)
        }
        catch let error as NSError{
            print("Errrorrrrrrrr")
        }
    }
}
