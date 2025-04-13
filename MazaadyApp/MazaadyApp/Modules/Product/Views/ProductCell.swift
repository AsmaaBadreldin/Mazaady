//
//  ProductCell.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"

    // MARK: - UI Components

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let offerBadge: UILabel = {
        let label = UILabel()
        label.text = "Offer"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.isHidden = true // Hidden by default
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Setup

    private func setupLayout() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(offerBadge)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),

            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),

            offerBadge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            offerBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            offerBadge.widthAnchor.constraint(equalToConstant: 40),
            offerBadge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: - Configuration

    func configure(with product: Product) {
        // 1. Load image from URL
        if let url = URL(string: product.image) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.productImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }

        // 2. Set name and price
        nameLabel.text = product.name
        priceLabel.text = String(format: "%.0f %@", product.price, product.currency)

        // 3. Show badge if offer exists
        offerBadge.isHidden = (product.offer == nil)
    }
}
