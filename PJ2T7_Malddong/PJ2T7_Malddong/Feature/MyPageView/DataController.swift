//
//  DataController.swift
//  PJ2T7_Malddong
//
//  Created by 조민식 on 12/13/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
//    let container = NSPersistentContainer(name: "MyData")
//    
//    init() {
//        container.loadPersistentStores {
//            decs, error in
//            if let error = error {
//                print("Failed to load the data \(error.localizedDescription)")
//            }
//        }
//    }
    func addItem(photo: [String]?, telno: String, rnAdres: String, toiletNm: String, isLiked: Bool,laCrdnt: String, loCrdnt: String ,context: NSManagedObjectContext) {
        let toilets = MyToilets(context: context)
        toilets.photo = photo
        toilets.telno = telno
        toilets.rnAdres = rnAdres
        toilets.toiletNm = toiletNm
        toilets.isLiked = isLiked
        toilets.laCrdnt = laCrdnt
        toilets.loCrdnt = loCrdnt
        
        saveItems(context: context)
    }
    
    func addParking(name: String, rnAdres: String, longitude: String, latitude: String, isLiked: Bool, context: NSManagedObjectContext) {
        let parkings = MyParkings(context: context)
        parkings.name = name
        parkings.rnAdres = rnAdres
        parkings.longitude = longitude
        parkings.latitude = latitude
        parkings.isLiked = isLiked
        
        saveItems(context: context)
    }
    
    func addSpot(title: String, thumbnailPath: String, roadAddress: String, longitude: Double, latitude: Double, isLiked: Bool, context: NSManagedObjectContext) {
        let spots = MySpots(context: context)
        spots.title = title
        spots.thumbnailPath = thumbnailPath
        spots.roadAddress = roadAddress
        spots.longitude = longitude
        spots.latitude = latitude
        spots.isLiked = isLiked
        
        saveItems(context: context)
    }
    
    func editItem(isLiked: Bool, context: NSManagedObjectContext) {
        let toilets = MyToilets(context: context)
        toilets.isLiked = isLiked
        
        saveItems(context: context)
    }
    
    
    func saveItems(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
