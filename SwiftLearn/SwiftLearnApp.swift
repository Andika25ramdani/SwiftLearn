//
//  SwiftLearnApp.swift
//  SwiftLearn
//
//  Created by Andika on 17/04/23.
//

import SwiftUI

@main
struct SwiftLearnApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
