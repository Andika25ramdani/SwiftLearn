//
//  UISContentView.swift
//  SwiftLearn
//
//  Created by Andika on 17/04/23.
//

import CoreData
import SwiftUI

struct UISContentView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(entity: CDMEUser.entity(), sortDescriptors: [.init(key: "displayname", ascending: true)]) private var users: FetchedResults<CDMEUser>
	@State private var searchUser = ""
	
	func addUser() {
		withAnimation {
			let user = CDMEUser(context: viewContext)
			let id = UUID()
			user.displayname = "User \(id.uuidString)"
			user.username = id.uuidString
			user.phone = "+62\(id.uuidString)"
			self.saveContext()
		}
	}
	
	func saveContext() {
		do { try viewContext.save() }
		catch { print("🤬 Failed to save Context with error:", error) }
	}
	
	func deleteUser(offsets: IndexSet) {
		withAnimation {
			offsets.map({ users[$0] }).forEach(viewContext.delete)
			self.saveContext()
		}
	}
	
    var body: some View {
		NavigationView(content: {
			List(content: {
				ForEach(users.filter({
					self.searchUser.isEmpty ? true : $0.displayname?.lowercased().contains(self.searchUser.lowercased()) ?? false
				}), content: { user in
					HStack(content: {
						Image(systemName: "person").font(.largeTitle)
						VStack(content: {
							Text(user.displayname ?? "")
						})
					})
				}).onDelete(perform: self.deleteUser)
			})
			.navigationTitle("Users")
			.overlay(UIVCRSearchBar(text: $searchUser).frame(width: 0, height: 0))
			.toolbar(content: {
				ToolbarItem(content: {
					Button(action: self.addUser, label: {
						Label("Add", systemImage: "plus")
					})
				})
			})
		}).navigationViewStyle(.stack)
    }
}

struct UISContentView_Previews: PreviewProvider {
    static var previews: some View {
        UISContentView()
    }
}
