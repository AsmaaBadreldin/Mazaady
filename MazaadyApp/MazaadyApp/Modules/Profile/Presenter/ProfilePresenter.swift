//
//  ProfilePresenter.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?

    init(view: ProfileViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        // Simulated data
        let mockProducts = [
            Product(id: 1, title: "Red Jacket", price: 500, imageURL: "", isSpecial: true, endDate: Date().addingTimeInterval(3600)),
            Product(id: 2, title: "Blue Shirt", price: 300, imageURL: "", isSpecial: false, endDate: nil)
        ]
        let mockProfile = ProfileModel(username: "Ahmed Mohammed", imageURL: "", products: mockProducts)
        view?.showUserProfile(mockProfile)
    }

    func didTapLanguage() {
        // Handle language switching logic if needed
    }

    func didSearch(with keyword: String) {
        // Optional: handle search logic or filtering here
    }
}
