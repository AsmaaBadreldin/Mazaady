//
//  ProductGridView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

final class ProductGridView: UIView, ProductGridViewProtocol, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UI

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false // Important for height auto-adjustment
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    private var heightConstraint: NSLayoutConstraint?

    // MARK: - Dependencies

    private var presenter: ProductGridPresenter!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
        presenter = ProductGridPresenter(view: self)
        presenter.viewDidLoad()
        observeContentSize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupCollectionView() {
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayout() {
        addSubview(collectionView)
        heightConstraint = heightAnchor.constraint(equalToConstant: 400) // initial fallback
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

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentSize",
              let newSize = change?[.newKey] as? CGSize else { return }

        heightConstraint?.constant = newSize.height
        layoutIfNeeded()
    }

    deinit {
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }

    // MARK: - ProductGridViewProtocol

    func reloadData() {
        collectionView.reloadData()
    }

    func showError(_ message: String) {
        // Optional: show an alert or empty view
    }

    // MARK: - UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }

        let product = presenter.product(at: indexPath.item)
        cell.configure(with: product)
        return cell
    }

    // MARK: - UICollectionView DelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 * 3
        let availableWidth = collectionView.frame.width - padding
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: itemWidth * 1.6)
    }
}
