//
//  BannerView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

final class BannerView: UIView {

    // MARK: - Properties

    private var heightConstraint: NSLayoutConstraint?
    private var banners: [Advertisement] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Changed to vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false // Let height expand instead
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
        fetchBanners()
        observeContentSize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayout() {
        addSubview(collectionView)

        heightConstraint = heightAnchor.constraint(equalToConstant: 180) // fallback until banners load
        heightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func observeContentSize() {
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentSize",
              let newSize = change?[.newKey] as? CGSize else { return }

        heightConstraint?.constant = newSize.height
        layoutIfNeeded()
    }

    deinit {
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }

    // MARK: - Network

    private func fetchBanners() {
        BannerService.shared.fetchAdvertisements { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.banners = data
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Failed to load banners: \(error)")
                }
            }
        }
    }
}

// MARK: - Collection View

extension BannerView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: banners[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalInset: CGFloat = 16
        let width = collectionView.frame.width - (horizontalInset * 2)
        let height: CGFloat = 120 // Set a fixed height for banner cells
        return CGSize(width: width, height: height)
    }


}
