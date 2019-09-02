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
    @IBOutlet weak var prosTextField: UITextField!
    @IBOutlet weak var contrasTextField: UITextField!
    @IBOutlet weak var melhorarTextField: UITextField!
    
    @IBOutlet weak var recomendaUIButton: UIButton!
    @IBOutlet weak var naoRecomendaUIButton: UIButton!
    
    var recomendaEmpresa: Bool = true
    
    @IBAction func apertaRecomenda(_ sender: UIButton) {
        if recomendaEmpresa == false {
            recomendaEmpresa = true
            recomendaUIButton.setImage(UIImage(named: "RecomendaTrue"), for: .normal)
            naoRecomendaUIButton.setImage(UIImage(named: "NaoRecomendaFalse"), for: .normal)
        }
    }
    
    @IBAction func apertaNaoRecomenda(_ sender: UIButton) {
        if recomendaEmpresa == true {
            recomendaEmpresa = false
            recomendaUIButton.setImage(UIImage(named: "RecomendaFalse"), for: .normal)
            naoRecomendaUIButton.setImage(UIImage(named: "NaoRecomendaTrue"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ajustarUI()
    }
    
    func ajustarUI() {
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .rioCristalino
    }
}
