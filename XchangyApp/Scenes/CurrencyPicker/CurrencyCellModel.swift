//
//  CurrencyCellModel.swift
//  XchangyApp
//
//  Created by Leonid on 04.03.2026.
//

import UIKit

struct CurrencyCellModel {
    let code: String
    let flag: UIImage?
    let flagContentsRect: CGRect
    let isSelected: Bool

    init(code: String, flag: UIImage?, flagContentsRect: CGRect? = nil, isSelected: Bool) {
        self.code = code
        self.flag = flag
        self.flagContentsRect = flagContentsRect ?? CGRect(x: 0, y: 0, width: 1, height: 1)
        self.isSelected = isSelected
    }
}
