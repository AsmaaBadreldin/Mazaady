//
//  ProfileViewController.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

final class ProfileViewController: UIViewController, ProfileViewProtocol {

    var presenter: ProfilePresenterProtocol?

    // MARK: - UI Components

    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    private let headerView = ProfileHeaderView()
    private let tabsView = ProfileTabsView()
    private let searchBarView = SearchBarView()
    private let productGridView = ProductGridView()
    private let bannerView = BannerView()
    private let tagListView = TagListView()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.setSettingsAction(target: self, action: #selector(didTapLanguage))

        setupLayout()
        presenter?.viewDidLoad()
        
        view.semanticContentAttribute = .forceLeftToRight
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Layout Setup

    private func setupLayout() {
        tabsView.delegate = self
        searchBarView.delegate = self
        
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 16

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Add arranged subviews in order
        [headerView,
         tabsView,
         searchBarView,
         productGridView,
         bannerView,
         tagListView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addArrangedSubview($0)
        }

        view.backgroundColor = UIColor.systemGroupedBackground
        scrollView.backgroundColor = UIColor.systemGroupedBackground
        contentView.backgroundColor = UIColor.systemGroupedBackground

        tabsView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    // MARK: - Language setup

    @objc private func didTapLanguage() {
        let alert = UIAlertController(title: "Language".localized, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
            self.setLanguage("en")
        }))

        alert.addAction(UIAlertAction(title: "العربية", style: .default, handler: { _ in
            self.setLanguage("ar")
        }))

        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))

        // For iPad support
        if let popover = alert.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }

        present(alert, animated: true)
    }
    
    private func setLanguage(_ code: String) {
//        guard Locale.current.language.languageCode?.identifier != code else { return }
//
//        UserDefaults.standard.set([code], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//
//        // Force semantic direction (optional)
//        UIView.appearance().semanticContentAttribute = .forceLeftToRight
//
//        // Reload app interface
//        let sceneDelegate = UIApplication.shared.connectedScenes
//            .first?.delegate as? SceneDelegate
//        sceneDelegate?.reloadAppInterface()
    }


    // MARK: - ProfileViewProtocol

    func showUserProfile(_ profile: ProfileModel) {
        headerView.configure(with: profile)
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ProfileViewController: ProfileTabsViewDelegate {
    func didSelectTab(index: Int) {
        print("Selected tab index: \(index)")
        // Update content
    }
}

extension ProfileViewController: SearchBarViewDelegate {
    func didTapSearchButton(with keyword: String) {
        if keyword.isEmpty {
            productGridView.clearFilter()
        } else {
            productGridView.filterProducts(by: keyword)
        }
    }
}
