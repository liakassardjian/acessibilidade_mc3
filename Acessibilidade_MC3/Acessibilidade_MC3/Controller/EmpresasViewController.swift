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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let empresaInfo = segue.destination as? DetalhesEmpresaViewController {
            if let selecionada = empresaTableView.indexPathForSelectedRow {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas[selecionada.row]
            }
        }
    }
}

class Empresa {
    var nome: String
    var localizacao: String
    var site: String?
    var nota: Float = 0.0
    var recomendacao: Int = 0
    var acessibilidade: [Acessibilidade] = []
    var avaliacoes: [Avaliacao] = []
    
    init(nome: String, localizacao: String, site: String?) {
        self.nome = nome
        self.localizacao = localizacao
        
        if let site = site {
            self.site = site
        }
    }
    
    public func adicionaAvaliacao(avaliacao: Avaliacao) {
        self.avaliacoes.append(avaliacao)
        self.calculaMediaNota()
        self.calculaPorcentagemRecomendacao()
        self.registraAcessibilidade(avaliacao: avaliacao)
    }
    
    private func calculaMediaNota() {
        var media: Float = 0
        for avaliacao in avaliacoes {
            media += avaliacao.nota
        }
        
        if avaliacoes.count > 0 {
            media /= Float(avaliacoes.count)
        }
        self.nota = media
    }
    
    private func calculaPorcentagemRecomendacao() {
        var recomendacoes: Int = 0
        for avaliacao in avaliacoes {
            if avaliacao.recomendacao {
                recomendacoes += 1
            }
        }
        
        if avaliacoes.count > 0 {
            recomendacoes = recomendacoes * 100 / avaliacoes.count
        }
        
        self.recomendacao = recomendacoes
    }
    
    private func registraAcessibilidade(avaliacao: Avaliacao) {
        for acesso in avaliacao.acessibilidade {
            if !self.acessibilidade.contains(acesso) {
                self.acessibilidade.append(acesso)
            }
        }
    }
    
}

class Avaliacao {
    init(data: Date, titulo: String, vantagens: String, desvantagens: String, sugestoes: String?, cargo: Cargo, nota: Float, recomendacao: Bool, acessibilidade: [Acessibilidade]) {
        self.data = data
        self.titulo = titulo
        self.vantagens = vantagens
        self.desvantagens = desvantagens
        self.sugestoes = sugestoes
        self.cargo = cargo
        self.nota = nota
        self.recomendacao = recomendacao
        self.acessibilidade = acessibilidade
        
    }
    
    var data: Date
    var titulo: String
    var vantagens: String
    var desvantagens: String
    var sugestoes: String?
    var cargo: Cargo
    var nota: Float
    var recomendacao: Bool
    var acessibilidade: [Acessibilidade]
    
}

enum Acessibilidade: String {
    case deficienciaMotora = "SIA"
    case deficienciaVisual = "SIDV"
    case deficienciaAuditiva = "SIDA"
    case deficienciaIntelectual = "SDI"
    case nanismo = "SPN"
}

enum Cargo: String {
    case atual = "Funcionário atual"
    case exFunc = "Ex-funcionário"
}
