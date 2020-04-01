//
//  Tab4ViewController.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 22.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class Tab4ViewController: UIViewController {

    @IBOutlet weak var cvvTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cvvKeyboard = KeyBoardToolBarForTab4.create()
               cvvTextField?.inputView = cvvKeyboard
        
    }
    
    @IBAction private func hideKeyboard() {
        view.endEditing(true)
    }
}
