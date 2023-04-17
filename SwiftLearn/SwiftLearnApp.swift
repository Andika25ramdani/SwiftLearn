//
//  SwiftLearnApp.swift
//  SwiftLearn
//
//  Created by Andika on 17/04/23.
//

import SwiftUI

@main
struct SwiftLearnApp: App {
    // let persistenceController = PersistenceController.shared
	let persistence = CDPersistence.shared

    var body: some Scene {
        WindowGroup {
			UISContentView().environment(\.managedObjectContext, persistence.container.viewContext)
			// ContentView()
                // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
