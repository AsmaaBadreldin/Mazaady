//
//  TagListView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

final class TagListView: UIView {

    private var tags: [Tag] = []
    private var selectedIndex: Int = 0

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Tags"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()


    private var heightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
        observeContentSize()
        fetchTags()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, collectionView])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)
        addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        // Initial fallback height (will auto-update later)
        heightConstraint = heightAnchor.constraint(equalToConstant: 200)
        heightConstraint?.isActive = true
    }

    private func observeContentSize() {
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize",
           let newSize = change?[.newKey] as? CGSize {
            
            // Calculate total height: label height + spacing + tags
            let titleHeight: CGFloat = 22 // roughly label height
            let verticalSpacing: CGFloat = 12
            let totalHeight = titleHeight + verticalSpacing + newSize.height

            if heightConstraint?.constant != totalHeight {
                heightConstraint?.constant = totalHeight
                setNeedsLayout()
                layoutIfNeeded()
            }
        }
    }

    deinit {
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }

    private func fetchTags() {
        TagService.shared.fetchTags { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tags):
                    self?.tags = tags
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Failed to load tags:", error)
                }
            }
        }
    }
}

// MARK: - CollectionView Delegate & DataSource

extension TagListView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCell.identifier,
            for: indexPath
        ) as? TagCell else {
            return UICollectionViewCell()
        }

        let isSelected = indexPath.item == selectedIndex
        cell.configure(with: tags[indexPath.item].name, isSelected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
    }
}
