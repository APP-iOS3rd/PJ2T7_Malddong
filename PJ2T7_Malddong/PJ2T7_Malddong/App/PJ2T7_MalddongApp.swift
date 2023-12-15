//
//  PJ2T7_MalddongApp.swift
//  PJ2T7_Malddong
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData

@main
struct PJ2T7_MalddongApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
