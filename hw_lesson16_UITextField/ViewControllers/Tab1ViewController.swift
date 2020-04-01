//
//  ViewController.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 22.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

/*
 Создать экран с 4-мя полями ввода (UITextField)
 1-е поле ввода может принимать только буквенные символы
 2-е поле ввода может принимать только числовые символы
 3-е поле для ввода email
 4-е поле для ввода пароля
 Серый текст – это текст плейсхолдера.
 Для каждого поля ввода настроить клавиатуру, "секюрность», автокоррекцию и т.д. в зависимости от функциональной нагрузки конкретного поля ввода.
 Так же реализовать механизм перехода от поля к полю по нажатию на кнопку return (next->next->next->done)
 */
import UIKit

class Tab1ViewController: UIViewController {
   
    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var numberField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var passwordTextLabel: CustomTextField!
    
    private let keyboardToolbar = KeyBoardToolBarForTab1.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()

        //назначаем нашу клавиатуру над штатной, при попадании на поле ввода numberField
        //numberField?.inputAccessoryView = keyboardToolbar
        keyboardToolbar?.setup(textInputViews: [ numberField])

        keyboardToolbar?.onDoneButtonClicked = { [weak self] in
            self?.view.endEditing(true)
        }
        
        keyboardToolbar?.onNextButtonClicked = { [weak self] in
            self?.emailField.becomeFirstResponder()
        }
        
        keyboardToolbar?.onPrevButtonClicked = { [weak self] in
            self?.textField.becomeFirstResponder()
        }

    }
    
    private func setup() {
        
        passwordTextLabel.layer.borderColor = UIColor.white.cgColor

        //set Email: in the email textField
        let lView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "Email:"
        lView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: lView.leftAnchor, constant: 10),
                                     label.centerYAnchor.constraint(equalTo: lView.centerYAnchor, constant: 0),
                                     label.rightAnchor.constraint(equalTo: lView.rightAnchor, constant: -10),
        ])
        
        
        emailField.leftView = lView
        emailField.leftViewMode = .always
    }
    
    @IBAction private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension Tab1ViewController: UITextFieldDelegate {
    //когда пользователь нажал кнопку Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.textField {
            // переводим ввод на 2-е поле
            numberField.becomeFirstResponder()
        } else if textField == numberField {
            // переводим ввод на 2-е поле
            //passwordField.becomeFirstResponder()
        } else if textField == emailField {
            // переводим ввод на 2-е поле
            passwordField.becomeFirstResponder()
        } else {
        //спрятать клавиатуру
        textField.resignFirstResponder()
        }
        return true
    }
}
