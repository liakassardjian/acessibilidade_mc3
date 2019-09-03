//
//  Avaliacao.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Avaliacao {
    
    init() {
        self.data = Date()
        self.titulo = ""
        self.vantagens = ""
        self.desvantagens = ""
        self.cargo = .atual
        self.nota = 0
        self.recomendacao = false
        self.acessibilidade = []
        self.ultimoAno = Calendar.current.component(.year, from: Date())
        self.tempoServico = ""
        self.posicao = ""
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
    var ultimoAno: Int
    var tempoServico: String
    var posicao: String
    
}
