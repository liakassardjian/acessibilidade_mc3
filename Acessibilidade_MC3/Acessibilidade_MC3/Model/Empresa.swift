//
//  Empresa.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

/**
 Classe que representa uma empresa dentro do sistema.
 
 As empresas são caracterizadas por nome, localização, telefone e website; esses elementos são atribuídos a uma empresa na sua inicialização. Uma empresa recebe uma nota, uma recomendação e uma classificação em acessibilidade; esses valores são atualizados a cada avaliação atribuída à empresa. E as empresas ao serem criadas também recebem um estado de pendencia inicial posteriormente podendo ser recusadas ou aprovadas.
 */
class Empresa {
    
    /**
        Nome da empresa.
     
        É representado por uma string.
     */
    var nome: String
    
    /**
       Cidade onde a empresa está localizada.
    
       É representada por uma string e compõe a localização da empresa.
    */
    var cidade: String
    
    /**
       Estado onde a empresa está localizada.
    
       É representado por uma string e compõe a localização da empresa.
    */
    var estado: String
    
    /**
       Localização completa da empresa.
    
       É representada por uma string e compposta por cidade e estado.
    */
    var localizacao: String
    
    /**
       Telefone da empresa.
    
       É representado por uma string, mas é um atributo opcional.
    */
    var telefone: String?
    
    /**
       Website da empresa.
    
       É representado por uma string, mas é um atributo opcional.
    */
    var site: String?
    
    /**
       Nota da empresa.
    
       O atributo é inicializado como um float de valor 0 na criação da empresa e é atualizado a cada nova avaliação enviada.
    */
    var nota: Float = 0.0
    
    /**
       Porcentagem de recomendação da empresa.
    
       O atributo é inicializado como um int de valor 0 na criação da empresa e é atualizado a cada nova avaliação enviada.
    */
    var recomendacao: Int = 0
    
    /**
       Classificação da acessibilidade da empresa.
    
       O atributo é inicializado como um vetor de Acessibilidade vazio e é atualizado a cada nova avaliação enviada.
    */
    var acessibilidade: [Acessibilidade] = []
    
    /**
       Conjunto das avaliações atribuídas à empresa.
    
       O atributo é inicializado como um vetor de Avaliação vazio e é atualizado a cada nova avaliação enviada.
    */
    var avaliacoes: [Avaliacao] = []
    
    /**
       Identificador da empresa.
    
       É representado por uma string opcional.
    */
    var id: String?
    
    /**
       Estado de curadoria da empresa inserida no sistema.
    
       É representado por um caso do enumerador Estado.
    */
    var status: Estado
    
    /**
     Vetor que contém todas as avaliações atribuídas a essa empresa que já foram aprovadas pela curadoria.
     
     É representado por um vetor de Avaliacao.
     */
    var avaliacoesAprovadas: [Avaliacao]
    
    /**
        Inicializador da empresa.
     
        - parameters:
            - nome: O nome da empresa. **Não** pode ser vazio.
            - site: Endereço do website da empresa. Pode ser vazio.
            - telefone: Telefone da empresa. Pode ser vazio.
            - cidade: Cidade onde a empresa está localizada. **Não** pode ser vazio.
            - estado: Estado onde a empresa está localizada. **Não** pode ser vazio.
            - id: Identificador da empresa no sistema. **Não** pode ser vazio.
            - status: Inteiro que representa o estado de curadoria de uma emoresa inserida no sistema. **Não** pode ser vazio.
     */
    init(nome: String, site: String?, telefone: String?, cidade: String, estado: String, id: String, status: Double) {
        self.nome = nome
        self.localizacao = "\(cidade), \(estado)"
        self.site = site
        self.telefone = telefone
        self.cidade = cidade
        self.estado = estado
        self.id = id
        self.avaliacoesAprovadas = []
        
        switch status {
        case Estado.aprovado.rawValue:
            self.status = .aprovado
        case Estado.reprovado.rawValue:
            self.status = .reprovado
        default:
            self.status = .pendente
        }
    }
    
    /**
     Inicializador da empresa.
     
     Permite a inicialização sem nenhum atributo.
     */
    init() {
        self.nome = ""
        self.localizacao = ""
        self.cidade = ""
        self.estado = ""
        self.status = .pendente
        self.avaliacoesAprovadas = []
    }
    
    /**
     Função que adiciciona uma avaliação à empresa.
     
     - parameters:
        - avaliacao: Uma Avaliação já criada anteriormente. **Não** pode ser vazio.
        - usuario: O identificador do usuário que enviou a avaliação. **Não** pode ser vazio.
        
     A função envia a atualização da empresa ao servidor, imprimindo se ouve sucesso ou erro no envio da nova avaliação.
     */
    public func adicionaAvaliacao(avaliacao: Avaliacao, usuario: String) {
        self.avaliacoes.append(avaliacao)
        if avaliacao.status == .aprovado {
            self.avaliacoesAprovadas.append(avaliacao)
//            TODO: As linhas abaixo devem ser chamadas quando um administrador aprovar a avaliação
            self.calculaMediaNota()
            self.calculaPorcentagemRecomendacao()
            self.registraAcessibilidade(avaliacao: avaliacao)
        }
        
        EmpresaRequest().updateEmpresa(uuid: usuario,
                                       empresa: criaEmpresaCodable()) { (response, error) in
                                        if response != nil {
                                            print("sucesso no envio de uma nova avaliacao")
                                        } else {
                                            print("erro no envio de uma nova avaliacao")
                                            print(error as Any)
                                        }
        }
    }
    
    /**
     Função que adiciona uma avaliação à lista de avaliações da empresa, registrando também as atualizações de acessibilidade.
     
     - parameters:
        - avaliacao: A nova Avaliação que está sendo atribuída à empresa. **Não** pode ser vazio.
     */
    public func criaAvaliacaoEmpresa(avaliacao: Avaliacao) {
        self.avaliacoes.append(avaliacao)
        if avaliacao.status == .aprovado {
            self.avaliacoesAprovadas.append(avaliacao)
            self.registraAcessibilidade(avaliacao: avaliacao)
        }
    }
    
    /**
     Função que calcula a nota média da empresa com base nas avaliações já atribuídas.
     A função atualiza o atributo `nota` da empresa com o novo valor.
     */
    private func calculaMediaNota() {
        var media: Float = 0
        for avaliacao in avaliacoesAprovadas {
            media += avaliacao.nota
        }
        
        if avaliacoesAprovadas.count > 0 {
            media /= Float(avaliacoesAprovadas.count)
        }
        self.nota = media
    }
    
    /**
    Função que calcula a porcentagem de recomendação da empresa com base nas avaliações já atribuídas.
    A função atualiza o atributo `recomendacao` da empresa com o novo valor.
    */
    private func calculaPorcentagemRecomendacao() {
        var recomendacoes: Int = 0
        for avaliacao in avaliacoesAprovadas {
            if avaliacao.recomendacao {
                recomendacoes += 1
            }
        }
        
        if avaliacoesAprovadas.count > 0 {
            recomendacoes = recomendacoes * 100 / avaliacoesAprovadas.count
        }
        
        self.recomendacao = recomendacoes
    }
    
    /**
    Função que registra uma nova classe de acessibilidade para a empresa, verificando se o valor já não foi atribuído anteriormente.
     
     - parameters:
        - avaliacao: A nova Avaliação que está sendo atribuída à empresa. **Não** pode ser vazio.
    */
    private func registraAcessibilidade(avaliacao: Avaliacao) {
        for acesso in avaliacao.acessibilidade {
            if !self.acessibilidade.contains(acesso) {
                self.acessibilidade.append(acesso)
            }
        }
    }
    
    /**
    Função que instancia um elemento do tipo EmpresaCodable e copia os atributos da empresa para a nova instância.
     
     - parameters:
        - avaliacao: A nova Avaliação que está sendo atribuída à empresa. **Não** pode ser vazio.
     
     - returns: Nova instância de EmpresaCodable já com os atributos da empresa.
     
    */
    private func criaEmpresaCodable() -> EmpresaCodable {
        let empresa = EmpresaCodable(_id: self.id,
                                     nome: self.nome,
                                     site: self.site,
                                     telefone: self.telefone,
                                     media: Double(self.nota),
                                     mediaRecomendacao: Double(self.recomendacao),
                                     cidade: self.cidade,
                                     estado: self.estado,
                                     estadoPendenteEmpresa: self.status.rawValue,
                                     avaliacao: [])
        
        return empresa
    }
    
}

/**
 Enumerador de acessibilidade, correspondendo com strings.
 */
enum Acessibilidade: String {
    /**
     Acessibilidade para o caso de deficiência motora.
     */
    case deficienciaMotora = "SIA"
    
    /**
    Acessibilidade para o caso de deficiência visual.
    */
    case deficienciaVisual = "SIDV"
    
    /**
    Acessibilidade para o caso de deficiência auditiva.
    */
    case deficienciaAuditiva = "SIDA"
    
    /**
    Acessibilidade para o caso de deficiência intelectual.
    */
    case deficienciaIntelectual = "SDI"
    
    /**
    Acessibilidade para o caso de nanismo.
    */
    case nanismo = "SPN"
}

/**
Enumerador de cargo, correspondendo com strings.
*/
enum Cargo: String {
    /**
    Caso de funcionário atual da empresa.
    */
    case atual = "Funcionário atual"
    
    /**
    Caso de ex-funcionário da empresa.
    */
    case exFunc = "Ex-funcionário"
}

/**
Protocolo de descrição do tempo de serviço.
*/
protocol DescricaoTempoServico {
    /**
    Descrição do tempo de serviço de uma pessoa em uma empresa.
    */
    var descricao: String { get }
}

/**
Enumerador de tempo de serviço, em conformidade com o protocolo `DescricaoTempoServico` e correspondendo com um double.
*/
enum TempoServico: Double, DescricaoTempoServico {
    /**
    Caso de menos de 3 meses trabalhando na empresa.
    */
    case menos3 = 0.25
    
    /**
    Caso de menos de 1 ano trabalhando na empresa.
    */
    case menos1 = 1
    
    /**
    Caso de menos de 5 anos trabalhando na empresa.
    */
    case menos5 = 5
    
    /**
    Caso de menos de 10 anos trabalhando na empresa.
    */
    case menos10 = 10
    
    /**
    Caso de 10 ou mais anos trabalhando na empresa.
    */
    case mais10 = 11
    
    /**
     Descrição do caso selecionado.
     */
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
