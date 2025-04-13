//
//  ProfileHeaderView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

final class ProfileHeaderView: UIView {

    // MARK: - UI Elements

    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let locationLabel = UILabel()

    private let followersView = ProfileStatView()
    private let followingView = ProfileStatView()

    private lazy var statsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followersView, followingView])
        stack.axis = .horizontal
        stack.spacing = 32
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("LangSelected", comment: "English")
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var languageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [languageLabel, settingsButton])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSettingsAction(target: Any?, action: Selector) {
        settingsButton.addTarget(target, action: action, for: .touchUpInside)
    }

    // MARK: - Configure

    func configure(with profile: ProfileModel) {
        nameLabel.text = profile.name
        usernameLabel.text = "@\(profile.userName)"
        locationLabel.text = "\(profile.cityName), \(profile.countryName)"

        followersView.configure(
            count: "\(profile.followersCount)",
            label: "Followers",
            icon: UIImage(named: "icon_followers")
        )

        followingView.configure(
            count: "\(profile.followingCount)",
            label: "Following",
            icon: UIImage(named: "icon_following")
        )

        if let url = URL(string: profile.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    // MARK: - Layout

    private func setupViews() {
        [languageStack, avatarImageView, nameLabel, usernameLabel, locationLabel, statsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.clipsToBounds = true

        nameLabel.font = .boldSystemFont(ofSize: 18)
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .usernameGray

        locationLabel.font = .systemFont(ofSize: 14, weight: .light)
        locationLabel.textColor = .gray
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            languageStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            languageStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            settingsButton.widthAnchor.constraint(equalToConstant: 20),
            settingsButton.heightAnchor.constraint(equalToConstant: 20),

            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            locationLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            statsStack.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
            statsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            statsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
