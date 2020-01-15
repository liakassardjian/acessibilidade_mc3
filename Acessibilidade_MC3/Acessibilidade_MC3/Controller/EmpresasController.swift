//
//  EmpresasController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
 Classe que controla a lista de empresas exibida na primeira tela.
 
 A classe herda de NSObject, UITableViewDataSource e UITableViewDelegate, sendo, assim, Delegate e Data Source de uma determinada Table View.
 */
class EmpresasController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /**
     Lista de empresas existentes no sistema.
     
     Inicializada como vazia até que as empresas sejam buscadas do servidor.
     */
    var empresas: [Empresa] = []
    
    /**
     Lista das empresas correspondentes a um resultado de busca.
     
     Inicializada como vazia.
     */
    var resultadosBusca = [Empresa]()
    
    /**
     Booleano que informa se está sendo feita uma busca no momento ou não.
     
     Inicializado como false.
     */
    var buscando = false
    
    /**
     Table View que está sendo controlada por uma instância dessa classe.
     
     É atribuída na inicialização da classe.
     */
    weak var tableView: UITableView?
    
    /**
     Inicializador da classe.
     
     - parameters:
        - tableView: Table View que está sendo controlada pela instância que está sendo inicializada.
     */
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
            
            imagens[contador+5].image = UIImage(named: acessivel.rawValue)
            imagens[contador+5].layer.cornerRadius = 8
            
            contador += 1
        }
        for cont in contador..<5 {
            imagens[cont].image = nil
            imagens[cont+5].image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 217
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
