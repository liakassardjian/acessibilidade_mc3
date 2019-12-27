//
//  Avaliacao.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

/**
Classe que representa uma avaliação dentro do sistema.

As avaliações são caracterizadas por data de publicação, título, vantagens, desvantagens, sugestões, posição do usuário e se o cargo é atual ou não, nota dada à empresa, recomendação, classificação de acessibilidade, último ano e tempo de serviço do usuário, notas em integração com a equipe, cultura e valores, remuneração e benefícios e oportunidade de crescimento.
*/
class Avaliacao {
    
    /**
     Inicializador da avaliação.
     
     Permite inicializar sem parâmetro nenhum; os valores são inseridos conforme o usuário preenche o formulário de avaliação.
     */
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
        self.integracao = 0
        self.cultura = 0
        self.remuneracao = 0
        self.oportunidade = 0
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
    var integracao: Int
    var cultura: Int
    var remuneracao: Int
    var oportunidade: Int
    
}
