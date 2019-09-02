//
//  Avaliacao.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Avaliacao {
    init(data: Date, titulo: String, vantagens: String, desvantagens: String, sugestoes: String?, cargo: Cargo, nota: Float, recomendacao: Bool, acessibilidade: [Acessibilidade]) {
        self.data = data
        self.titulo = titulo
        self.vantagens = vantagens
        self.desvantagens = desvantagens
        self.sugestoes = sugestoes
        self.cargo = cargo
        self.nota = nota
        self.recomendacao = recomendacao
        self.acessibilidade = acessibilidade
        
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
    
}
