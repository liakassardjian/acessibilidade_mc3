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
    
    /**
     Função que calcula a média das notas de uma avaliação.
     
     - parameters:
        - valores: Vetor de double que contém as notas dadas na avaliação.
     
     - returns: Float correspondente à média das notas.
     */
    func media(valores: [Double]) -> Float {
        var media: Float = 0
        
        if valores.count > 0 {
            for valor in valores {
                media += Float(valor)
            }
            media /= Float(valores.count)
        }
        
        return media
    }
    
    /**
     Função que converte um double em uma descrição de tempo de serviço em uma empresa.
     
     - parameters:
        - tempoServico: Double que será convertido em uma descrição.
     
     - returns: String que corresponde à descrição do double passado como parâmetro.
     */
    func converteTempoServico(tempoServico: Double) -> String {
        switch tempoServico {
        case 0.25:
            return TempoServico.menos3.descricao
        case 1:
            return TempoServico.menos1.descricao
        case 5:
            return TempoServico.menos5.descricao
        case 10:
            return TempoServico.menos10.descricao
        case 11:
            return TempoServico.mais10.descricao
        default:
            return ""
        }
    }
    
    /**
     Função que adiciona um caso de `Acessibilidade` a uma avaliação.
     
     - parameters:
        - sia: Booleano que representa a existência de acessibilidade para deficiência motora.
        - sidv: Booleano que representa a existência de acessibilidade para deficiência visual.
        - sida: Booleano que representa a existência de acessibilidade para deficiência auditiva.
        - sdi: Booleano que representa a existência de acessibilidade para deficiência intelectual.
        - sia: Booleano que representa a existência de acessibilidade para pessoas com nanismo.
        - avaliacao: A avaliação à qual serão atribuídas as classes de acessibilidade.
     */
    func adicionaAcessibilidade(sia: Bool, sidv: Bool, sida: Bool, sdi: Bool, spn: Bool) {
        if sia {
            acessibilidade.append(.deficienciaMotora)
        }
        if sidv {
            acessibilidade.append(.deficienciaVisual)
        }
        if sida {
            acessibilidade.append(.deficienciaAuditiva)
        }
        if sdi {
            acessibilidade.append(.deficienciaIntelectual)
        }
        if spn {
            acessibilidade.append(.nanismo)
        }
    }
    
    /**
     Função que converte os valores de uma instância de `AvaliacaoCodable` para uma `Avaliacao`.
     
      - parameters:
         - avaliacaoCodable: Instância de `AvaliacaoCodable ` cujos valores serão convertidos.
     */
    func converteAvaliacao(avaliacao: AvaliacaoCodable) {
        if  let id = avaliacao._id,
            let titulo = avaliacao.titulo,
            let data = avaliacao.data,
            let cargo = avaliacao.cargo,
            let tempoServico = avaliacao.tempoServico,
            let pros = avaliacao.pros,
            let contras = avaliacao.contras,
            let ultimoAno = avaliacao.ultimoAno,
            let integracao = avaliacao.integracaoEquipe,
            let cultura = avaliacao.culturaValores,
            let remuneracao = avaliacao.renumeracaoBeneficios,
            let oportunidade = avaliacao.oportunidadeCrescimento,
            let sia = avaliacao.deficienciaMotora,
            let sidv = avaliacao.deficienciaVisual,
            let sida = avaliacao.deficienciaAuditiva,
            let sdi = avaliacao.deficienciaIntelectual,
            let spn = avaliacao.nanismo,
            let recomenda = avaliacao.recomenda,
            let status = avaliacao.estadoPendenteAvaliacao {
            
                self.titulo = titulo
                self.vantagens = pros
                self.desvantagens = contras
                self.sugestoes = avaliacao.melhorias
                self.nota = media(valores: [integracao, cultura, remuneracao, oportunidade])
                self.integracao = Int(integracao)
                self.cultura = Int(cultura)
                self.remuneracao = Int(remuneracao)
                self.oportunidade = Int(oportunidade)
                self.recomendacao = recomenda
                self.ultimoAno = Int(ultimoAno)
                self.posicao = cargo
                self.id = id
                
                switch status {
                case -1:
                    self.status = .reprovado
                case 0:
                    self.status = .pendente
                case 1:
                    self.status = .aprovado
                default:
                    break
                }
                
                self.tempoServico = converteTempoServico(tempoServico: tempoServico)
            
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.locale = Locale(identifier: "pt_BR")
                if let date = dateFormatter.date(from: data) {
                    self.data = date
                }
        
                adicionaAcessibilidade(sia: sia, sidv: sidv, sida: sida, sdi: sdi, spn: spn)
            
                if Int(ultimoAno) != Calendar.current.component(.year, from: Date()) {
                    self.cargo = .exFunc
                }
        }
    }
        
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
