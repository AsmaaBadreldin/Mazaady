//
//  SearchBarView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

protocol SearchBarViewDelegate: AnyObject {
    func didTapSearchButton(with keyword: String)
}

final class SearchBarView: UIView {

    // MARK: - Properties

    weak var delegate: SearchBarViewDelegate?

    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.borderStyle = .none
        tf.layer.cornerRadius = 12
        tf.layer.masksToBounds = true
        tf.backgroundColor = UIColor.systemGray6
        tf.font = .systemFont(ofSize: 14)
        tf.setLeftIcon(UIImage(named: "searchIcon")!)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "sendIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.cornerRadius = 22
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        let container = UIStackView(arrangedSubviews: [textField, searchButton])
        container.axis = .horizontal
        container.spacing = 8
        container.alignment = .fill
        container.translatesAutoresizingMaskIntoConstraints = false

        addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            searchButton.widthAnchor.constraint(equalToConstant: 44),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Actions

    @objc private func searchTapped() {
        delegate?.didTapSearchButton(with: textField.text ?? "")
    }

    // Optional external config
    func setPlaceholder(_ text: String) {
        textField.placeholder = text
    }

    func setText(_ text: String) {
        textField.text = text
    }
}
