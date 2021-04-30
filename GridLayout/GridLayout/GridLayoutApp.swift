//
//  GridLayoutApp.swift
//  GridLayout
//
//  Created by Halis  Kara on 26.12.2020.
//

import SwiftUI

@main
struct GridLayoutApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
