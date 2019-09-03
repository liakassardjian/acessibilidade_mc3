//
//  AvaliacaoTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliacaoTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView! {
        didSet {
            self.cardView.layer.cornerRadius = 8
            self.cardView.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
            self.cardView.layer.shadowOpacity = 0.15
            self.cardView.layer.shadowRadius = 8
            self.cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var notaLabel: UILabel!
    @IBOutlet weak var barraProgressoView: BarraProgressoView!
    
    @IBOutlet weak var primeiraView: UIView!
    @IBOutlet weak var segundaView: UIView!
    @IBOutlet weak var terceiraView: UIView!
    @IBOutlet weak var quartaView: UIView!
    @IBOutlet weak var quintaView: UIView!
    
    @IBOutlet weak var primeiraImagem: UIImageView!
    @IBOutlet weak var segundaImagem: UIImageView!
    @IBOutlet weak var terceiraImagem: UIImageView!
    @IBOutlet weak var quartaImagem: UIImageView!
    @IBOutlet weak var quintaImagem: UIImageView!
    
    @IBOutlet weak var vantagensLabel: UILabel!
    @IBOutlet weak var desvantagensLabel: UILabel!
    @IBOutlet weak var sugestoesLabel: UILabel!
    @IBOutlet weak var sugestoesTituloLabel: UILabel!
    
    @IBOutlet weak var cargoLabel: UILabel!
    @IBOutlet weak var recomendaLabel: UILabel!
    @IBOutlet weak var recomendaImagem: UIImageView!
    
    var imagensAcessibilidade: [UIImageView]?
    var sombrasImagens: [UIView]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagensAcessibilidade = [primeiraImagem,
                                 segundaImagem,
                                 terceiraImagem,
                                 quartaImagem,
                                 quintaImagem]
        
        sombrasImagens = [primeiraView,
                          segundaView,
                          terceiraView,
                          quartaView,
                          quintaView]
        
        if let sombras = sombrasImagens {
            for sombra in sombras {
                sombra.clipsToBounds = false
                sombra.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
                sombra.layer.shadowOpacity = 0.15
                sombra.layer.shadowRadius = 8
                sombra.layer.shadowOffset = CGSize(width: 2, height: 2)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
