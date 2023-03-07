//
//  UIView + Extension.swift
//  СookBook
//
//  Created by Mac OS on 01.03.2023.
//

import UIKit

// MARK: - extension UIView
extension UIView {
    func rounded(radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
    }
}
