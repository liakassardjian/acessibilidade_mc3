//
//  AvaliarNotas.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarNotasViewController: UITableViewController {
    
    var avaliacao: Avaliacao?
    var empresa: Empresa?
    
    @IBOutlet var integracaoBotoes: [UIButton]!
    @IBOutlet var integracaoImagens: [UIImageView]!
    var notaIntegracao: Float = 0
    
    @IBOutlet var culturaBotoes: [UIButton]!
    @IBOutlet var culturaImagens: [UIImageView]!
    var notaCultura: Float = 0
    
    @IBOutlet var remuneracaoBotoes: [UIButton]!
    @IBOutlet var remuneracaoImagens: [UIImageView]!
    var notaRemuneracao: Float = 0
    
    @IBOutlet var oportunidadeBotoes: [UIButton]!
    @IBOutlet var oportunidadeImagens: [UIImageView]!
    var notaOportunidade: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        integracaoBotoes.sort(by: { $0.tag < $1.tag })
        integracaoImagens.sort(by: { $0.tag < $1.tag })
        
        culturaBotoes.sort(by: { $0.tag < $1.tag })
        culturaImagens.sort(by: { $0.tag < $1.tag })
        
        remuneracaoBotoes.sort(by: { $0.tag < $1.tag })
        remuneracaoImagens.sort(by: { $0.tag < $1.tag })
        
        oportunidadeBotoes.sort(by: { $0.tag < $1.tag })
        oportunidadeImagens.sort(by: { $0.tag < $1.tag })
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = .brancoAzulado
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    @IBAction func tocaIntegracao(_ sender: UIButton) {
        notaIntegracao = apertaBotao(botoes: integracaoBotoes, imagens: integracaoImagens, sender: sender)
    }
    
    @IBAction func tocaCultura(_ sender: UIButton) {
        notaCultura = apertaBotao(botoes: culturaBotoes, imagens: culturaImagens, sender: sender)
    }
    
    @IBAction func tocaRemuneracao(_ sender: UIButton) {
        notaRemuneracao = apertaBotao(botoes: remuneracaoBotoes, imagens: remuneracaoImagens, sender: sender)
    }
    
    @IBAction func tocaOportunidade(_ sender: UIButton) {
        notaOportunidade = apertaBotao(botoes: oportunidadeBotoes, imagens: oportunidadeImagens, sender: sender)
    }
    
    func apertaBotao(botoes: [UIButton], imagens: [UIImageView], sender: UIButton) -> Float {
        for i in 0..<botoes.count {
            if botoes[i].tag <= sender.tag {
                imagens[i].image = UIImage(named: "GoldenStar")
            } else {
                imagens[i].image = UIImage(named: "Star")
            }
        }
        return Float(sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        avaliacao?.nota = media(valores: [notaIntegracao, notaCultura, notaRemuneracao, notaOportunidade])
        avaliacao?.integracao = Int(notaIntegracao)
        avaliacao?.cultura = Int(notaCultura)
        avaliacao?.remuneracao = Int(notaRemuneracao)
        avaliacao?.oportunidade = Int(notaOportunidade)
        
        if let avaliarEmpresa = segue.destination as? AvaliarDeficienciasViewController {
            avaliarEmpresa.avaliacao = self.avaliacao
            avaliarEmpresa.empresa = self.empresa
        }
    }
    
    private func media(valores: [Float]) -> Float {
        var media: Float = 0
        
        for elemento in valores {
            media += elemento
        }
        media /= Float(valores.count)
        
        return media
    }
}
