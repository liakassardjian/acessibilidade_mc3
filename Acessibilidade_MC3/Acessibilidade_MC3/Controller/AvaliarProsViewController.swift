//
//  AvaliarPros.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Classe que controla a quarta tela do formulário de avaliação da empresa.

 Nesta tela, o usuário insere título e descreve prós, contras e sugestões. Também recomenda ou não a empresa para outros usuários.
 - - -
 A classe herda de UITableViewController.
 */
class AvaliarProsViewController: UITableViewController {

    /**
     Conector correspondente ao campo de texto no qual será inserido o título da avaliação.
     */
    @IBOutlet weak var tituloTextField: UITextField!
    
    /**
     Conector correspondente ao campo de texto no qual serão inseridos os prós.
    */
    @IBOutlet weak var prosTextView: UITextView!
    
    /**
     Conector correspondente ao campo de texto no qual serão inseridos os contras.
    */
    @IBOutlet weak var contrasTextView: UITextView!
    
    /**
     Conector correspondente ao campo de texto no qual serão inseridas as sugestões.
    */
    @IBOutlet weak var sugestoesTextView: UITextView!
    
    /**
     Conector correspondente ao botão em que o usuário recomenda a empresa.
     */
    @IBOutlet weak var recomendaUIButton: UIButton!
    
    /**
     Conector correspondente ao botão em que o usuário **não** recomenda a empresa.
    */
    @IBOutlet weak var naoRecomendaUIButton: UIButton!
    
    /**
     Conector correspondente ao botão em que o usuário salva sua avaliação.
    */
    @IBOutlet weak var salvarButton: UIBarButtonItem!
    
    /**
     Booleano que indica se a empresa é recomendada pelo usuário ou não.
     
     Inicializado como **true**.
     */
    var recomendaEmpresa: Bool = true
    
    /**
     Vetor de booleanos que indicam se os campos de texto preenchidos pelo usuário são válidos ou não.
     
     Por padrão, os três primeiros (título, prós e contras) não são válidos. Apenas o campo de sugestões é valido desde o princípio, uma vez que sugestões são opcionais.
     */
    var textosValidos: [Bool] = [false, false, false, true] 
    
    /**
     A avaliação que está sendo criada pelo usuário no momento.
    */
    var avaliacao: Avaliacao?
    
    /**
     A empresa que está sendo avaliada.
    */
    var empresa: Empresa?
    
    /**
     Ação executada quando um usuário seleciona o botão para recomendar a empresa.
     
     - parameters:
        - sender: Botão clicado pelo usuário.
     */
    @IBAction func apertaRecomenda(_ sender: UIButton) {
        recomendaEmpresa = true
        recomendaUIButton.setImage(UIImage(named: "RecomendaTrue"), for: .normal)
        naoRecomendaUIButton.setImage(UIImage(named: "NaoRecomendaFalse"), for: .normal)
    }
    
    /**
     Ação executada quando um usuário seleciona o botão para **não** recomendar a empresa.
    
     - parameters:
       - sender: Botão clicado pelo usuário.
    */
    @IBAction func apertaNaoRecomenda(_ sender: UIButton) {
        recomendaEmpresa = false
        recomendaUIButton.setImage(UIImage(named: "RecomendaFalse"), for: .normal)
        naoRecomendaUIButton.setImage(UIImage(named: "NaoRecomendaTrue"), for: .normal)
    }
    
    /**
     Delegate da Text View na qual o usuário descreve os prós da empresa.
     */
    var prosTextViewDelegate: TextViewController?
    
    /**
     Delegate da Text View na qual o usuário descreve os contras da empresa.
    */
    var contrasTextViewDelegate: TextViewController?
    
    /**
     Delegate da Text View na qual o usuário descreve sugestões para a empresa.
    */
    var sugestoesTextViewDelegate: TextViewController?
    
    /**
     Delegate dos campos de texto dessa tela.
     */
    var textFieldDelegate: TextFieldController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        prosTextViewDelegate = TextViewController(placeholder: "Vantagens de se trabalhar nessa empresa", tVC: self, indice: 1)
        contrasTextViewDelegate = TextViewController(placeholder: "Desvantagens de se trabalhar nessa empresa", tVC: self, indice: 2)
        sugestoesTextViewDelegate = TextViewController(placeholder: "Sugestões para melhorar essa empresa", tVC: self, indice: 3)
        
        prosTextView.delegate = prosTextViewDelegate
        contrasTextView.delegate = contrasTextViewDelegate
        sugestoesTextView.delegate = sugestoesTextViewDelegate
        
        textFieldDelegate = TextFieldController(view: self.view, telefone: false)
        tituloTextField.delegate = textFieldDelegate
        
        salvarButton.isEnabled = false
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
        avaliacao?.titulo = recuperaTextoTextField(textField: tituloTextField)
        avaliacao?.vantagens = recuperaTextoTextView(textView: prosTextView)
        avaliacao?.desvantagens = recuperaTextoTextView(textView: contrasTextView)
        
        if recuperaTextoTextView(textView: sugestoesTextView) != "Sugestões para melhorar essa empresa" {
            avaliacao?.sugestoes = recuperaTextoTextView(textView: sugestoesTextView)
        }
        
        avaliacao?.recomendacao = self.recomendaEmpresa
        
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
     Função privada que retorna o texto contido em um campo de texto de múltiplas linhas.
    
     - parameters:
       - textView: O `UITextView` do qual deseja-se obter o texto.
    
     - returns: Uma string contendo o texto inserido no campo de texto. Se o texto for vazio ou não for possível obtê-lo, a função retorna uma string vazia.
    */
    private func recuperaTextoTextView(textView: UITextView) -> String {
        if let texto = textView.text {
            return texto
        }
        return ""
    }
    
    /**
     Ação executada quando o campo de texto do título sofre alteração.
    
     - parameters:
       - sender: A transição executada quando o usuário altera o texto do campo.
    
     A função verifica se o valor do campo de texto é válido.
    */
    @IBAction func tituloTextFieldDidChange(_ sender: Any) {
        if let titulo = tituloTextField.text {
            if titulo != "" {
                textosValidos[0] = true
            } else {
                textosValidos[0] = false
            }
            
            validaTexto()
        }
    }
    
    /**
     Função que verifica se os textos inseridos pelo usuário são válido ou não.
     
     Se os textos forem válidos, a função disponibiliza o botão de salvar.
     */
    public func validaTexto() {
        var desbloqueiaBotao: Bool = true
        for valido in textosValidos {
            if !valido && valido != textosValidos.last {
                desbloqueiaBotao = false
            }
        }
        salvarButton.isEnabled = desbloqueiaBotao
    }
    
}
