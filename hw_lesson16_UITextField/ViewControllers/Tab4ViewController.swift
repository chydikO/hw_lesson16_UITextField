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
    @IBOutlet weak var scrollView: UIScrollView!
    
    private final let CVV2_REGEX = NSRegularExpression("^([0-9]{3})$")
    
    private var cvvKeyboard: KeyBoardToolBarForTab4!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvvKeyboard = KeyBoardToolBarForTab4.create()
        cvvTextField?.inputView = cvvKeyboard
        
        
        cvvKeyboard.onDeleteButtonClicked = { [weak self] in
            self?.cvvTextField.deleteBackward()
            self?.setDoneBtnStstus()
        }
        
        cvvKeyboard.onDoneButtonClicked = { [weak self] in
            self?.hideKeyboard()
        }
        
        cvvKeyboard.onNumberPadButtonClicked = { [weak self] label in
            guard let currentValue = self?.cvvTextField.text else {
                return
            }
            self?.cvvTextField.text = currentValue + label
            self?.setDoneBtnStstus()
            
            self?.cvvKeyboard.shuffleArrayOfNumbers()
            self?.cvvKeyboard.setBtnLabelsText()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            guard
                let frameEnd = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                else {
                    return
            }
            
            self?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frameEnd.size.height + 20, right: 0)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            
            self?.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func deleteSymbol() {
        cvvTextField.deleteBackward()
    }
    
    private func setDoneBtnStstus() {
        if let cvv2 = cvvTextField.text {
            if CVV2_REGEX.matches(cvv2) {
                cvvKeyboard.donePad.isEnabled = true
            } else {
                cvvKeyboard?.donePad.isEnabled = false
            }
        }
        if cvvKeyboard.donePad.isEnabled {
            cvvKeyboard.donePad.layer.borderColor =  UIColor.black.cgColor
        } else {
            cvvKeyboard.donePad.layer.borderColor = UIColor.white.cgColor
        }
        
    }
}
