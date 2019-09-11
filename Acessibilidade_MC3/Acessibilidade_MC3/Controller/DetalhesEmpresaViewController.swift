//
//  DetalhesEmpresaViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 29/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class DetalhesEmpresaViewController: UIViewController {

    @IBOutlet weak var detalhesTableView: UITableView!
    
    var detalhesDataSourceDelegate: DetalhesEmpresaController?
    
    var empresa: Empresa?
    var avaliacao: Avaliacao?
    var usuario: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detalhesDataSourceDelegate = DetalhesEmpresaController()
        detalhesTableView.delegate = detalhesDataSourceDelegate
        detalhesTableView.dataSource = detalhesDataSourceDelegate
        
        detalhesDataSourceDelegate?.empresa = self.empresa
        
        let headerNib = UINib.init(nibName: "AvaliacaoHeaderView", bundle: Bundle.main)
        detalhesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "AvaliacaoHeaderView")
        
        navigationItem.title = empresa?.nome
        
        usuario = UserDefaults.standard.string(forKey: "UserId")
        
    }

    @IBAction func adicionaAvaliacao(_ sender: UIStoryboardSegue) {
        if sender.source is AvaliarProsViewController {
            if let senderAdd = sender.source as? AvaliarProsViewController {
                if let avaliacao = senderAdd.avaliacao {
                    self.avaliacao = avaliacao
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let avaliacao = avaliacao {
            registraAvaliacao(avaliacao: avaliacao)
            empresa?.adicionaAvaliacao(avaliacao: avaliacao, usuario: usuario ?? "")
            self.avaliacao = nil
        }
        
        detalhesTableView.reloadData()
    }
    
    func registraAvaliacao(avaliacao: Avaliacao) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let data = dateFormatter.string(from: avaliacao.data)
        
        let avaliacaoCodable = AvaliacaoCodable(_id: nil,
                                                titulo: avaliacao.titulo,
                                                data: data,
                                                cargo: avaliacao.posicao,
                                                tempoServico: converteTempoServico(tempoServico: avaliacao.tempoServico),
                                                pros: avaliacao.vantagens,
                                                contras: avaliacao.desvantagens,
                                                melhorias: avaliacao.sugestoes,
                                                ultimoAno: Double(avaliacao.ultimoAno),
                                                recomenda: avaliacao.recomendacao,
                                                integracaoEquipe: Double(avaliacao.integracao),
                                                culturaValores: Double(avaliacao.cultura),
                                                renumeracaoBeneficios: Double(avaliacao.remuneracao),
                                                oportunidadeCrescimento: Double(avaliacao.oportunidade),
                                                deficienciaMotora: avaliacao.acessibilidade.contains(.deficienciaMotora),
                                                deficienciaVisual: avaliacao.acessibilidade.contains(.deficienciaVisual),
                                                deficienciaAuditiva: avaliacao.acessibilidade.contains(.deficienciaAuditiva),
                                                deficienciaIntelectual: avaliacao.acessibilidade.contains(.deficienciaIntelectual),
                                                nanismo: avaliacao.acessibilidade.contains(.nanismo))
        
        if let usuario = usuario {
            AvaliacaoRequest().sendAvaliacao(idEmpresa: empresa?.id, uuid: usuario,
                                             avaliacao: avaliacaoCodable) { (response, error) in
                                                if response != nil {
                                                    print("sucesso")
                                                } else {
                                                    print("erro")
                                                }
            }
            
        }
    }
    
    func converteTempoServico(tempoServico: String) -> Double {
        switch tempoServico {
        case TempoServico.menos3.descricao:
            return TempoServico.menos3.rawValue
            
        case TempoServico.menos1.descricao:
            return TempoServico.menos1.rawValue
            
        case TempoServico.menos5.descricao:
            return TempoServico.menos5.rawValue
            
        case TempoServico.menos10.descricao:
            return TempoServico.menos10.rawValue
            
        case TempoServico.mais10.descricao:
            return TempoServico.mais10.rawValue
    
        default:
            return 0
        }
    }

}
