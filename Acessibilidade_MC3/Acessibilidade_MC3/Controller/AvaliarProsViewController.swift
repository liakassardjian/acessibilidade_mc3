//
//  AvaliarPros.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarProsViewController: UITableViewController {

    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var prosTextView: UITextView!
    @IBOutlet weak var contrasTextView: UITextView!
    @IBOutlet weak var sugestoesTextView: UITextView!
    
    @IBOutlet weak var recomendaUIButton: UIButton!
    @IBOutlet weak var naoRecomendaUIButton: UIButton!
    
    var recomendaEmpresa: Bool = true
    
    var avaliacao: Avaliacao?
    var empresa: Empresa?
    
    @IBAction func apertaRecomenda(_ sender: UIButton) {
        recomendaEmpresa = true
        recomendaUIButton.setImage(UIImage(named: "RecomendaTrue"), for: .normal)
        naoRecomendaUIButton.setImage(UIImage(named: "NaoRecomendaFalse"), for: .normal)
    }
    
    @IBAction func apertaNaoRecomenda(_ sender: UIButton) {
        recomendaEmpresa = false
        recomendaUIButton.setImage(UIImage(named: "RecomendaFalse"), for: .normal)
        naoRecomendaUIButton.setImage(UIImage(named: "NaoRecomendaTrue"), for: .normal)
    }
    
    var prosTextViewDelegate: TextViewController?
    var contrasTextViewDelegate: TextViewController?
    var sugestoesTextViewDelegate: TextViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ajustarUI()
        
        prosTextViewDelegate = TextViewController(placeholder: "Vantagens de se trabalhar nessa empresa")
        contrasTextViewDelegate = TextViewController(placeholder: "Desvantagens de se trabalhar nessa empresa")
        sugestoesTextViewDelegate = TextViewController(placeholder: "Sugestoes para melhorar essa empresa")
        
        prosTextView.delegate = prosTextViewDelegate
        contrasTextView.delegate = contrasTextViewDelegate
        sugestoesTextView.delegate = sugestoesTextViewDelegate
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = .brancoAzulado
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func ajustarUI() {
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .rioCristalino
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        avaliacao?.titulo = recuperaTextoTextField(textField: tituloTextField)
        avaliacao?.vantagens = recuperaTextoTextView(textView: prosTextView)
        avaliacao?.desvantagens = recuperaTextoTextView(textView: contrasTextView)
        
        if recuperaTextoTextView(textView: sugestoesTextView) != "" {
            avaliacao?.sugestoes = recuperaTextoTextView(textView: sugestoesTextView)
        }
        
        avaliacao?.recomendacao = self.recomendaEmpresa
        
    }
    
    private func recuperaTextoTextField(textField: UITextField) -> String {
        if let texto = textField.text {
            return texto
        }
        return ""
    }
    
    private func recuperaTextoTextView(textView: UITextView) -> String {
        if let texto = textView.text {
            return texto
        }
        return ""
    }
    
    @IBAction func tituloTextFieldDidChange(_ sender: Any) {
    }
    
    
    
}
