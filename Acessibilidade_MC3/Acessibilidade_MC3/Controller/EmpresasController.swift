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
    var empresas: [Empresa]
    
    init(empresas: [Empresa]) {
        self.empresas = empresas
    }
    
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
        
//        for a in empresas[indexPath.row].acessibilidade {
//            switch a {
//            case Acessibilidade.deficienciaVisual:
//
//            case Acessibilidade.deficienciaMotora:
//
//            case Acessibilidade.deficienciaAuditiva:
//
//            case Acessibilidade.deficienciaAuditiva:
//
//
//
//            }
//        }
        
        return cell
        
    }
    
}
