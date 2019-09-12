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
    
    var empresas: [Empresa] = []
    
    var resultadosBusca = [Empresa]()
    var buscando = false
    
    weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buscando {
            return resultadosBusca.count
        } else {
            return empresas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "empresaCell", for: indexPath) as? EmpresaTableViewCell else {
            return UITableViewCell()
        }
        
        var dados: [Empresa]
        
        if buscando {
            dados = resultadosBusca
        } else {
            dados = empresas
        }
       
        cell.nomeEmpresaLabel.text = dados[indexPath.row].nome
        cell.localizacaoEmpresaLabel.text = dados[indexPath.row].localizacao
        cell.notaLabel.text = String(format: "%.1f", dados[indexPath.row].nota)
        cell.barraProgressoView.valorProgresso = CGFloat(dados[indexPath.row].nota / 5)
        cell.recomendacaoLabel.text = String("\(dados[indexPath.row].recomendacao)%")
        
        guard let imagens = cell.acessibilidades else {
            return UITableViewCell()
        }
        
        var contador: Int = 0
        for acessivel in dados[indexPath.row].acessibilidade {
            imagens[contador].image = UIImage(named: acessivel.rawValue)
            imagens[contador].layer.cornerRadius = 8
            if imagens[contador].image == UIImage(named: "SDI") {
                imagens[contador].accessibilityLabel = "Deficiência intelectual"
            } else if imagens[contador].image == UIImage(named: "SIA") {
                imagens[contador].accessibilityLabel = "Deficiência física"
            } else if imagens[contador].image == UIImage(named: "SIDA") {
                imagens[contador].accessibilityLabel = "Deficiência auditiva"
            } else if imagens[contador].image == UIImage(named: "SIDV") {
                imagens[contador].accessibilityLabel = "Deficiência visual"
            } else {
                imagens[contador].accessibilityLabel = "Nanismo"
            }
            contador += 1
        }
        for cont in contador..<5 {
            imagens[cont].isHidden = true
        }
        
        return cell
    }
    
}

extension EmpresasController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultadosBusca = empresas.filter({$0.nome.prefix(searchText.count) == searchText})
        buscando = true
        tableView?.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = #colorLiteral(red: 0.1980924308, green: 0.5395323634, blue: 0.780749023, alpha: 1)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        buscando = false
        tableView?.reloadData()
    }
}
