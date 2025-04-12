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
        NetworkManager.shared.fetchProfileData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.view?.showUserProfile(profile)
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    func didTapLanguage() {
        // Handle language switching logic if needed
    }

    func didSearch(with keyword: String) {
        // Optional: handle search logic or filtering here
    }
}
