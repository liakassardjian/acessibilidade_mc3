//
//  PickerController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
 Classe que funciona como controlador para as Picker Views da interface.
 
 A classe herda de NSObject, UIPickerViewDelegate e UIPickerViewDataSource, sendo, assim, Delegate e Data Source de uma determinada Picker View.
 */
class PickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /**
     Lista de componentes a serem exibidos na Picker View.
     
     A lista de strings é inicializada quando um objeto desta classe é instanciado.
     */
    var componentes: [String]
    
    /**
     Item que é selecionado da Picker View.
     
     A string é inicializada como vazia quando um objeto desta classe é instanciado, mas recebe valor posteriormente.
     */
    var selecionado: String
    
    /**
     Inicializador da classe.
     
     - parameters:
        - componentes: Lista de strings que será exibida como opções da Picker View.
     */
    init(componentes: [String]) {
        self.componentes = componentes
        self.selecionado = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return componentes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return componentes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selecionado = componentes[row]
    }
}
