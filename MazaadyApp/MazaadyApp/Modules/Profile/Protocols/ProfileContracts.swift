//
//  ProfileContracts.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func showUserProfile(_ profile: ProfileModel)
    func showError(_ message: String)
}

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapLanguage()
    func didSearch(with keyword: String)
}
