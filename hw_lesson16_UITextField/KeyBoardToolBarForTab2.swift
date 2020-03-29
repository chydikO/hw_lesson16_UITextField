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

       static func create() -> KeyBoardToolBarForTab1? {
           return Bundle.main.loadNibNamed("KeyBoardToolBarXIB", owner: nil, options: nil)?.first as? KeyBoardToolBarForTab1 ?? KeyBoardToolBarForTab1()
       }
       
       //TODO: сделать метод init, если мы будем игититься без XIB
       //    override init(frame: CGRect) {
       //
       //    }
       
       var onDoneButtonClicked: (() -> ())?
      
       
       
       @IBOutlet private var prevButton: UIBarButtonItem?
       @IBOutlet private var nextButton: UIBarButtonItem?
       @IBOutlet private var doneButton: UIBarButtonItem?
       
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
           prevButton?.isEnabled = (currentInputView != inputViews.first)
           nextButton?.isEnabled = (currentInputView != inputViews.last)
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
