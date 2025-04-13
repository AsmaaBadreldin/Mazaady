//
//  TagCell.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

final class TagCell: UICollectionViewCell {
    static let identifier = "TagCell"

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }

    private func setupUI() {
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    func configure(with title: String, isSelected: Bool) {
        label.text = title

        if isSelected {
            contentView.backgroundColor = UIColor.systemOrange
            label.textColor = .white
            contentView.layer.borderColor = UIColor.systemOrange.cgColor
        } else {
            contentView.backgroundColor = .white
            label.textColor = .black
            contentView.layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
}

