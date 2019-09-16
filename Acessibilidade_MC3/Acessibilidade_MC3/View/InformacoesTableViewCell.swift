//
//  InformacoesTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class InformacoesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var localizacaoLabel: UILabel!
    @IBOutlet weak var localizacaoAcessivelLabel: UILabel!
    
    @IBOutlet weak var localizacaoView: UIView!
    
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var siteAcessivelLabel: UILabel!
    
    @IBOutlet weak var siteView: UIView!
    
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var telefoneAcessivelLabel: UILabel!
    
    @IBOutlet weak var telefoneView: UIView!
    
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
    
    @IBOutlet weak var barraProgressoView: BarraProgressoView!
    
    @IBOutlet weak var recomendacaoLabel: UILabel!

    @IBOutlet weak var avaliacaoLabel: UILabel!
    
    @IBOutlet weak var acessibilidadeView: UIView!
    
    @IBOutlet weak var avaliacaoRecomendacaoView: UIView!
    
    var imagensAcessibilidade: [UIImageView]?
    var sombrasImagens: [UIView]?
    
    @IBOutlet weak var siteLinha: UIView!
    @IBOutlet weak var telefoneLinha: UIView!
    
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
        
        if let imagens = imagensAcessibilidade {
            for imagem in imagens {
                imagem.layer.cornerRadius = 8
            }
        }
        
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
    }

}
