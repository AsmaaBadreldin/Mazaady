//
//  ProfileViewController.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

final class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
    }

    func showUserProfile(_ profile: ProfileModel) {
        // 🔄 Update to reflect your actual model properties
        print("✅ Name:", profile.name)
        print("✅ Username:", profile.userName)
        print("✅ Image URL:", profile.image)
        print("✅ Country:", profile.countryName)
        print("✅ City:", profile.cityName)
        print("✅ Followers: \(profile.followersCount), Following: \(profile.followingCount)")
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
