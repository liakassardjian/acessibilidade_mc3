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
        self.id = ""
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
        self.status = .pendente
    }
    
    /**
        Id da avaliação
     
        É representado por uma string
     */
    var id: String
    
    /**
       Data de publicação da avaliação.
    
       É representado por um Date.
    */
    var data: Date
    
    /**
       Título dado à avaliação.
    
       É representado por uma string.
    */
    var titulo: String
    
    /**
       Vantagens da empresa, descritas pelo usuário na avaliação.
    
       São representadas por uma string.
    */
    var vantagens: String
    
    /**
       Desvantagens da empresa, descritas pelo usuário na avaliação.
    
       São representadas por uma string.
    */
    var desvantagens: String
    
    /**
       Sugestões para a empresa, podem ser descritas pelo usuário na avaliação.
    
       São representadas por uma string, mas são opcionais.
    */
    var sugestoes: String?
    
    /**
       Indica se avaliação foi feita por um funcionário atual ou ex-funcionário da empresa.
       
       É representado por um caso do enumerador Cargo.
    */
    var cargo: Cargo
    
    /**
       Média das notas dadas pelo usuário à empresa.
    
       É  representada por um float.
    */
    var nota: Float
    
    /**
       Recomendação da empresa pelo usuário.
    
       É  representada por um bool.
    */
    var recomendacao: Bool
    
    /**
       Classificação de acessibilidade da empresa.
    
       É  representada por um vetor de casos do enumerador Acessibilidade.
    */
    var acessibilidade: [Acessibilidade]
    
    /**
       Último ano em que o usuário trabalhou na empresa.
    
       É  representado por um int.
    */
    var ultimoAno: Int
    
    /**
       Tempo de serviço do usuário na empresa.
    
       É  representado por uma string.
    */
    var tempoServico: String
    
    /**
       Posição ocupada pelo usuário na empresa.
    
       É  representada por uma string.
    */
    var posicao: String
    
    /**
       Nota dada pelo usuário para integração com a equipe.
    
       É  representada por um int.
    */
    var integracao: Int
    
    /**
       Nota dada pelo usuário para cultura e valores.
    
       É  representada por um int.
    */
    var cultura: Int
    
    /**
       Nota dada pelo usuário para remuneração.
    
       É  representada por um int.
    */
    var remuneracao: Int
    
    /**
       Nota dada pelo usuário para oportunidade de crescimento.
    
       É  representada por um int.
    */
    var oportunidade: Int
    
    /**
       Estado de curadoria da avaliação inserida no sistema.
    
       É representado por um caso do enumerador Estado.
    */
    var status: Estado
    
}

/**
 Enumerador que representa o estado de curadoria de uma entrada do usuário.
 Corresponde com Double.
 */
enum Estado: Double {
    /**
     Caso em que a entrada foi aprovada pela curadoria.
     Equivale a 1.
     */
    case aprovado = 1
    
    /**
     Caso em que a entrada foi reprovada pela curadoria.
     Equivale a -1.
     */
    case reprovado = -1
    
    /**
    Caso em que a curadoria da entrada está pendente.
    Equivale a 0.
    */
    case pendente = 0
}
