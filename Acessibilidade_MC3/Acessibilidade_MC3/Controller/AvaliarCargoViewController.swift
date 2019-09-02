//
//  AvaliarCargo.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarCargoViewController: UITableViewController {
    @IBOutlet weak var cargoTextField: UITextField!
    @IBOutlet weak var funcionarioAtualmenteSwitch: UISwitch!
    @IBOutlet weak var desligadoEmPickerView: UIPickerView!
    @IBOutlet weak var trabalhouDurantePickerView: UIPickerView!

    let trabalhouDelegateDataSource = PickerController(componentes: ["Menos de 3 meses",
                                                                            "Menos de 1 ano",
                                                                            "1 a 5 anos",
                                                                            "5 a 10 anos",
                                                                            "Mais de 10 anos"])
    let desligadoDelegateDataSource = PickerController(componentes: ["2019",
                                                                       "2018",
                                                                       "2017",
                                                                       "2016",
                                                                       "2015 ou anteriormente"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ajustarUI()
   
        trabalhouDurantePickerView.dataSource = trabalhouDelegateDataSource
        trabalhouDurantePickerView.delegate = trabalhouDelegateDataSource
        
        desligadoEmPickerView.dataSource = desligadoDelegateDataSource
        desligadoEmPickerView.delegate = desligadoDelegateDataSource
        
    }
    
    func ajustarUI() {
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .rioCristalino

    }

    @IBAction func switchAlterado(_ sender: Any) {
        self.tableView.reloadRows(at: .init(arrayLiteral: [0, 4]), with: .bottom)
        desligadoEmPickerView.reloadAllComponents()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 55
        } else if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 {
            return 55
        } else if indexPath.row == 6 {
            return 212
        } else if indexPath.row == 4 && !funcionarioAtualmenteSwitch.isOn {
            return 212
        } else {
            return 0
        }
    }
}
