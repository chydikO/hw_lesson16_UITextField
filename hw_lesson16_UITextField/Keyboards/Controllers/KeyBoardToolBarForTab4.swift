//
//  KeyBoardToolBarForTab4.swift
//  hw_lesson16_UITextField
//
//  Created by Олег Чудновский on 01.04.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class KeyBoardToolBarForTab4: UIStackView {
    
    @IBOutlet private weak var nuberPad1: UIButton!
    @IBOutlet private weak var nuberPad2: UIButton!
    @IBOutlet private weak var nuberPad3: UIButton!
    @IBOutlet private weak var nuberPad4: UIButton!
    @IBOutlet private weak var nuberPad5: UIButton!
    @IBOutlet private weak var nuberPad6: UIButton!
    @IBOutlet private weak var nuberPad7: UIButton!
    @IBOutlet private weak var nuberPad8: UIButton!
    @IBOutlet private weak var nuberPad9: UIButton!
    @IBOutlet private weak var nuberPad0: UIButton!
    @IBOutlet weak var donePad: UIButton!
    @IBOutlet private weak var bsPad: UIButton!

    
    private var numbersPad : [UIButton]!
    
    private var arrayOfNumber = [Int]()
    
    var onDoneButtonClicked: (() -> ())?
    var onDeleteButtonClicked: (() -> ())?
    var onNumberPadButtonClicked: ((String) -> ())?


    static func create() -> KeyBoardToolBarForTab4 {
        return Bundle.main.loadNibNamed("KeyBoardToolBarForTab4XIB", owner: nil, options: nil)?.first as? KeyBoardToolBarForTab4 ?? KeyBoardToolBarForTab4()
    }
    
    override func awakeFromNib() {
        arrayOfNumber = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        setBtnLabelsInArray()
        shuffleArrayOfNumbers()
        setBtnLabelsText()
        
        donePad.layer.borderColor = UIColor.white.cgColor

    }


    func shuffleArrayOfNumbers() {
        var index = 0
        for i in 0..<arrayOfNumber.count {
            /*
             числа с индексами от 0 до i-1 уже были выбраны (они перемещены в начало массива), поэтому сейчас мы
             выбираем случайное число с индексом, больше или равным i
             */
            index = Int(arc4random_uniform(UInt32(arrayOfNumber.count - i))) + i
            let temp = arrayOfNumber[i]
            arrayOfNumber[i] = arrayOfNumber[index]
            arrayOfNumber[index] = temp
        }
    }
    
    func setBtnLabelsText() {
        var index = 0
        numbersPad.forEach { item in
            item.setTitle(String(arrayOfNumber[index]), for: .normal)
            index += 1
        }
    }
    
    private func setBtnLabelsInArray() {
        numbersPad = [nuberPad1,
                      nuberPad2,
                      nuberPad3,
                      nuberPad4,
                      nuberPad5,
                      nuberPad6,
                      nuberPad7,
                      nuberPad8,
                      nuberPad9,
                      nuberPad0]
        
        numbersPad.forEach(){ button in
            setBorderToBtn(button)
        }
        
        donePad.isEnabled = false
        setBorderToBtn(donePad)
        setBorderToBtn(bsPad)
    }
    
    private func setBorderToBtn(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor =  UIColor.black.cgColor
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true

    }
    
    @IBAction private func numberPudBtnCliked(_ sender: UIButton) {
        guard let numberPad = sender.titleLabel?.text else {
            return
        }
        onNumberPadButtonClicked?(numberPad)
    }
    
    @IBAction private func enterBtnClicked(_ sender: UIButton) {
        onDoneButtonClicked?()
    }
    
    
    @IBAction private func deleteBtnClicked(_ sender: UIButton) {
        onDeleteButtonClicked?()
    }
    
}
