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

    // Placeholder views for upcoming steps
    private let bannerStackPlaceholder = UIView() // will be BannerStackView
    private let tagListPlaceholder = UIView() // will be TagListView

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.viewDidLoad()
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
         bannerStackPlaceholder,
         tagListPlaceholder
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addArrangedSubview($0)
        }

        // Temporary heights for placeholders
        tabsView.backgroundColor = .systemGray6
        searchBarView.backgroundColor = .systemGray5
        productGridView.backgroundColor = .systemGray4
        bannerStackPlaceholder.backgroundColor = .systemGray3
        tagListPlaceholder.backgroundColor = .systemGray2

        tabsView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bannerStackPlaceholder.heightAnchor.constraint(equalToConstant: 180).isActive = true
        tagListPlaceholder.heightAnchor.constraint(equalToConstant: 120).isActive = true
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
        print("🟣 Selected tab index: \(index)")
        // Update content
    }
}

extension ProfileViewController: SearchBarViewDelegate {
    func didTapSearchButton(with keyword: String) {
        presenter?.didSearch(with: keyword)
    }
}
