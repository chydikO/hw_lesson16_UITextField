//
//  CustomTextField.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 29.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8
        
        let lView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //lView.backgroundColor = .green
        leftView = lView
        leftViewMode = .always
    }
}
