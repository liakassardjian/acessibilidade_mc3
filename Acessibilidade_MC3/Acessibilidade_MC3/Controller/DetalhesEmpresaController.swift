//
//  DetalhesEmpresaController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 29/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class DetalhesEmpresaController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let titles = ["Informações da empresa", "Avaliações (0)"]
    var empresa: Empresa?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InformacoesTableViewCell else {
                return UITableViewCell()
            }
            
            if let empresa = empresa {
                cell.localizacaoLabel.text = empresa.localizacao
                cell.avaliacaoLabel.text = String(empresa.nota)
                cell.barraProgressoView.valorProgresso = CGFloat(empresa.nota / 5)
                cell.recomendacaoLabel.text = String("\(empresa.recomendacao)%")
                
                if let site = empresa.site {
                    cell.siteLabel.text = site
                    cell.siteLinha.isHidden = false
                } else {
                    cell.siteLinha.isHidden = true
                }
                
                guard let imagens = cell.imagensAcessibilidade else {
                    return UITableViewCell()
                }
                
                var contador: Int = 0
            
                for acessivel in empresa.acessibilidade {
                    imagens[contador].image = UIImage(named: acessivel.rawValue)
                    imagens[contador].layer.cornerRadius = 8
                    contador += 1
                }
                
                for cont in contador..<5 {
                    imagens[cont].image = nil
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }

}
