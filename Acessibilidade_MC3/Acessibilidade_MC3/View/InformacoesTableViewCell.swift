//
//  InformacoesTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Representação visual da célula que contém todas as informações de uma empresa.
 
 A classe herda de `UITableViewCell`.
 */
class InformacoesTableViewCell: UITableViewCell {
    
    /**
     Conector da Label na qual é exibida a localização da empresa.
    */
    @IBOutlet weak var localizacaoLabel: UILabel!
    
    /**
     Conector da Label na qual é exibido o endereço do website da empresa.
    */
    @IBOutlet weak var siteLabel: UILabel!
    
    /**
     Conector da Label na qual é exibido o número de telefone da empresa.
    */
    @IBOutlet weak var telefoneLabel: UILabel!
    
    /**
     View que contém a primeira imagem de acessibilidade.
     */
    @IBOutlet weak var primeiraView: UIView!
    
    /**
     View que contém a segunda imagem de acessibilidade.
    */
    @IBOutlet weak var segundaView: UIView!
    
    /**
     View que contém a terceira imagem de acessibilidade.
    */
    @IBOutlet weak var terceiraView: UIView!
    
    /**
     View que contém a quarta imagem de acessibilidade.
    */
    @IBOutlet weak var quartaView: UIView!
    
    /**
     View que contém a quinta imagem de acessibilidade.
    */
    @IBOutlet weak var quintaView: UIView!
    
    /**
     Primeira imagem de acessibilidade.
    */
    @IBOutlet weak var primeiraImagem: UIImageView!
    
    /**
     Segunda imagem de acessibilidade.
    */
    @IBOutlet weak var segundaImagem: UIImageView!
    
    /**
     Terceira imagem de acessibilidade.
    */
    @IBOutlet weak var terceiraImagem: UIImageView!
    
    /**
     Quarta imagem de acessibilidade.
    */
    @IBOutlet weak var quartaImagem: UIImageView!
    
    /**
     Quinta imagem de acessibilidade.
    */
    @IBOutlet weak var quintaImagem: UIImageView!
    
    /**
     Conector da barra de progresso utilizada para representar a quantidade de estrelas correspondente à nota dada.
    */
    @IBOutlet weak var barraProgressoView: BarraProgressoView!
    
    /**
     Conector da Label na qual é exibida a porcentagem de recomendação da empresa.
    */
    @IBOutlet weak var recomendacaoLabel: UILabel!
    
    /**
     Conector da Label na qual é exibida a nota da empresa.
    */
    @IBOutlet weak var avaliacaoLabel: UILabel!
    
    /**
     Conector do conjunto de imagens de acessibilidade.
    */
    var imagensAcessibilidade: [UIImageView]?
    
    /**
     Conector do conjunto de views que fazem a sombra para as imagens.
    */
    var sombrasImagens: [UIView]?
    
    /**
     Conector da view que contém o endereço do website da empresa.
     */
    @IBOutlet weak var siteLinha: UIView!
    
    /**
     Conector da view que contém o telefone da empresa.
    */
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
