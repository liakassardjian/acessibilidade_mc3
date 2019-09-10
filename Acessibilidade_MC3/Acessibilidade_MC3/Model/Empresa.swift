//
//  Empresa.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Empresa {
    var nome: String
    var cidade: String
    var estado: String
    var localizacao: String
    var telefone: String?
    var site: String?
    var nota: Float = 0.0
    var recomendacao: Int = 0
    var acessibilidade: [Acessibilidade] = []
    var avaliacoes: [Avaliacao] = []
    var id: String?
    
    init(nome: String, site: String?, telefone: String?, cidade: String, estado: String, id: String) {
        self.nome = nome
        self.localizacao = "\(cidade), \(estado)"
        self.site = site
        self.telefone = telefone
        self.cidade = cidade
        self.estado = estado
        self.id = id
    }
    
    init() {
        self.nome = ""
        self.localizacao = ""
        self.cidade = ""
        self.estado = ""
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

protocol DescricaoTempoServico {
    var descricao: String { get }
}

enum TempoServico: Double, DescricaoTempoServico {
    case menos3 = 0.25
    case menos1 = 1
    case menos5 = 5
    case menos10 = 10
    case mais10 = 11
    
    var descricao: String {
        switch self {
        case .menos3:
            return "Menos de 3 meses"
        case .menos1:
            return "Menos de 1 ano"
        case .menos5:
            return "1 a 5 anos"
        case .menos10:
            return "5 a 10 anos"
        case .mais10:
            return "Mais de 10 anos"
        }
    }
        
}
