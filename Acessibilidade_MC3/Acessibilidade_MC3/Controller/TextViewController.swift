//
//  TextViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 03/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class TextViewController: NSObject, UITextViewDelegate {
    
    var placeholder: String?
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = .escuroAzulado
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let texto = textView.text {
//            if let titulo = tituloTextField.text {
//                validaTexto(titulo: titulo, corpo: corpo)
//            }
//        } else {
//            salvarButton.isEnabled = false
        }
    }
}
