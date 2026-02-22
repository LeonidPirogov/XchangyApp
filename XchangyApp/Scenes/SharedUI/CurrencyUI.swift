//
//  CurrencyUI.swift
//  XchangyApp
//
//  Created by Leonid on 22.02.2026.
//

import UIKit

struct CurrencyUI: Equatable {
    let currency: Currency
    let flagImageName: String
    let flagContentRect: CGRect?
    
    var flag: UIImage? { UIImage(named: flagImageName) }
}
