//
//  KeyBoardToolBarForTab4.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 01.04.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class KeyBoardToolBarForTab4: UIStackView {
    
    private var arrauOfNumber = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    static func create() -> KeyBoardToolBarForTab4 {
        return Bundle.main.loadNibNamed("KeyBoardToolBarForTab4XIB", owner: nil, options: nil)?.first as? KeyBoardToolBarForTab4 ?? KeyBoardToolBarForTab4()
    }

    
    
    private func shuffleArray() {
        var index = 0
        for i in 0..<arrauOfNumber.count {
            /*
             числа с индексами от 0 до i-1 уже были выбраны (они перемещены в начало массива), поэтому сейчас мы
             выбираем случайное число с индексом, больше или равным i
             */
            index = Int(arc4random_uniform(UInt32(arrauOfNumber.count - i))) + i
            let temp = arrauOfNumber[i]
            arrauOfNumber[i] = arrauOfNumber[index]
            arrauOfNumber[index] = temp
        }
    }
}
