//
//  AvaliarCargo.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarCargoViewController: UITableViewController {
    
    var empresa: Empresa?
    
    let tempoServico = ["Menos de 3 meses", "Menos de 1 ano", "1 a 5 anos", "5 a 10 anos", "Mais de 10 anos"]
    let ultimoAno = ["2019", "2018", "2017", "2016", "2015 ou anteriormente"]
    
    @IBOutlet weak var cargoTextField: UITextField!
    @IBOutlet weak var funcionarioAtualmenteSwitch: UISwitch!
    @IBOutlet weak var desligadoEmPickerView: UIPickerView!
    @IBOutlet weak var trabalhouDurantePickerView: UIPickerView!

    var trabalhouDelegateDataSource: PickerController?
    var desligadoDelegateDataSource: PickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ajustarUI()
   
        trabalhouDelegateDataSource = PickerController(componentes: self.tempoServico)
        desligadoDelegateDataSource = PickerController(componentes: self.ultimoAno)
        
        trabalhouDurantePickerView.dataSource = trabalhouDelegateDataSource
        trabalhouDurantePickerView.delegate = trabalhouDelegateDataSource
        
        desligadoEmPickerView.dataSource = desligadoDelegateDataSource
        desligadoEmPickerView.delegate = desligadoDelegateDataSource
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
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
    
    @IBAction func cancelaAvaliacao(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let avaliacao = Avaliacao()
        
        if funcionarioAtualmenteSwitch.isOn {
            avaliacao.cargo = .atual
        } else {
            avaliacao.cargo = .exFunc
            
            switch desligadoEmPickerView.selectedRow(inComponent: 0) {
            case 0:
                avaliacao.ultimoAno = 2019
            case 1:
                avaliacao.ultimoAno = 2018
            case 2:
                avaliacao.ultimoAno = 2017
            case 3:
                avaliacao.ultimoAno = 2016
            case 4:
                avaliacao.ultimoAno = 2015
            default:
                avaliacao.ultimoAno = 2019
            }
        }

        avaliacao.tempoServico = tempoServico[trabalhouDurantePickerView.selectedRow(inComponent: 0)]
        
        if let avaliarNotas = segue.destination as? AvaliarNotasViewController {
            avaliarNotas.avaliacao = avaliacao
            avaliarNotas.empresa = self.empresa
        }
    }
    
}
