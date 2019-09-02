//
//  AvaliarNotas.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarNotasViewController: UITableViewController {
    
    @IBOutlet var integracaoBotoes: [UIButton]!
    var notaIntegracao: Int = 0
    
    @IBOutlet var culturaBotoes: [UIButton]!
    var notaCultura: Int = 0
    
    @IBOutlet var remuneracaoBotoes: [UIButton]!
    var notaRemuneracao: Int = 0
    
    @IBOutlet var oportunidadeBotoes: [UIButton]!
    var notaOportunidade: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ajustarUI()
       
    }
    func ajustarUI() {
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .rioCristalino
        
    }
    
    @IBAction func tocaIntegracao(_ sender: UIButton) {
        notaIntegracao = apertaBotao(conjuntoDeBotoes: integracaoBotoes, sender: sender)
    }
    
    @IBAction func tocaCultura(_ sender: UIButton) {
        notaCultura = apertaBotao(conjuntoDeBotoes: culturaBotoes, sender: sender)
    }
    
    @IBAction func tocaRemuneracao(_ sender: UIButton) {
        notaRemuneracao = apertaBotao(conjuntoDeBotoes: remuneracaoBotoes, sender: sender)
    }
    
    @IBAction func tocaOportunidade(_ sender: UIButton) {
        notaOportunidade = apertaBotao(conjuntoDeBotoes: oportunidadeBotoes, sender: sender)
    }
    
    func apertaBotao(conjuntoDeBotoes: [UIButton], sender: UIButton) -> Int {
        for button in conjuntoDeBotoes {
            if button.tag <= sender.tag {
                button.setImage(UIImage(named: "GoldenStar"), for: .normal)
            } else {
                button.setImage(UIImage(named: "Star"), for: .normal)
            }
        }
        return sender.tag
    }

}
