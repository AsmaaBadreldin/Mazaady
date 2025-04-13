//
//  UITextFieldExtention.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import UIKit

extension UITextField {
    func setLeftIcon(_ icon: UIImage) {
        let iconView = UIImageView(image: icon)
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        paddingView.addSubview(iconView)
        iconView.center = paddingView.center

        leftView = paddingView
        leftViewMode = .always
    }
}

