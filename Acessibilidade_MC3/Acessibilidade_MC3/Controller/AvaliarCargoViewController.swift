//
//  AvaliarCargo.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Classe que controla a primeira tela do formulário de avaliação da empresa.
 
 Nesta tela, o usuário descreve sua posição dentro da empresa, se é um funcionário atual ou ex-funcionário (neste último caso, indica seu último ano na empresa) e por quanto tempo trabalhou na empresa.
 - - -
 A classe herda de NSObject, UITableViewDataSource e UITableViewDelegate, sendo, assim, Delegate e Data Source de uma determinada Table View.

 */
class AvaliarCargoViewController: UITableViewController {
    
    /**
     Empresa que está sendo avaliada pelo usuário.
     */
    var empresa: Empresa?
    
    /**
     Lista de opções a serem exibidas na Picker View de tempo de serviço.
     */
    let tempoServico = ["Menos de 3 meses", "Menos de 1 ano", "1 a 5 anos", "5 a 10 anos", "Mais de 10 anos"]
    
    /**
    Lista de opções a serem exibidas na Picker View de último ano dentro da empresa.
    */
    let ultimoAno = ["2019", "2018", "2017", "2016", "2015 ou anteriormente"]
    
    /**
    Conector do campo de texto no qual o usuário descreve seu cargo dentro da empresa.
    */
    @IBOutlet weak var cargoTextField: UITextField!
    
    /**
    Conector do switch que indica se o usuário trabalha na empresa atualmente ou não.
    */
    @IBOutlet weak var funcionarioAtualmenteSwitch: UISwitch!
    
    /**
     Conector da Picker View na qual o usuário seleciona o ano em que foi desligado da empresa.
    */
    @IBOutlet weak var desligadoEmPickerView: UIPickerView!
    
    /**
     Conector da Picker View na qual o usuário indica por quanto tempo trabalhou na empresa.
    */
    @IBOutlet weak var trabalhouDurantePickerView: UIPickerView!
    
    /**
     Conector do botão que permite ao usuário avançar para a próxima tela.
    */
    @IBOutlet weak var proximoButton: UIBarButtonItem!
    
    /**
     Delegate e Data Source da Picker View na qual o usuário indica por quanto tempo trabalhou na empresa.
    */
    var trabalhouDelegateDataSource: PickerController?
    
    /**
     Delegate e Data Source da Picker View na qual o usuário seleciona o ano em que foi desligado da empresa.
    */
    var desligadoDelegateDataSource: PickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
   
        trabalhouDelegateDataSource = PickerController(componentes: self.tempoServico)
        desligadoDelegateDataSource = PickerController(componentes: self.ultimoAno)
        
        trabalhouDurantePickerView.dataSource = trabalhouDelegateDataSource
        trabalhouDurantePickerView.delegate = trabalhouDelegateDataSource
        
        desligadoEmPickerView.dataSource = desligadoDelegateDataSource
        desligadoEmPickerView.delegate = desligadoDelegateDataSource
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.proximoButton.isEnabled = false
        
    }

    /**
     Ação executada quando o usuário altera o valor do switch.
     
     - parameters:
        - sender: A transição executada quando o switch é tocado.
     
     A função exibe ou esconde a Picker View na qual o usuário seleciona o ano em que foi desligado da empresa.
     */
    @IBAction func switchAlterado(_ sender: Any) {
        self.tableView.reloadRows(at: .init(arrayLiteral: [1, 1]), with: .bottom)
        desligadoEmPickerView.reloadAllComponents()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0) {
            return 55
            
        } else if indexPath.section == 1 && indexPath.row > 0 {
            if !funcionarioAtualmenteSwitch.isOn {
                return 212
            }
            return 0
        }
        return 212
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = .brancoAzulado
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /**
    Ação executada quando o usuário seleciona o botão para cancelar sua avaliação.
    
    - parameters:
       - sender: A transição executada quando o botão é tocado.
    
    A função dá dismiss na tela atual.
    */
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
        
        avaliacao.posicao = recuperaTextoTextField(textField: cargoTextField)
        avaliacao.tempoServico = tempoServico[trabalhouDurantePickerView.selectedRow(inComponent: 0)]
        
        if let avaliarNotas = segue.destination as? AvaliarNotasViewController {
            avaliarNotas.avaliacao = avaliacao
            avaliarNotas.empresa = self.empresa
        }
    }
    
    /**
     Função privada que retorna o texto contido em um campo de texto.
     
     - parameters:
        - textField: O UITextField do qual deseja-se obter o texto.
     
     - returns: Uma string contendo o texto inserido no campo de texto. Se o texto for vazio ou não for possível obtê-lo, a função retorna uma string vazia.
     */
    private func recuperaTextoTextField(textField: UITextField) -> String {
        if let texto = textField.text {
            return texto
        }
        return ""
    }
    
    /**
     Ação executada quando o campo de texto do cargo do usuário sofre alteração.
     
     - parameters:
        - sender: A transição executada quando o usuário altera o texto do campo.
     
     A função verifica se o valor do campo de texto é válido para, então, disponibilizar o botão `proximoButton` para que o usuário avance para a próxima tela.
     */
    @IBAction func cargoTextFieldDidChange(_ sender: Any) {
        if recuperaTextoTextField(textField: cargoTextField) != "" {
            proximoButton.isEnabled = true
        } else {
            proximoButton.isEnabled = false
        }
    }
    
}
