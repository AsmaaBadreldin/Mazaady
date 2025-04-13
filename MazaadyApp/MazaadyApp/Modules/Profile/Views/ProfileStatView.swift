//
//  Untitled.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

final class ProfileStatView: UIView {

    private let iconImageView = UIImageView()
    private let countLabel = UILabel()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(count: String, label: String, icon: UIImage?) {
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        countLabel.text = count
        titleLabel.text = label
    }

    private func setupLayout() {
        // Icon
        iconImageView.tintColor = .systemPink
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true

        // Count
        countLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        countLabel.textColor = .label
        countLabel.textAlignment = .center

        // Title
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = .systemPink
        titleLabel.textAlignment = .center

        // Vertical stack for count + title
        let verticalStack = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 2
        verticalStack.alignment = .leading

        // Horizontal stack with icon + vertical info
        let horizontalStack = UIStackView(arrangedSubviews: [iconImageView, verticalStack])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 6
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(horizontalStack)

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
