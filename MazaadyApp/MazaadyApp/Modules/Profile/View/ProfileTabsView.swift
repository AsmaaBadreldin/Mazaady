//
//  ProfileTabsView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

protocol ProfileTabsViewDelegate: AnyObject {
    func didSelectTab(index: Int)
}

final class ProfileTabsView: UIView {

    // MARK: - Properties

    weak var delegate: ProfileTabsViewDelegate?

    private let buttonTitles = ["Products", "Articles", "Reviews"]
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()
    private let indicatorView = UIView()

    private var selectedIndex = 0

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
        setupIndicator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }

    private func setupButtons() {
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
            button.setTitleColor(index == 0 ? .systemPink : .darkGray, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    private func setupIndicator() {
        indicatorView.backgroundColor = .systemPink
        indicatorView.layer.cornerRadius = 1.5
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)

        NSLayoutConstraint.activate([
            indicatorView.heightAnchor.constraint(equalToConstant: 3),
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(buttonTitles.count)),
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func tabTapped(_ sender: UIButton) {
        updateSelection(to: sender.tag)
        delegate?.didSelectTab(index: sender.tag)
    }

    func updateSelection(to index: Int) {
        selectedIndex = index
        for (i, button) in buttons.enumerated() {
            button.setTitleColor(i == index ? .systemPink : .darkGray, for: .normal)
        }

        let leadingConstant = CGFloat(index) * (frame.width / CGFloat(buttons.count))
        UIView.animate(withDuration: 0.25) {
            self.indicatorView.frame.origin.x = leadingConstant
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelection(to: selectedIndex) // fix indicator on layout
    }
}
