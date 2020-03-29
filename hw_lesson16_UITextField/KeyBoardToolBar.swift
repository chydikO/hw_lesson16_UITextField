//
//  KeyBoardToolBar.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 27.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class KeyBoardToolBar: UIToolbar {
    
    //массив всех UITextField которые присутствуют на экране во время вводв
    private var inputViews: [UITextField] = []
    
    static func create() -> KeyBoardToolBar? {
        return Bundle.main.loadNibNamed("KeyBoardToolBarXIB", owner: nil, options: nil)?.first as? KeyBoardToolBar ?? KeyBoardToolBar()
    }
    
    //TODO: сделать метод init, если мы будем игититься без XIB
    //    override init(frame: CGRect) {
    //
    //    }
    
    var onDoneButtonClicked: (() -> ())?
    var onPrevButtonClicked: (() -> ())?
    var onNextButtonClicked: (() -> ())?
    
    
    @IBOutlet private var prevButton: UIBarButtonItem?
    @IBOutlet private var nextButton: UIBarButtonItem?
    @IBOutlet private var doneButton: UIBarButtonItem?
    
    @IBAction private func prevButtonClicked() {
        onPrevButtonClicked?()
    }
    
    @IBAction private func nextButtonClicked() {
        onNextButtonClicked?()
    }
    
    @IBAction private func doneButtonClicked() {
        onDoneButtonClicked?()
    }
    
    func setup(textInputViews: [UITextField]) {
        inputViews.removeAll()
        inputViews.append(contentsOf: textInputViews)
        
        inputViews.forEach { textField in
            textField.inputAccessoryView = self
            
        }
    }
}
