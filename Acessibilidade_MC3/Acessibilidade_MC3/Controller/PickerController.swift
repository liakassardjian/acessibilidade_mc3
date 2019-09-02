//
//  PickerController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class PickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var componentes: [String]
    var selecionado: String
    
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
