//
//  EmpresaTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class EmpresaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var celulaEmpresa: UIView!
    
    @IBOutlet weak var nomeEmpresaLabel: UILabel!
    @IBOutlet weak var localizacaoEmpresaLabel: UILabel!
    @IBOutlet weak var notaLabel: UILabel!
    @IBOutlet weak var recomendacaoLabel: UILabel!
    @IBOutlet weak var barraProgressoView: BarraProgressoView!
    
    @IBOutlet weak var avaliacaoCard: UIView! {
        didSet {
            self.avaliacaoCard.layer.cornerRadius  = 8
            self.avaliacaoCard.layer.shadowOpacity = 0.15
            self.avaliacaoCard.layer.shadowRadius = 8
            self.avaliacaoCard.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.avaliacaoCard.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
        }
    }
    
    @IBOutlet weak var recomendacaoCard: UIView! {
        didSet {
            self.recomendacaoCard.layer.cornerRadius  = 8
            self.recomendacaoCard.layer.shadowOpacity = 0.15
            self.recomendacaoCard.layer.shadowRadius = 8
            self.recomendacaoCard.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.recomendacaoCard.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
        }
    }
    
    @IBOutlet var simbolosViews: [UIView]!
    @IBOutlet var acessibilidades: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //acessibilidade settings
        celulaEmpresa.isAccessibilityElement = true
        celulaEmpresa.accessibilityValue = "Card da empresa com informações"
        celulaEmpresa.accessibilityHint = "Clique no card duas vezes para acessar a empresa"
        
        nomeEmpresaLabel.isAccessibilityElement =  true
        nomeEmpresaLabel.accessibilityHint = "nome da empresa"
        
        localizacaoEmpresaLabel.isAccessibilityElement = true
        localizacaoEmpresaLabel.accessibilityHint = "cidade e estado da empresa"
        
        notaLabel.isAccessibilityElement = true
        notaLabel.accessibilityValue = "de 5"
        notaLabel.accessibilityHint = "nota da empresa"
        
        recomendacaoLabel.isAccessibilityElement = true
        recomendacaoLabel.accessibilityValue = " dos funcionários recomendam"
        recomendacaoLabel.accessibilityHint = "recomendação da empresa em porcentagem"
        
        if let acessibilidadesDescricao = acessibilidades {
            for acessibilidade in acessibilidadesDescricao {
                acessibilidade.isAccessibilityElement = true
                acessibilidade.accessibilityHint = "Acessibilidade disponível"
            }
        }
        
        if let simbolos = simbolosViews {
            for simbolo in simbolos {
                simbolo.clipsToBounds = false
                simbolo.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
                simbolo.layer.shadowOpacity = 0.15
                simbolo.layer.shadowRadius = 8
                simbolo.layer.shadowOffset = CGSize(width: 2, height: 2)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
