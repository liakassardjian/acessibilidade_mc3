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
     Inicializador da classe.
     
     - parameters:
        - view: UIView na qual está contido o campo de texto.
     */
    init(view: UIView) {
        self.view = view
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
           nextField.becomeFirstResponder()
        } else {
           textField.resignFirstResponder()
        }
        return true
    }
    
}
