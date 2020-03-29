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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    @IBAction private func hideKeyboard() {
        view.endEditing(true)
    }
}
