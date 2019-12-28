//
//  TextViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 03/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
Classe que funciona como controlador para as Text Views da interface.

A classe herda de NSObject e UITextViewDelegate, sendo, assim, Delegate e Data Source de uma determinada Text View.
*/
class TextViewController: NSObject, UITextViewDelegate {
    
    /**
     Texto exibido quando não há entrada do usuário.
     */
    var placeholder: String
    
    /**
     Índice de uma Text View em uma mesma tela.
     */
    var indice: Int
    
    /**
     Booleano que indica se o texto inserido pelo usuário é válido ou não.
     
     É inicializado como **false**.
     */
    var textoValido: Bool = false

    /**
     Table View Controller que instancia um objeto desta classe.
     */
    weak var tableViewController: UITableViewController?
    
    /**
     Inicializador da classe.
     
     - parameters:
        - placeholder: Texto que será exibido quando não houver entrada do usuário.
        - tVC: Table View Controller que instancia o objeto que está sendo inicializado.
        - indice: Inteiro que representa o índice de uma Text View em uma mesma tela.
     */
    init(placeholder: String, tVC: UITableViewController, indice: Int) {
        self.placeholder = placeholder
        self.tableViewController = tVC
        self.indice = indice
    }
    
    /**
     Função que é chamada quando o usuário começa a inserir novo texto na Text View.
     
     - parameters:
        - textView: A Text View que está sendo editada.
     */
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = .escuroAzulado
        }
    }
    
    /**
    Função que é chamada quando o usuário termina de editar o texto na Text View.
    
    - parameters:
       - textView: A Text View que estava sendo editada.
    */
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
 
    /**
    Função que é chamada quando o usuário altera o texto na Text View.
    
    - parameters:
       - textView: A Text View que estava sendo editada.
    */
    func textViewDidChange(_ textView: UITextView) {
        if let texto = textView.text {
            if texto != "" {
                textoValido = true
                
            } else {
                textoValido = false
            }
            
            if let tVC = tableViewController as? AvaliarProsViewController {
                tVC.textosValidos[indice] = textoValido
                tVC.validaTexto()
            }
            
        }
    }
    
}
