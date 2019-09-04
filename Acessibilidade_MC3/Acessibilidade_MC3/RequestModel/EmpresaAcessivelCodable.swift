//
//  EmpresaAcessivelCodable.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

struct EmpresaCodable: Codable {
    var _id: String?
    var nome: String?
    var site: String?
    var telefone: String?
    var media: Double?
    var mediaRecomendacao: Double?
    var cidade: String?
    var estado: String?
    var avaliacoesEmpresa: [AvaliacaoCodable]?
}
struct UsuarioCodable: Codable {
    var uuid: String?
    var avaliacoesUsuario: [AvaliacaoCodable]?
}
struct AvaliacaoCodable: Codable {
    var _id: String?
    var titulo: String?
    var data: Date?
    var cargo: String?
    var tempoServico: String?
    var pros: String?
    var contras: String?
    var melhorias: String?
    var ultimoAno: Double?
    var recomenda: Bool?
    //categoria
    var integracaEquipe: Double?
    var culturaValores: Double?
    var renumeracaoBeneficios: Double?
    var oportunidadeCrescimento: Double?
    //acessibilidade
    var deficienciaMotora: Bool?
    var deficienciaVisual: Bool?
    var deficienciaAuditiva: Bool?
    var deficienciaIntelectual: Bool?
    var nanismo: Bool?
}

class InternEmpresaAcessivel: NSObject {
    //retorna todas as empresas
   

    static func getAvaliacoesEmpresa(empresaId: String) -> [AvaliacaoCodable] {
        //varias avaliacoes de um id especifico de empresa
        var avaliacoes: [AvaliacaoCodable] = []
        do {
            let path = "https://br-empresa-acessivel.herokuapp.com/api/empresaNome/\(empresaId)/"
            guard let url = URL(string: path) else {
                return [AvaliacaoCodable]()
            }
            let avaliacoesData = try Data(contentsOf: url as URL)
            avaliacoes = try JSONDecoder().decode([AvaliacaoCodable].self, from: avaliacoesData)
            //AvaliacoesSingleton.shared.saveAvaliacoesFromRemoteDataSource(avaliacoes: avaliacoes)
            return avaliacoes
        } catch {
            print("\(error.localizedDescription)")
        }
        return avaliacoes
    }
    static func getAvaliacoesUsuario(uuid: String) -> [AvaliacaoCodable] {
        //varias avaliacoes de um id especifico de usuario
        var avaliacoes: [AvaliacaoCodable] = []
        do {
            let path = "https://br-empresa-acessivel.herokuapp.com/api/empresaNome/\(uuid)/"
            guard let url = URL(string: path) else {
                return [AvaliacaoCodable]()
            }
            let avaliacoesData = try Data(contentsOf: url as URL)
            avaliacoes = try JSONDecoder().decode([AvaliacaoCodable].self, from: avaliacoesData)
            //AvaliacoesSingleton.shared.saveAvaliacoesFromRemoteDataSource(avaliacoes: avaliacoes)
            return avaliacoes
        } catch {
            print("\(error.localizedDescription)")
        }
        return avaliacoes
    }
    //Implementar get de busca especifica de empresa
}
