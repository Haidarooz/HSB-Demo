//
//  UIViewExtensions.swift
//  HSB Demo
//
//  Created by Haidar Mohammed on 4/7/20.
//  Copyright © 2020 Haidar AlOgaily. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func addSubview(_ view: UIView, _ autoTranslateConstraints: Bool){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
}
