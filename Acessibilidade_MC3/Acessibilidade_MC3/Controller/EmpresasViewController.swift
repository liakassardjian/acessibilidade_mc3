//
//  EmpresasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit
import Foundation

class EmpresasViewController: UIViewController {

    @IBOutlet weak var empresaTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var empresasDataSourceDelegate: EmpresasController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empresasDataSourceDelegate = EmpresasController(tableView: empresaTableView)
        empresaTableView.delegate = empresasDataSourceDelegate
        empresaTableView.dataSource = empresasDataSourceDelegate
        empresaTableView.rowHeight = 217
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Busca"
        self.searchController.searchBar.delegate = empresasDataSourceDelegate
        self.searchController.searchBar.isTranslucent = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
}

class Empresa {
    init(nome: String, localizacao: String, nota: Float, recomendacao: Int, acessibilidade: [Acessibilidade]) {
        self.nome = nome
        self.localizacao = localizacao
        self.nota = nota
        self.recomendacao = recomendacao
        self.acessibilidade = acessibilidade
    }
    
    var nome: String
    var localizacao: String
    var nota: Float
    var recomendacao: Int
    var acessibilidade: [Acessibilidade]
}

enum Acessibilidade: String {
    case deficienciaMotora = "SIA"
    case deficienciaVisual = "SIDV"
    case deficienciaAuditiva = "SIDA"
    case deficienciaIntelectual = "SDI"
    case nanismo = "SPN"
}
