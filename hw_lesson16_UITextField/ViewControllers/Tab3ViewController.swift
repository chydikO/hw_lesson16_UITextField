//
//  Tab3ViewController.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 22.03.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

/*
 Реализовать экран с навигейшен баром, в котором есть две кнопки: Очистить (очищает содержимое всех полей ввода), Готово (валидирует вводимые пользователем данные).
 На экране разместить три поля ввода:
 1. ФИО – вводим фио пользователя, все слова должны начинаться с заглавной буквы, валидация для это поля – минимум должно быть два слова (в некоторых странах нет отчества)
 2. Телефон – вводим номер телефона, вводить можно только цифры, валидируем по такому признаку: номер телефона должен состоять из 12 цифр
 3. Почта – вводим эл. почту пользователя, валидируем по признаку что введенный текст соответствует формату электронного адреса (есть минимум '@', '.' и др. символы)
 4. При нажатии на кнопку Готово выполнить валидация всех полей, если поле не прошло валидацию – в правой его части отобразить картинку в виде восклицательного знака.
 5. Реализовать механизм перехода от поля к полю по нажатию на кнопку return (next->next->next->done)
 */
import UIKit

class Tab3ViewController: UIViewController {

    @IBOutlet weak var fullNameTL: UILabel!
    @IBOutlet weak var telTL: UILabel!
    @IBOutlet weak var emailTL: UILabel!
    
    @IBOutlet weak var fullNameTF: CustomTextField!
    @IBOutlet weak var telTF: CustomTextField!
    @IBOutlet weak var emailTF: CustomTextField!
    @IBOutlet var collectionsTextField: [CustomTextField]!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    private let keyboardToolbar = KeyBoardToolBarForTab1.create()
    
    private var isDoneButtonEnable = false
    
   
    
//    private final let rightViewTrue = UIImageView(image: UIImage(named: "icons-true"))
//    private final let rightViewFalse = UIImageView(image: UIImage(named: "icons-false"))
    
    private final let NAME_REGEX = NSRegularExpression("^([A-Z][a-z]{2,}\\s[A-Z][a-z]{1,}\\s?([A-Z][a-z]{1,})?)")
    private final let TELEPHONE_REGEX = NSRegularExpression("^\\+?3?8?(0\\d{9})$")
    private final let EMAIL_REGEX = NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    
    private var isFullNameValid = false
    private var isEmailValid = false
    private var isTelephoneValid = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextLabel()
        
        keyboardToolbar?.setup(textInputViews: [telTF])

        keyboardToolbar?.onDoneButtonClicked = { [weak self] in
            self?.view.endEditing(true)
        }
        
        keyboardToolbar?.onNextButtonClicked = { [weak self] in
            self?.emailTF.becomeFirstResponder()
        }
        
        keyboardToolbar?.onPrevButtonClicked = { [weak self] in
            self?.fullNameTF.becomeFirstResponder()
        }
    }
    

   
    private func setupTextLabel() {

        doneButton.isEnabled = isDoneButtonEnable
    }

    @IBAction private func clearButtonClicked() {
        collectionsTextField.forEach { label in
            label.text = ""
            fullNameTF.rightView = nil
            emailTF.rightView = nil
            telTF.rightView = nil

        }
    }
    
    @IBAction private func doneButtonClicked() {
        //проверка всех полейй ввода - валидация
        let rightViewTrue = UIImageView(image: UIImage(named: "icons-true"))
        let rightViewFalse = UIImageView(image: UIImage(named: "icons-false"))
        
        if isFullNameValid {
            fullNameTF.rightView = rightViewTrue
        } else {
            fullNameTF.rightView = rightViewFalse
        }
        
        if isTelephoneValid {
            telTF.rightView = rightViewTrue
        } else {
            telTF.rightView = rightViewFalse
        }
        
        if isEmailValid {
            emailTF.rightView = rightViewTrue
        } else {
            emailTF.rightView = rightViewFalse
        }
        collectionsTextField.forEach{ item in
            item.rightViewMode = .always
        }
    }
    
    @IBAction private func hideKeyboard() {
            view.endEditing(true)
        }
}

extension Tab3ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        guard let fullName = textField.text, !fullName.isEmpty else {
            return true
        }
        
        guard let telephone = textField.text, !telephone.isEmpty else {
            return true
        }
        
        guard let email = textField.text, !email.isEmpty else {
            return true
        }
        
        if textField == fullNameTF {
            if NAME_REGEX.matches(fullName) {
                isFullNameValid = true
            } else {
                isFullNameValid = false
            }
        }
        
        if textField == telTF {
            if TELEPHONE_REGEX.matches(telephone) {
                isTelephoneValid = true
            } else {
                isTelephoneValid = false
            }
        }
        
        if textField == emailTF {
            if EMAIL_REGEX.matches(email) {
                isEmailValid = true
            } else {
                isEmailValid = false
            }
        }
        
        if isFullNameValid && isEmailValid && isTelephoneValid {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
        
        return true
    }
    
    //когда пользователь нажал кнопку Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.fullNameTF {
            // переводим ввод на 2-е поле
            telTF.becomeFirstResponder()
        } else {
        //спрятать клавиатуру
        textField.resignFirstResponder()
        }
        return true
    }
}

/*
extension String {
    func isFullNameValid() -> Bool {
        let regEx = "^([A-Z][a-z]{2,}\\s[A-Z][a-z]{1,}\\s?([A-Z][a-z]{1,})?)"

        let fullNameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return fullNameTest.evaluate(with: self)
    }

    func isEmailValid() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailTest.evaluate(with: self)
    }
    
    func isTelNumberValid() -> Bool {
        let regEx = "^\\+?3?8?(0\\d{9})$"

        let telNumberTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return telNumberTest.evaluate(with: self)
    }

    func isPasswordValid() -> Bool {
        let regEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"

        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return passwordTest.evaluate(with: self)
    }
}
*/

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
