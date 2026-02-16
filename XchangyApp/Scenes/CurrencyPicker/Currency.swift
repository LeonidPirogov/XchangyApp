//
//  Currency.swift
//  XchangyApp
//
//  Created by Leonid on 11.02.2026.
//

import UIKit

struct Currency: Equatable {
    let code: String
    let flagImageName: String
    let flagContentRect: CGRect?
    
    var flag: UIImage? { UIImage(named: flagImageName) }
}
