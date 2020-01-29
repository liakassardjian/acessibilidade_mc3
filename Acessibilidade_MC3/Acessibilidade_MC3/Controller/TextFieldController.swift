//
//  TextFieldController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
Classe que funciona como controlador para as Text Views da interface.

A classe herda de NSObject e UITextViewDelegate, sendo, assim, Delegate e Data Source de uma determinada Text View.
*/
class TextFieldController: NSObject, UITextFieldDelegate {
    
    /**
     Booleano que indica se o texto inserido pelo usuário é válido ou não.
     
     É inicializado como **false**.
     */
    var textoValido: Bool = false

    /**
     UI View Controller que instancia um objeto desta classe.
     */
    var view: UIView
    
    /**
     Booleano que indica se o campo de texto conterá um númeri de telefone ou não.
     */
    var telefone: Bool
    
    /**
     Inicializador da classe.
     
     - parameters:
        - view: UIView na qual está contido o campo de texto.
     */
    init(view: UIView, telefone: Bool) {
        self.view = view
        self.telefone = telefone
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
           nextField.becomeFirstResponder()
        } else {
           textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if telefone {
            var fullString = textField.text ?? ""
            fullString.append(string)
            if range.length == 1 {
                textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
            } else {
                textField.text = format(phoneNumber: fullString)
            }
            return false
        }
        return true
    }
    
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")

        if number.count > 11 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }

        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }

        if number.count < 8 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{2})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)

        } else if number.count < 11 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{2})(\\d{4})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{2})(\\d{5})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        }

        return number
    }
}
