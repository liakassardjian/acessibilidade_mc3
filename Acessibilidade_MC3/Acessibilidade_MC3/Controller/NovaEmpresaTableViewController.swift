//
//  NovaEmpresaTableViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 03/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Classe que controla o formulário no qual o usuário solicita a criação de uma nova empresa.
 
 A classe herda de UITableViewController, sendo, assim, Delegate e Data Source de uma determinada Table View.
 */
class NovaEmpresaTableViewController: UITableViewController {

    /**
     Conector do campo de texto no qual o usuário insere o nome da empresa.
     */
    @IBOutlet weak var nomeTextField: UITextField!
    
    /**
     Conector do campo de texto no qual o usuário insere o telefone da empresa.
    */
    @IBOutlet weak var telefoneTextField: UITextField!
    
    /**
     Conector do campo de texto no qual o usuário insere o endereço do website da empresa.
    */
    @IBOutlet weak var siteTextField: UITextField!
    
    /**
     Conector do campo de texto no qual o usuário insere a cidade onde a empresa está localizada.
    */
    @IBOutlet weak var cidadeTextField: UITextField!
    
    /**
     Conector da Picker View na qual o usuário seleciona o estado onde a empresa está localizada.
    */
    @IBOutlet weak var estadoPickerView: UIPickerView!
    
    /**
     Delegate e Data Source da Picker View `estadoPickerView`.
     */
    var pickerViewDelegateDataSource: PickerController?
    
    /**
     Delegate dos campos de texto dessa tela, exceto o campo de texto de telefone.
     */
    var textFieldDelegate: TextFieldController?
    
    /**
     Delegate do campo de texto de telefone.
     */
    var telefoneTextFieldDelegate: TextFieldController?
    
    /**
     View Controller da tela que lista todas as empresas do sistema.
     */
    weak var empresasViewController: EmpresasViewController?
    
    /**
     Conector do botão que permite salvar uma nova empresa.
     */
    @IBOutlet weak var salvarButton: UIBarButtonItem!
    
    /**
     Nova empresa que será criada.
     */
    var empresa: Empresa?
    
    /**
     Booleano que indica se o nome inserido pelo usuário é válido ou não.
     */
    var nomeValido: Bool = false
    
    /**
     Booleano que indica se a cidade inserida pelo usuário é válida ou não.
    */
    var cidadeValida: Bool = false
    
    /**
     Lista de estados brasileiros que é exibida na Picker View.
    */
    let estadosBrasil = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO",
                         "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI",
                         "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerViewDelegateDataSource = PickerController(componentes: estadosBrasil)
        estadoPickerView.delegate = pickerViewDelegateDataSource
        estadoPickerView.dataSource = pickerViewDelegateDataSource
        
        salvarButton.isEnabled = false
        
        textFieldDelegate = TextFieldController(view: self.view, telefone: false)
        nomeTextField.delegate = textFieldDelegate
        siteTextField.delegate = textFieldDelegate
        cidadeTextField.delegate = textFieldDelegate
        
        telefoneTextFieldDelegate = TextFieldController(view: self.view, telefone: true)
        telefoneTextField.delegate = telefoneTextFieldDelegate
        
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
        
        empresa = Empresa()
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
        
        if let empresasVC = empresasViewController,
            let empresa = empresa,
            empresasVC.empresaAdicionada {
                empresasVC.registraEmpresa(empresa: empresa)
                empresasVC.getEmpresas()
        }
    }
    
    /**
     Função privada que retorna o texto contido em um campo de texto de linha única.
    
     - parameters:
       - textField: O `UITextField` do qual deseja-se obter o texto.
    
     - returns: Uma string contendo o texto inserido no campo de texto. Se o texto for vazio ou não for possível obtê-lo, a função retorna uma string vazia.
    */
    private func recuperaTextoTextField(textField: UITextField) -> String {
        if let texto = textField.text {
            return texto
        }
        return ""
    }
    
    /**
     Ação executada quando o campo de texto sofre alteração.
    
     - parameters:
       - sender: A transição executada quando o usuário altera o texto do campo.
    
     A função verifica se o valor do campo de texto é válido para habilitar o botão de salvar ou não.
    */
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
