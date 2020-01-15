//
//  EmpresaTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Representação visual das células exibidas na primeira tela, contendo as informações gerais das empresas do catálogo.
 
 A classe herda de `UITableViewCell`.
 */
class EmpresaTableViewCell: UITableViewCell {

    /**
     Conector da Label na qual é exibido o nome da empresa.
     */
    @IBOutlet weak var nomeEmpresaLabel: UILabel!
    
    /**
     Conector da Label na qual é exibida a localização da empresa.
    */
    @IBOutlet weak var localizacaoEmpresaLabel: UILabel!
    
    /**
     Conector da Label na qual é exibida a nota da empresa.
    */
    @IBOutlet weak var notaLabel: UILabel!
    
    /**
     Conector da Label na qual é exibida a porcentagem de recomendação da empresa.
    */
    @IBOutlet weak var recomendacaoLabel: UILabel!
    
    /**
     Conector da barra de progresso utilizada para representar a quantidade de estrelas correspondente à nota dada.
    */
    @IBOutlet weak var barraProgressoView: BarraProgressoView!
    
    /**
     Conector do card que contém a nota da empresa.
     */
    @IBOutlet weak var avaliacaoCard: UIView! {
        didSet {
            self.avaliacaoCard.layer.cornerRadius  = 8
            self.avaliacaoCard.layer.shadowOpacity = 0.15
            self.avaliacaoCard.layer.shadowRadius = 8
            self.avaliacaoCard.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.avaliacaoCard.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
        }
    }
    
    /**
     Conector do card que contém a porcentagem de recomendação da empresa.
     */
    @IBOutlet weak var recomendacaoCard: UIView! {
        didSet {
            self.recomendacaoCard.layer.cornerRadius  = 8
            self.recomendacaoCard.layer.shadowOpacity = 0.15
            self.recomendacaoCard.layer.shadowRadius = 8
            self.recomendacaoCard.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.recomendacaoCard.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
        }
    }
    
    /**
     Conector do conjunto de views que contém as imagens de acessibilidade.
     */
    @IBOutlet var simbolosViews: [UIView]!
    
    /**
     Conector do conjunto de imagens de acessibilidade.
     */
    @IBOutlet var acessibilidades: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

        // Configure the view for the selected state
    }

}
