//
//  AvaliacaoTableViewCell.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 30/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
 Representação visual das avaliações enviadas sobre uma empresa.
 
 A classe herda de `UITableViewCell`.
 */
class AvaliacaoTableViewCell: UITableViewCell {

    /**
     Conector do card que contém a avaliação.
     */
    @IBOutlet weak var cardView: UIView! {
        didSet {
            self.cardView.layer.cornerRadius = 8
            self.cardView.layer.shadowColor = #colorLiteral(red: 0.0804778561, green: 0.1687734723, blue: 0.2325027883, alpha: 1)
            self.cardView.layer.shadowOpacity = 0.15
            self.cardView.layer.shadowRadius = 8
            self.cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    
    /**
     Conector da Label que contém a data da avaliação.
     */
    @IBOutlet weak var dataLabel: UILabel!
    
    /**
     Conector da Label que contém o título da avaliação.
    */
    @IBOutlet weak var tituloLabel: UILabel!
    
    /**
     Conector da Label que contém a nota dada na avaliação.
    */
    @IBOutlet weak var notaLabel: UILabel!
    
    /**
     Conector da barra de progresso utilizada para representar a quantidade de estrelas correspondente à nota dada.
    */
    @IBOutlet weak var barraProgressoView: BarraProgressoView!
    
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
     Label na qual são descritas as vantagens da empresa.
     */
    @IBOutlet weak var vantagensLabel: UILabel!
    
    /**
     Label na qual são descritas as desvantagens da empresa.
    */
    @IBOutlet weak var desvantagensLabel: UILabel!
    
    /**
     Label na qual são escritas sugestões para a empresa.
    */
    @IBOutlet weak var sugestoesLabel: UILabel!
    
    /**
     Label que contém o título da parte de Sugestões.
    */
    @IBOutlet weak var sugestoesTituloLabel: UILabel!
    
    /**
     Label que contém a descrição do cargo do avaliador dentro da empresa.
     */
    @IBOutlet weak var cargoLabel: UILabel!
    
    /**
     Label que indica se a empresa foi recomendada ou não.
     */
    @IBOutlet weak var recomendaLabel: UILabel!
    
    /**
     Imagem que indica se a empresa foi recomendada ou não.
     */
    @IBOutlet weak var recomendaImagem: UIImageView!
    
    /**
     Conector do conjunto de imagens de acessibilidade.
    */
    var imagensAcessibilidade: [UIImageView]?
    
    /**
     Conector do conjunto de views que fazem a sombra para as imagens.
    */
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
    }

}
