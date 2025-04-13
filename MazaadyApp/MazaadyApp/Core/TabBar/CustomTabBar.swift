//
//  CustomTabBar.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

final class CustomTabBar: UITabBar {

    private let centerButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCenterButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCenterButton()
    }

    private func setupCenterButton() {
        let size: CGFloat = 60
        centerButton.frame = CGRect(x: 0, y: 0, width: size, height: size)
        centerButton.backgroundColor = UIColor(named: "MainColor") ?? .systemPink
        centerButton.layer.cornerRadius = size / 2
        centerButton.layer.shadowColor = UIColor.systemPink.cgColor
        centerButton.layer.shadowOpacity = 0.25
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        centerButton.layer.shadowRadius = 10

        let icon = UIImage(named: "tab_store_colored")?.withRenderingMode(.alwaysOriginal)
        centerButton.setImage(icon, for: .normal)
        centerButton.tintColor = .clear // Not used, image uses original rendering
        centerButton.backgroundColor = .clear // Remove pink circle
        centerButton.imageView?.contentMode = .scaleAspectFit

        // 👇 Add target for tap action
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)

        addSubview(centerButton)
    }

    @objc private func centerButtonTapped() {
        if let tabBarController = self.window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 2 // assuming center tab index is 2
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let tabBarHeight = bounds.height
        let tabBarWidth = bounds.width
        centerButton.center = CGPoint(x: tabBarWidth / 2, y: tabBarHeight / 2 - 12)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // ensure taps on button pass through
        if !clipsToBounds && !isHidden && alpha > 0 {
            if centerButton.frame.contains(point) {
                return centerButton
            }
        }
        return super.hitTest(point, with: event)
    }
}
