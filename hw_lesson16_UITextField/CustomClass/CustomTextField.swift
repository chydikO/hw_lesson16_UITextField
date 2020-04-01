//
//  CustomTextField.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 29.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
//    var rightViewImg: UIImageView!
    
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
        
        backgroundColor = .clear
        
        let lView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //lView.backgroundColor = .green
        leftView = lView
        leftViewMode = .always

//        let rView = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.frame.height), height: Int(self.frame.height)))
//        rightViewImg = UIImageView(image: UIImage())
//        rView.addSubview(rightViewImg)
//        rightView = rView
// 
//        
//        rightView = rightViewImg
//        rightViewMode = .always
//        
//        rightViewImg.contentMode = .scaleAspectFill
//        
//        rightViewImg.translatesAutoresizingMaskIntoConstraints = false
//        rightViewImg.leftAnchor.constraint(equalTo: rView.leftAnchor, constant: 0).isActive = true
//        rightViewImg.rightAnchor.constraint(equalTo: rView.rightAnchor, constant: 0).isActive = true
//        rightViewImg.topAnchor.constraint(equalTo: rView.topAnchor, constant: 0).isActive = true
//        rightViewImg.bottomAnchor.constraint(equalTo: rView.bottomAnchor, constant: 0).isActive = true

        
    }
}
