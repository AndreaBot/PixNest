//
//  PixNestApp.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI
import CoreData

@main
struct PixNestApp: App {
    
    @StateObject var coreDataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(coreDataManager)
                .onAppear {
                    coreDataManager.loadData()
                }
        }
    }
}

