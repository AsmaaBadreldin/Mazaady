//
//  MainTabBarController.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

import UIKit

final class MainTabBarController: UITabBarController {

    private let customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar") // inject custom tab bar
        setupTabBarAppearance()
        setupViewControllers()
    }

    private func setupTabBarAppearance() {
        tabBar.tintColor = .systemPink
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .white
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.05
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 10
    }

    private func setupViewControllers() {
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .systemGroupedBackground
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab_home"), tag: 0)

        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .systemGroupedBackground
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "tab_search"), tag: 1)

        let storeVC = UIViewController()
        storeVC.view.backgroundColor = .systemGroupedBackground
        storeVC.tabBarItem = UITabBarItem()
        
        let cartVC = UIViewController()
        cartVC.view.backgroundColor = .systemGroupedBackground
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "tab_cart"), tag: 3)

        // ✅ Here’s where we inject the presenter to ProfileViewController
        let profileVC = ProfileViewController()
        let presenter = ProfilePresenter(view: profileVC)
        profileVC.presenter = presenter

        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab_profile_selected"), tag: 4)


        viewControllers = [homeVC, searchVC, storeVC, cartVC, profileVC]
    }
}
