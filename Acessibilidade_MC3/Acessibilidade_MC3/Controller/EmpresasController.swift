//
//  EmpresasController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class EmpresasController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var empresas = [Empresa(nome: "Mackenzie",
                            localizacao: "São Paulo, SP",
                            nota: 3.6,
                            recomendacao: 77,
                            acessibilidade: []),
                    Empresa(nome: "Mackenzie",
                             localizacao: "São Paulo, SP",
                             nota: 3.6,
                             recomendacao: 77,
                             acessibilidade: [.deficienciaAuditiva, .nanismo])]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empresas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "empresaCell", for: indexPath) as? EmpresaTableViewCell else {
            return UITableViewCell()
        }
       
        cell.nomeEmpresaLabel.text = empresas[indexPath.row].nome
        cell.localizacaoEmpresaLabel.text = empresas[indexPath.row].localizacao
        cell.notaLabel.text = String(empresas[indexPath.row].nota)
        cell.recomendacaoLabel.text = String("\(empresas[indexPath.row].recomendacao)%")
        
        var contador: Int = 0
        
        guard let imagens = cell.acessibilidades else {
            return UITableViewCell()
        }
        
        for acessivel in empresas[indexPath.row].acessibilidade {
            switch acessivel {
            case .deficienciaMotora:
                imagens[contador].image = UIImage(named: Acessibilidade.deficienciaMotora.rawValue)
                
            case .deficienciaVisual:
                imagens[contador].image = UIImage(named: Acessibilidade.deficienciaVisual.rawValue)
                
            case .deficienciaAuditiva:
                imagens[contador].image = UIImage(named: Acessibilidade.deficienciaAuditiva.rawValue)
                
            case .deficienciaIntelectual:
                imagens[contador].image = UIImage(named: Acessibilidade.deficienciaIntelectual.rawValue)

            case .nanismo:
                imagens[contador].image = UIImage(named: Acessibilidade.nanismo.rawValue)
                
            }
            
            contador += 1
        }
        
        return cell
        
    }
    
}
