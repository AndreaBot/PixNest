//
//  CoreDataManager.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import CoreData
import Foundation


final class CoreDataManager: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var alertsManager: AlertsManager?
    @Published var savedPhotos: [SavedPhoto] = []
    
    
    
    init() {
        container = NSPersistentContainer(name: "SavedPhoto")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Could not load persistent store: \(error.localizedDescription)")
            } else {
                print("Persistent store successfully loaded!")
            }
        }
    }
    
    func loadData() {
        do {
            let request = SavedPhoto.fetchRequest()
            let sortDescriptor = NSSortDescriptor(SortDescriptor(\SavedPhoto.id, order: .reverse))
            request.sortDescriptors = [sortDescriptor]
            savedPhotos = try container.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createNewEntity(id: Date = Date.now, lowResLink: String, highResLink: String) {
        let newEntity = SavedPhoto(context: container.viewContext)
        newEntity.id = id
        newEntity.lowResUrl = lowResLink
        newEntity.highResUrl = highResLink
        saveData()
        alertsManager?.showAddingToFavouritesConfirmation()
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


