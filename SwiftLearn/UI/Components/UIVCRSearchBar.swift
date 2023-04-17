//
//  UIVCRSearchBar.swift
//  CMT55
//
//  Created by Andika on 08/03/23.
//

import Combine
import SwiftUI

struct UIVCRSearchBar: UIViewControllerRepresentable {
	@Binding var text: String

	init(text: Binding<String>) {
		self._text = text
	}

	func makeUIViewController(context: Context) -> SearchBarWrapperController {
		return SearchBarWrapperController()
	}

	func updateUIViewController(_ controller: SearchBarWrapperController, context: Context) {
		controller.searchController = context.coordinator.searchController
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(text: $text)
	}

	class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
		@Binding var text: String
		let searchController: UISearchController

		init(text: Binding<String>) {
			self._text = text
			self.searchController = UISearchController(searchResultsController: nil)

			super.init()

			searchController.searchResultsUpdater = self
			searchController.searchBar.delegate = self
			searchController.hidesNavigationBarDuringPresentation = false
			searchController.obscuresBackgroundDuringPresentation = false

			self.searchController.searchBar.text = self.text
		}

		func updateSearchResults(for searchController: UISearchController) {
			guard let text = searchController.searchBar.text else { return }
			self.text = text
		}
	}

	class SearchBarWrapperController: UIViewController {
		var searchController: UISearchController? {
			didSet {
				self.parent?.navigationItem.searchController = searchController
			}
		}

		override func viewWillAppear(_ animated: Bool) {
			self.parent?.navigationItem.searchController = searchController
		}
		override func viewDidAppear(_ animated: Bool) {
			self.parent?.navigationItem.searchController = searchController
		}
	}
}
