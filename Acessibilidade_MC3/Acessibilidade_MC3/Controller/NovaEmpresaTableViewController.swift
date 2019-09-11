//
//  NovaEmpresaTableViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 03/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class NovaEmpresaTableViewController: UITableViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var siteTextField: UITextField!
    @IBOutlet weak var cidadeTextField: UITextField!
    @IBOutlet weak var estadoPickerView: UIPickerView!
    
    var pickerViewDelegateDataSource: PickerController?
    
    weak var empresasViewController: EmpresasViewController?
    
    @IBOutlet weak var salvarButton: UIBarButtonItem!
    
    var empresa: Empresa?
    
    var nomeValido: Bool = false
    var cidadeValida: Bool = false
    
    let estadosBrasil = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO",
                         "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI",
                         "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerViewDelegateDataSource = PickerController(componentes: estadosBrasil)
        estadoPickerView.delegate = pickerViewDelegateDataSource
        estadoPickerView.dataSource = pickerViewDelegateDataSource
        
        empresa = Empresa()
        
        salvarButton.isEnabled = false
        
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = .brancoAzulado
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let nome = recuperaTextoTextField(textField: nomeTextField)
        let cidade = recuperaTextoTextField(textField: cidadeTextField)
        let estado = estadosBrasil[estadoPickerView.selectedRow(inComponent: 0)]
        let telefone = recuperaTextoTextField(textField: telefoneTextField)
        let site = recuperaTextoTextField(textField: siteTextField)
        
        let localizacao = "\(cidade), \(estado)"
        
        empresa?.nome = nome
        empresa?.localizacao = localizacao
        empresa?.cidade = cidade
        empresa?.estado = estado
        
        if telefone != ""{
            empresa?.telefone = telefone
        }
        
        if site != ""{
            empresa?.site = site
        }
        
        if let empresasVC = empresasViewController, let empresa = empresa {
            empresasVC.registraEmpresa(empresa: empresa)
            empresasVC.getEmpresas()
        }
    }
    
    private func recuperaTextoTextField(textField: UITextField) -> String {
        if let texto = textField.text {
            return texto
        }
        return ""
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            return
        }
        
        if textField == nomeTextField {
            if let texto = textField.text {
                if texto != "" {
                    nomeValido = true
                } else {
                    nomeValido = false
                }
            }
        } else {
            if let texto = textField.text {
                if texto != "" {
                    cidadeValida = true
                } else {
                    cidadeValida = false
                }
            }
        }
        
        salvarButton.isEnabled = nomeValido && cidadeValida
    }
}
