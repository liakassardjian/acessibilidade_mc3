//
//  EmpresaTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class EmpresaTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeEmpresaLabel: UILabel!
    @IBOutlet weak var localizacaoEmpresaLabel: UILabel!
    @IBOutlet weak var notaLabel: UILabel!
    @IBOutlet weak var recomendacaoLabel: UILabel!
    
    @IBOutlet weak var primeiraAcessibilidade: UIImageView! {
        didSet {
            self.primeiraAcessibilidade.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var segundaAcessibilidade: UIImageView! {
        didSet {
            self.segundaAcessibilidade.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var terceiraAcessibilidade: UIImageView! {
        didSet {
            self.terceiraAcessibilidade.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var quartaAcessibilidade: UIImageView! {
        didSet {
            self.quartaAcessibilidade.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var quitaAcessibilidade: UIImageView! {
        didSet {
            self.quitaAcessibilidade.layer.cornerRadius = 8
        }
    }
    
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
    
    var acessibilidades: [UIImageView]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        acessibilidades = [self.primeiraAcessibilidade,
                           self.segundaAcessibilidade,
                           self.terceiraAcessibilidade,
                           self.quartaAcessibilidade,
                           self.quitaAcessibilidade]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
