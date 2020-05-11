//
//  Tab2ViewController.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 22.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit
/*
 Создать экран с 6-ю или 8-ю полями ввода (UITextField). Реализовать следующее:
 1. Toolbar в кнопками prev (переход на предыдущее поле ввода), done(завершить редактирование), next (переход на следующее поле ввода).
 2. Кнопки prev и next нужно дизейблить, если нет предыдущих\следующих полей.
 3. Порядок обхода (см. на картинке)
 4. Механизм перехода от поля к полю по нажатию на кнопку return (next-
 >next->next->done)
 5. Поддержка всех экранов (iphone, ipad, портер, альбом). При этом размеры
 полей ввода всегда должны быть одинаковы
 */

class Tab2ViewController: UIViewController {

    @IBOutlet weak var textField1: CustomTextField!
    @IBOutlet weak var textField2: CustomTextField!
    @IBOutlet weak var textField3: CustomTextField!
    @IBOutlet weak var textField4: CustomTextField!
    @IBOutlet weak var textField5: CustomTextField!
    @IBOutlet weak var textField6: CustomTextField!
    @IBOutlet weak var textField7: CustomTextField!
    @IBOutlet weak var textField8: CustomTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!

    private let keyboardToolbar = KeyBoardToolBarForTab2.create()


    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardToolbar?.setup(textInputViews: [textField1,
                                                textField3,
                                                textField5,
                                                textField7,
                                                textField2,
                                                textField4,
                                                textField6,
                                                textField8])
        
        keyboardToolbar?.onDoneButtonClicked = { [weak self] in
            self?.view.endEditing(true)
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
}

extension Tab2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textField1 {
            textField3?.becomeFirstResponder()
        } else if textField == textField2 {
            textField4?.becomeFirstResponder()
        } else if textField == textField3 {
            textField5?.becomeFirstResponder()
        } else if textField == textField4 {
            textField6?.becomeFirstResponder()
        } else if textField == textField5 {
            textField7?.becomeFirstResponder()
        } else if textField == textField6 {
            textField8?.becomeFirstResponder()
        } else if textField == textField7 {
            textField2?.becomeFirstResponder()
        }else {
            view.endEditing(true)
        }
        
        return true
    }
}
