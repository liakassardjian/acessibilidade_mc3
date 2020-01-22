//
//  CuradoriaAvaliacoesTVC.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 16/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CuradoriaAvaliacoesTVC: UITableViewController {

    var empresa: Empresa?
    
    var usuario: String?
    let usuarioUUID = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults()
        let primeiroAcesso = defaults.bool(forKey: "primeiroAcesso")
        if !primeiroAcesso {
            registraUsuario(uuid: UUID().uuidString)
            defaults.set(true, forKey: "primeiroAcesso")
        } else {
            usuario = UserDefaults.standard.string(forKey: "UserId")
        }
}
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empresa?.avaliacoes.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avaliacao", for: indexPath)

        cell.textLabel?.text = empresa?.avaliacoes[indexPath.row].titulo
        var texto = ""
        switch empresa?.avaliacoes[indexPath.row].status {
        case .aprovado:
            texto = "Aprovada"
        case .reprovado:
            texto = "Reprovada"
        default:
            texto = "Pendente"
        }
        cell.detailTextLabel?.text = texto

        return cell
    }
    
    func registraUsuario(uuid: String) {
        UsuarioRequest().usuarioCreate(uuid: uuid, usuario: UsuarioCodable(), completion: { (response, error) in
            if response != nil {
                self.usuarioUUID.set(uuid, forKey: "UserId")
                self.usuario = UserDefaults.standard.string(forKey: "UserId")
                print("sucesso")
            } else {
                print("else")
            }
            })
    }
    
    func updateEmpresa(empresa: Empresa, estado: Estado) {
        let empresaCodable = EmpresaCodable(_id: empresa.id,
                                                nome: empresa.nome,
                                                site: empresa.site,
                                                telefone: empresa.telefone,
                                                media: 0,
                                                mediaRecomendacao: 0,
                                                cidade: empresa.cidade,
                                                estado: empresa.estado,
                                                estadoPendenteEmpresa: estado.rawValue, avaliacao: [])
        
            if let usuario = usuario {
                
            EmpresaRequest().updateEmpresa(uuid: usuario, empresa: empresaCodable) { (response, error) in
                                                    if response != nil {
                                                        print("sucesso empresa")
                                                    } else {
                                                        print("erro empresa")
                                                    }
                    }
                }
    }
        
    func updateAvaliacao (avaliacao: Avaliacao, estado: Estado) {
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
                                                estadoPendenteAvaliacao: estado.rawValue)
        if let usuario = usuario {
            AvaliacaoRequest().updateAvaliacao(uuid: usuario, avaliacao: avaliacaoCodable) { (response, error) in
                                                if response != nil {
                                                    print("sucesso avaliacao")
                                                } else {
                                                    print("erro avaliacao")
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
    
//    func registraAvaliacao(avaliacao: Avaliacao) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let data = dateFormatter.string(from: avaliacao.data)
//
//        let avaliacaoCodable = AvaliacaoCodable(_id: nil,
//                                                titulo: avaliacao.titulo,
//                                                data: data,
//                                                cargo: avaliacao.posicao,
//                                                tempoServico: converteTempoServico(tempoServico: avaliacao.tempoServico),
//                                                pros: avaliacao.vantagens,
//                                                contras: avaliacao.desvantagens,
//                                                melhorias: avaliacao.sugestoes,
//                                                ultimoAno: Double(avaliacao.ultimoAno),
//                                                recomenda: avaliacao.recomendacao,
//                                                integracaoEquipe: Double(avaliacao.integracao),
//                                                culturaValores: Double(avaliacao.cultura),
//                                                renumeracaoBeneficios: Double(avaliacao.remuneracao),
//                                                oportunidadeCrescimento: Double(avaliacao.oportunidade),
//                                                deficienciaMotora: avaliacao.acessibilidade.contains(.deficienciaMotora),
//                                                deficienciaVisual: avaliacao.acessibilidade.contains(.deficienciaVisual),
//                                                deficienciaAuditiva: avaliacao.acessibilidade.contains(.deficienciaAuditiva),
//                                                deficienciaIntelectual: avaliacao.acessibilidade.contains(.deficienciaIntelectual),
//                                                nanismo: avaliacao.acessibilidade.contains(.nanismo),
//                                                estadoPendenteAvaliacao: Estado.pendente.rawValue)
//
//        if let usuario = usuario {
//            AvaliacaoRequest().sendAvaliacao(idEmpresa: empresa?.id, uuid: usuario,
//                                             avaliacao: avaliacaoCodable) { (response, error) in
//                                                if response != nil {
//                                                    print("sucesso")
//                                                } else {
//                                                    print("erro")
//                                                }
//            }
//
//        }
//    }

}
