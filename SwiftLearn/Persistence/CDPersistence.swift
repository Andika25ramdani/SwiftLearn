//
//  CDPersistence.swift
//  SwiftLearn
//
//  Created by Andika on 17/04/23.
//

import CoreData

struct CDPersistence {
	static let shared = CDPersistence()
	
	let container: NSPersistentContainer
	
	init() {
		self.container = NSPersistentContainer(name: "CDMSwiftLearn")
		container.loadPersistentStores(completionHandler: { description, error in
			if let error = error as NSError? { fatalError("🤬 Failed to load UserContainer with error: \(error)") }
			print("😪 CDPersistence - init", description)
		})
	}
}
