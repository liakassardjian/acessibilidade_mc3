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
        
<<<<<<< HEAD
        empresasDataSourceDelegate?.empresas = [Empresa(nome: "Mackenzie", localizacao: "São Paulo, SP", site: nil),
                                                Empresa(nome: "Itau", localizacao: "São Paulo, SP", site: "www.itau.com.br")]
        
        let avaliacao1 = Avaliacao(data: Date(),
                                   titulo: "Bem vermelho",
                                   vantagens: "Eu curti muito pois é bem maneiro e eu achei bem maneiro e bem vermelho e eu gosto de vermelho porque vermelho é bem bonito mesmo",
                                   desvantagens: "Eu  não curti muito pois é bem não maneiro e eu achei bem não maneiro e não vermelho e eu não gosto de vermelho porque vermelho é bem feio mesmo",
                                   sugestoes: "Mais vermelho menos vermelho.",
                                   cargo: Cargo.atual,
                                   nota: 3.6,
                                   recomendacao: true,
                                   acessibilidade: [.deficienciaAuditiva, .deficienciaIntelectual])
        
        let avaliacao2 = Avaliacao(data: Date(),
                                   titulo: "Pouco vermelho",
                                   vantagens: "Eu curti muito pois é bem maneiro e eu achei bem maneiro e bem vermelho ",
                                   desvantagens: "Eu  não curti muito pois é bem não maneiro e eu achei bem não maneiro e não vermelho e eu não gosto de vermelho porque vermelho é bem feio mesmo",
                                   sugestoes: nil,
                                   cargo: Cargo.exFunc,
                                   nota: 4.9,
                                   recomendacao: false,
                                   acessibilidade: [.deficienciaAuditiva, .deficienciaMotora, .deficienciaVisual])
        
        empresasDataSourceDelegate?.empresas[0].adicionaAvaliacao(avaliacao: avaliacao1)
        empresasDataSourceDelegate?.empresas[0].adicionaAvaliacao(avaliacao: avaliacao2)
        empresasDataSourceDelegate?.empresas[1].adicionaAvaliacao(avaliacao: avaliacao1)
        registerUser()
    }
    
    func registerUser() {
        let uuid = UUID().uuidString
        UsuarioRequest().usuarioCreate(uuid: uuid) { (response, error) in
            if response != nil {
                //success
                print("sucesso")
            } else {
                //error
                print("falha")
            }
        }
=======
        let defaults = UserDefaults()
        let primeiroAcesso = defaults.bool(forKey: "primeiroAcesso")
        if !primeiroAcesso {
            // registra usuário
            defaults.set(true, forKey: "primeiroAcesso")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        empresaTableView.reloadData()
>>>>>>> 7df5d4a170752e451cbfe8bfee2b70025f7dfd9a
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let empresaInfo = segue.destination as? DetalhesEmpresaViewController {
            if let selecionada = empresaTableView.indexPathForSelectedRow {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas[selecionada.row]
            }
        }
    }
    
    @IBAction func adicionaEmpresa(_ sender: UIStoryboardSegue) {
        if sender.source is NovaEmpresaTableViewController {
            if let senderAdd = sender.source as? NovaEmpresaTableViewController {
                if let empresa = senderAdd.empresa {
                    self.empresasDataSourceDelegate?.empresas.append(empresa)
                    
                }
            }
        }
    }
    
}
