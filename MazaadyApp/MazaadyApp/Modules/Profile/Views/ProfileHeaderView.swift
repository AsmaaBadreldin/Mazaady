//
//  ProfileHeaderView.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

final class ProfileHeaderView: UIView {

    // MARK: - UI Elements

    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let locationLabel = UILabel()
    let statsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with profile: ProfileModel) {
        nameLabel.text = profile.name
        usernameLabel.text = "@\(profile.userName)"
        locationLabel.text = "\(profile.cityName), \(profile.countryName)"
        statsLabel.text = "\(profile.followersCount) Followers • \(profile.followingCount) Following"

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

    private func setupViews() {
        [avatarImageView, nameLabel, usernameLabel, locationLabel, statsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.clipsToBounds = true

        nameLabel.font = .boldSystemFont(ofSize: 18)
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .darkGray
        locationLabel.font = .systemFont(ofSize: 14)
        statsLabel.font = .systemFont(ofSize: 13)
        statsLabel.textColor = .systemPink
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
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

            statsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 6),
            statsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            statsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
