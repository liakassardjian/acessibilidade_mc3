//
//  CuradoriaDetalhesViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 22/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CuradoriaDetalhesViewController: UIViewController {

    /**
     Usuário que está utilizando o aplicativo no momento.
     
     É representado por uma string opcional.
     */
    var usuario: String?
    
    /**
    Conector da Table View que exibe os dados da empresa.
    */
    @IBOutlet weak var detalhesTableView: UITableView!
    
    /**
     Delegate e Data Source da empresa.
     
     Representado por DetalhesEmpresaController opcional.
     */
    var detalhesDataSourceDelegate: DetalhesEmpresaController?
    
    /**
     Empresa cujos detalhes são exibidos na tela.
  
     Recebe uma empresa de EmpresasViewController quando esta tela é chamada.
     */
    var empresa: Empresa?
    
    /**
       Avaliação que foi atualizada.
    
       Recebe uma instância de Avaliação quando há alterações, mas é nula enquanto não há mudanças.
    */
    var avaliacaoAtualizada: Avaliacao?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detalhesDataSourceDelegate = DetalhesEmpresaController()
        detalhesTableView.delegate = detalhesDataSourceDelegate
        detalhesTableView.dataSource = detalhesDataSourceDelegate
        
        detalhesDataSourceDelegate?.empresa = self.empresa
        detalhesDataSourceDelegate?.adm = true
        
        let headerNib = UINib.init(nibName: "AvaliacaoHeaderView", bundle: Bundle.main)
        detalhesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "AvaliacaoHeaderView")
        
        navigationItem.title = empresa?.nome
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let avaliar = segue.destination as? AvaliarEmpresaTableViewController {
            avaliar.empresa = self.empresa
        }
        if let avaliar = segue.destination as? AvaliarComentarioTableViewController {
            if let selecionada = detalhesTableView.indexPathForSelectedRow {
                avaliacaoAtualizada = empresa?.avaliacoes[selecionada.row]
                avaliar.avaliacao = avaliacaoAtualizada
            }
        }
    }
    
    @IBAction func salvarEmpresa(_ sender: UIStoryboardSegue) {
        if let empresa = empresa {
            atualizaEmpresa(empresa: empresa)
        }
    }
    
    @IBAction func salvarAvaliacao(_ sender: UIStoryboardSegue) {
        if let avaliacao = avaliacaoAtualizada,
            let empresa = empresa {
            atualizaAvaliacao(avaliacao: avaliacao)
            empresa.aprovaAvaliacao(avaliacao: avaliacao, usuario: usuario ?? "")
            avaliacaoAtualizada = nil
        }
    }
    
    // MARK: Data
    /**
    Funcão que atualiza uma empresa no servidor.
    
    - parameters:
       - empresa: A empresa que está sendo atualizada.
    */

    func atualizaEmpresa(empresa: Empresa) {
        let empresaCodable = EmpresaCodable(_id: empresa.id,
                                            nome: empresa.nome,
                                            site: empresa.site,
                                            telefone: empresa.telefone,
                                            media: 0,
                                            mediaRecomendacao: 0,
                                            cidade: empresa.cidade,
                                            estado: empresa.estado,
                                            estadoPendenteEmpresa: empresa.status.rawValue, avaliacao: [])
        
        if let usuario = usuario {
            EmpresaRequest().updateEmpresa(uuid: usuario,
                                           empresa: empresaCodable) { (response, error) in
                                            if response != nil {
                                                print("sucesso")
                                            } else {
                                                print("erro")
                                            }
            }
        }
    }
    
    /**
     Funcão que atualiza uma avaliação no servidor.
     
     - parameters:
        - avaliacao: A avaliação que está sendo atualizada.
     */
    func atualizaAvaliacao(avaliacao: Avaliacao) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let data = dateFormatter.string(from: avaliacao.data)
        
        let avaliacaoCodable = AvaliacaoCodable(_id: avaliacao.id,
                                                titulo: avaliacao.titulo,
                                                data: data,
                                                cargo: avaliacao.posicao,
                                                tempoServico: converteTempoServico(tempoServico: avaliacao.tempoServico),
                                                pros: avaliacao.vantagens,
                                                contras: avaliacao.desvantagens,
                                                melhorias: avaliacao.sugestoes ?? "",
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
                                                nanismo: avaliacao.acessibilidade.contains(.nanismo),
                                                estadoPendenteAvaliacao: avaliacao.status.rawValue)
        
        if let usuario = usuario {
            AvaliacaoRequest().updateAvaliacao(uuid: usuario,
                                             avaliacao: avaliacaoCodable) { (response, error) in
                                                if response != nil {
                                                    print("sucesso")
                                                } else {
                                                    print("erro")
                                                }
            }
            
        }
    }
    
    /**
     Função que converte uma descrição de tempo de serviço, de acordo com o enumerador `TempoServico`, em um double, a fim de que seja enviado ao servidor.
     
     - parameters:
        - tempoServico: A string de descrição do tempo de serviço, conforme casos do enumerador `TempoServico`.
     
     - returns: Um double, utilizado para correspondência com o servidor para descrição do tempo de serviço, conforme valores brutos dos casos do enumerador `TempoServico`.
     */
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
