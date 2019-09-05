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
        getEmpresas()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        empresaTableView.reloadData()
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
    
    func getEmpresas() {
        var empresasLocal: [Empresa] = []
        
        EmpresaRequest.getEmpresas(completion: { (responder) in
            switch responder {
            case .success(empresas: let empresas):
                for empresa in empresas {
                    
                    if let nome = empresa.nome,
                        let media = empresa.media,
                        let porcentagem = empresa.mediaRecomendacao,
                        let cidade = empresa.cidade,
                        let estado = empresa.estado {
                        
                        let localizacao = "\(cidade), \(estado)"
                        
                        let novaEmpresa = Empresa(nome: nome,
                                                  localizacao: localizacao,
                                                  site: empresa.site,
                                                  telefone: empresa.telefone)
                        novaEmpresa.nota = Float(media)
                        novaEmpresa.recomendacao = Int(porcentagem)
                        
                        if let avaliacoes = empresa.avaliacoesEmpresa {
                            
                            for avaliacao in self.converteAvaliacoes(avaliacaoCodable: avaliacoes) {
                                novaEmpresa.adicionaAvaliacao(avaliacao: avaliacao)
                            }
                        }
                        
                        empresasLocal.append(novaEmpresa)
                    }
                }
                self.empresasDataSourceDelegate?.empresas = empresasLocal
                DispatchQueue.main.async { [weak self] in
                    self?.empresaTableView.reloadData()
                }
                
            case .error(description: let description):
                print(description)
            }
        })
        
    }
    
    func converteAvaliacoes(avaliacaoCodable: [AvaliacaoCodable]) -> [Avaliacao] {
        var avaliacoes: [Avaliacao] = []
        
        for avaliacao in avaliacaoCodable {
            
            if let titulo = avaliacao.titulo,
                let data = avaliacao.data,
                let cargo = avaliacao.cargo,
                let tempoServico = avaliacao.tempoServico,
                let pros = avaliacao.pros,
                let contras = avaliacao.contras,
                let ultimoAno = avaliacao.ultimoAno,
                let integracao = avaliacao.integracaEquipe,
                let cultura = avaliacao.culturaValores,
                let remuneracao = avaliacao.renumeracaoBeneficios,
                let oportunidade = avaliacao.oportunidadeCrescimento,
                let sia = avaliacao.deficienciaMotora,
                let sidv = avaliacao.deficienciaVisual,
                let sida = avaliacao.deficienciaAuditiva,
                let sdi = avaliacao.deficienciaIntelectual,
                let spn = avaliacao.nanismo,
                let recomenda = avaliacao.recomenda {
                
                let novaAvaliacao = Avaliacao()
                novaAvaliacao.titulo = titulo
                novaAvaliacao.data = data
                novaAvaliacao.vantagens = pros
                novaAvaliacao.desvantagens = contras
                novaAvaliacao.sugestoes = avaliacao.melhorias
                novaAvaliacao.nota = media(valores: [integracao,
                                                     cultura,
                                                     remuneracao,
                                                     oportunidade])
                novaAvaliacao.recomendacao = recomenda
                novaAvaliacao.ultimoAno = Int(ultimoAno)
                novaAvaliacao.tempoServico = tempoServico
                novaAvaliacao.posicao = cargo
                
                if sia {
                    novaAvaliacao.acessibilidade.append(.deficienciaMotora)
                }
                if sidv {
                    novaAvaliacao.acessibilidade.append(.deficienciaVisual)
                }
                if sida {
                    novaAvaliacao.acessibilidade.append(.deficienciaAuditiva)
                }
                if sdi {
                    novaAvaliacao.acessibilidade.append(.deficienciaIntelectual)
                }
                if spn {
                    novaAvaliacao.acessibilidade.append(.nanismo)
                }
                
                if Int(ultimoAno) != Calendar.current.component(.year, from: Date()) {
                    novaAvaliacao.cargo = .exFunc
                }
                
                avaliacoes.append(novaAvaliacao)
            }
        }
        
        return avaliacoes
    }
    
    func media(valores: [Double]) -> Float {
        var media: Float = 0
        
        if valores.count > 0 {
            for valor in valores {
                media += Float(valor)
            }
            media /= Float(valores.count)
        }
        
        return media
    }
}
