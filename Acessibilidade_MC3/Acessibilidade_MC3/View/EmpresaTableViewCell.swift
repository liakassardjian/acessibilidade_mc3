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
    
    @IBOutlet weak var avaliacaoCard: UIView!
    
    @IBOutlet weak var recomendacaoCard: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
