//
//  CoreDataManager.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import CoreData
import Foundation

@Observable
final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    var savedPhotos: [SavedPhoto] = []
    
    private init() {
        container = NSPersistentContainer(name: "SavedPhoto")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Could not load persistent store: \(error.localizedDescription)")
            } else {
                print("Persistent store successfully loaded!")
                self.loadData()
            }
        }
    }
    
    func loadData() {
        do {
            savedPhotos = try container.viewContext.fetch(SavedPhoto.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createNewEntity(id: UUID = UUID(), date: Date = Date.now, lowResLink: String, highResLink: String) {
        let newEntity = SavedPhoto(context: container.viewContext)
        newEntity.id = id
        newEntity.date = date
        newEntity.lowResUrl = lowResLink
        newEntity.highResUrl = highResLink
        saveData()
        loadData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(index: Int) {
        if let imageToDelete = savedPhotos.first(where: { photo in
            photo.id == savedPhotos[index].id
        }) {
            container.viewContext.delete(imageToDelete)
            saveData()
            loadData()
        }
    }
}


