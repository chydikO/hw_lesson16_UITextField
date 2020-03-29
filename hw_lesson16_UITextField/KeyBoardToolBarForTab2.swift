//
//  KeyBoardToolBarForTab2.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 29.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class KeyBoardToolBarForTab2: UIToolbar {
    
    //массив всех UITextField которые присутствуют на экране во время вводв
    private var inputViews: [UITextField] = []
    private var currentInputView: UITextField?
    
    static func create() -> KeyBoardToolBarForTab2? {
        return Bundle.main.loadNibNamed("KeyBoardToolBarForTab2XIB", owner: nil, options: nil)?.first as? KeyBoardToolBarForTab2 ?? KeyBoardToolBarForTab2()
    }
    
    //TODO: сделать метод init, если мы будем игититься без XIB
    //    override init(frame: CGRect) {
    //
    //    }
    
    var onDoneButtonClicked: (() -> ())?
    
    
    
    @IBOutlet weak private var prevButton: UIBarButtonItem?
    @IBOutlet weak private var nextButton: UIBarButtonItem?
    @IBOutlet weak private var doneButton: UIBarButtonItem?
    
    @IBAction private func prevButtonClicked() {
        if let textField = currentInputView,
            let index = inputViews.firstIndex(of: textField) {
            if index - 1 >= 0 {
                inputViews[index - 1].becomeFirstResponder()
            }
        }
    }
    
    @IBAction private func nextButtonClicked() {
        if let textField = currentInputView,
            let index = inputViews.firstIndex(of: textField) {
            if index + 1 < inputViews.count {
                inputViews[index + 1].becomeFirstResponder()
            }
        }
    }
    
    @IBAction private func doneButtonClicked() {
        onDoneButtonClicked?()
    }
    
    @objc private func textFieldDidBeginEditind(sender: UITextField) {
        currentInputView = sender
        var newImg: UIImage

        // set img for prevButton
        prevButton?.isEnabled = (currentInputView != inputViews.first)
        if let btnState = prevButton?.isEnabled, btnState {
            newImg = UIImage(named: "icons8-slide-up-100") ?? UIImage()
        } else {
            newImg = UIImage(named: "icons8-up-100") ?? UIImage()
        }
        prevButton?.image = newImg
        
        // set img for nextButton
        nextButton?.isEnabled = (currentInputView != inputViews.last)
        if let btnState = nextButton?.isEnabled, btnState {
            newImg = UIImage(named: "icons8-down-button-100") ?? UIImage()
        } else {
            newImg = UIImage(named: "icons8-down-100") ?? UIImage()
        }
        nextButton?.image = newImg
        
    }
    
    func setup(textInputViews: [UITextField]) {
        inputViews.removeAll()
        inputViews.append(contentsOf: textInputViews)
        inputViews.forEach { textInput in
            textInput.inputAccessoryView = self
            textInput.addTarget(self, action: #selector(textFieldDidBeginEditind(sender:)), for: UIControl.Event.editingDidBegin)
        }
    }
    
}
