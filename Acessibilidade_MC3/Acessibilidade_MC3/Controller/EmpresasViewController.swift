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
    
    let usuarioUUID = UserDefaults.standard
    var usuario: String?

    @IBOutlet weak var empresaTableView: UITableView!
    @IBOutlet weak var activ: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var empresasDataSourceDelegate: EmpresasController?
    var empresaAdicionada: Bool = false
    
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
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        
        let defaults = UserDefaults()
        let primeiroAcesso = defaults.bool(forKey: "primeiroAcesso")
        if !primeiroAcesso {
            registraUsuario(uuid: UUID().uuidString)
            defaults.set(true, forKey: "primeiroAcesso")
        } else {
            usuario = UserDefaults.standard.string(forKey: "UserId")
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        empresaTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let empresaInfo = segue.destination as? DetalhesEmpresaViewController {
            if let selecionada = empresaTableView.indexPathForSelectedRow {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas[selecionada.row]
            } else {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas.last
            }
        }
        
        if let novaEmpresa = segue.destination as? NovaEmpresaTableViewController {
            novaEmpresa.empresasViewController = self
        }
    }
    
    @IBAction func adicionaEmpresa(_ sender: UIStoryboardSegue) {
        // método que permite o Exit da tela de adicionar empresas
    }
    
    func getEmpresas() {
        var empresasLocal: [Empresa] = []
        activ.startAnimating()
        activ.isHidden = false
        
        EmpresaRequest.getEmpresas(completion: { (responder) in
            switch responder {
            case .success(empresas: let empresas):
                for empresa in empresas {
                    
                    if let nome = empresa.nome,
                        let media = empresa.media,
                        let porcentagem = empresa.mediaRecomendacao,
                        let cidade = empresa.cidade,
                        let estado = empresa.estado,
                        let id = empresa._id {
                        
                            let novaEmpresa = Empresa(nome: nome,
                                                      site: empresa.site,
                                                      telefone: empresa.telefone,
                                                      cidade: cidade,
                                                      estado: estado,
                                                      id: id)
                        
                            novaEmpresa.nota = Float(media)
                            novaEmpresa.recomendacao = Int(porcentagem)
                        
                            for avaliacao in self.converteAvaliacoes(avaliacaoCodable: empresa.avaliacao) {
                                novaEmpresa.criaAvaliacaoEmpresa(avaliacao: avaliacao)
                            }
                            empresasLocal.append(novaEmpresa)
                    }
                }
                self.empresasDataSourceDelegate?.empresas = empresasLocal
                DispatchQueue.main.async { [weak self] in
                    self?.empresaTableView.reloadData()
                    self?.activ.stopAnimating()
                    self?.activ.isHidden = true
                    if let empresasVC = self {
                        if empresasVC.empresaAdicionada {
                            empresasVC.performSegue(withIdentifier: "detalhesEmpresa", sender: empresasVC)
                            empresasVC.empresaAdicionada = false
                        }
                    }
                }
                
            case .error(description: let description):
                print(description)
            }
        })
        
    }
    
    func converteAvaliacoes(avaliacaoCodable: [AvaliacaoCodable?]) -> [Avaliacao] {
        var avaliacoes: [Avaliacao] = []
        
        for avaliacao in avaliacaoCodable {
            if let titulo = avaliacao?.titulo,
                let data = avaliacao?.data,
                let cargo = avaliacao?.cargo,
                let tempoServico = avaliacao?.tempoServico,
                let pros = avaliacao?.pros,
                let contras = avaliacao?.contras,
                let ultimoAno = avaliacao?.ultimoAno,
                let integracao = avaliacao?.integracaoEquipe,
                let cultura = avaliacao?.culturaValores,
                let remuneracao = avaliacao?.renumeracaoBeneficios,
                let oportunidade = avaliacao?.oportunidadeCrescimento,
                let sia = avaliacao?.deficienciaMotora,
                let sidv = avaliacao?.deficienciaVisual,
                let sida = avaliacao?.deficienciaAuditiva,
                let sdi = avaliacao?.deficienciaIntelectual,
                let spn = avaliacao?.nanismo,
                let recomenda = avaliacao?.recomenda {
                
                let novaAvaliacao = Avaliacao()
                novaAvaliacao.titulo = titulo
                novaAvaliacao.vantagens = pros
                novaAvaliacao.desvantagens = contras
                novaAvaliacao.sugestoes = avaliacao?.melhorias
                novaAvaliacao.nota = media(valores: [integracao,
                                                     cultura,
                                                     remuneracao,
                                                     oportunidade])
                novaAvaliacao.recomendacao = recomenda
                novaAvaliacao.ultimoAno = Int(ultimoAno)
                novaAvaliacao.posicao = cargo
                
                novaAvaliacao.tempoServico = converteTempoServico(tempoServico: tempoServico)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.locale = Locale(identifier: "pt_BR")
                if let date = dateFormatter.date(from: data) {
                    novaAvaliacao.data = date
                }
            
                adicionaAcessibilidade(sia: sia, sidv: sidv, sida: sida, sdi: sdi, spn: spn, avaliacao: novaAvaliacao)
                
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
    
    func adicionaAcessibilidade(sia: Bool, sidv: Bool, sida: Bool, sdi: Bool, spn: Bool, avaliacao: Avaliacao) {
        if sia {
            avaliacao.acessibilidade.append(.deficienciaMotora)
        }
        if sidv {
            avaliacao.acessibilidade.append(.deficienciaVisual)
        }
        if sida {
            avaliacao.acessibilidade.append(.deficienciaAuditiva)
        }
        if sdi {
            avaliacao.acessibilidade.append(.deficienciaIntelectual)
        }
        if spn {
            avaliacao.acessibilidade.append(.nanismo)
        }
    }
    
    func converteTempoServico(tempoServico: Double) -> String {
        switch tempoServico {
        case 0.25:
            return TempoServico.menos3.descricao
            
        case 1:
            return TempoServico.menos1.descricao
            
        case 5:
            return TempoServico.menos5.descricao
            
        case 10:
            return TempoServico.menos10.descricao
            
        case 11:
            return TempoServico.mais10.descricao
            
        default:
            return ""
        }
    }
    
    func registraUsuario(uuid: String) {
        UsuarioRequest().usuarioCreate(uuid: uuid, completion: { (response, error) in
            if response != nil {
                self.usuarioUUID.set(uuid, forKey: "UserId")
                self.usuario = UserDefaults.standard.string(forKey: "UserId")
                print("sucesso")
            } else {
                print("else")
            }
            })
    }
    
    func registraEmpresa(empresa: Empresa) {
        let empresaCodable = EmpresaCodable(_id: nil,
                                            nome: empresa.nome,
                                            site: empresa.site,
                                            telefone: empresa.telefone,
                                            media: 0,
                                            mediaRecomendacao: 0,
                                            cidade: empresa.cidade,
                                            estado: empresa.estado,
                                            avaliacao: [])
        
        if let usuario = usuario {
            EmpresaRequest().empresaCreate(uuid: usuario,
                                           empresa: empresaCodable) { (response, error) in
                                            if response != nil {
                                                print("sucesso")
                                            } else {
                                                print("erro")
                                            }
            }
            
        }
    }
}
