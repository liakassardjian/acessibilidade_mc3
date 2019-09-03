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
