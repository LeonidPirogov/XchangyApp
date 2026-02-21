//
//  UIView+AddSubviews.swift
//  XchangyApp
//
//  Created by Leonid on 21.02.2026.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
