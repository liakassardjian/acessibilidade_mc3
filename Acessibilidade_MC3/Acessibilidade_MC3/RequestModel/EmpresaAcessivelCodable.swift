//
//  EmpresaAcessivelCodable.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

struct EmpresaCodable: Codable{
    var empresaId: String?
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
    var usuarioId: String?
    var avaliacoesUsuario: [AvaliacaoCodable]?
}
struct AvaliacaoCodable: Codable {
    var avaliacaoId: String?
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
    static func getAllEmpresas(complete: @escaping() -> ()) -> [EmpresaCodable] {//retorno de todas as empresas
        var empresas: [EmpresaCodable] = []
        do {
            let path = "https://br-empresa-acessivel.herokuapp.com/api/empresas/"
            guard let url = URL(string: path) else {
                return [EmpresaCodable]()
            }
            let empresasData = try Data(contentsOf: url as URL)
            empresas = try JSONDecoder().decode([EmpresaCodable].self, from: empresasData)
            complete()
            return empresas
        } catch {
            complete()
            print("\(error.localizedDescription)")
        }
        complete()
        return empresas
    }
    //funcao para voltar uma empresa só especifica
    static func getEmpresaEspecifica(empresaId: String) -> EmpresaCodable {
        var empresas: EmpresaCodable?

        do {
            let path = "https://br-empresa-acessivel.herokuapp.com/api/empresaNome/\(empresaId)/"
            guard let url = URL(string: path) else {
                return EmpresaCodable()
            }
            let empresasData = try Data(contentsOf: url as URL)
            empresas = try JSONDecoder().decode(EmpresaCodable.self, from: empresasData)
            guard let empresas = empresas else {
                return EmpresaCodable()
            }

            return empresas

        } catch {
            print("\(error.localizedDescription)")

        }
        guard let safeEmpresas = empresas else {
            return EmpresaCodable()
        }
        return safeEmpresas
    }


    static func getAvaliacoesEmpresa(empresaId: String) -> [AvaliacaoCodable] {
        //varias avaliacoes de um id especifico de empresa
        //varias letters de um id especifico de usuario
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
    static func getAvaliacoesUsuario(usuarioId: String) -> [AvaliacaoCodable] {
        //varias avaliacoes de um id especifico de usuario
        var avaliacoes: [AvaliacaoCodable] = []
        do {
            let path = "https://br-empresa-acessivel.herokuapp.com/api/empresaNome/\(usuarioId)/"
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
