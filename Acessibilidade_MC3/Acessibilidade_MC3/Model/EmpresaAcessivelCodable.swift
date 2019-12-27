//
//  EmpresaAcessivelCodable.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
 Struct que possui os mesmos atributos da classe Empresa para fazer o contato com o servidor.
 */
struct EmpresaCodable: Codable {
    /**
       Identificador da empresa.
    
       É representado por uma string opcional.
    */
    var _id: String?
    
    /**
       Nome da empresa.
    
       É representado por uma string e é opcional.
    */
    var nome: String?
    
    /**
       Website da empresa.
    
       É representado por uma string e é opcional.
    */
    var site: String?
    
    /**
       Telefone da empresa.
    
       É representado por uma string e é opcional.
    */
    var telefone: String?
    
    /**
       Nota média da empresa.
    
       É representado por um double e é opcional.
    */
    var media: Double?
    
    /**
       Porcentagem de recomendação média da empresa.
    
       É representado por um double e é opcional.
    */
    var mediaRecomendacao: Double?
    
    /**
       Cidade onde a empresa está localizada.
    
       É representada por uma string, compõe a localização da empresa e é opcional.
    */
    var cidade: String?
    
    /**
       Estado onde a empresa está localizada.
    
       É representado por uma string, compõe a localização da empresa e é opcional.
    */
    var estado: String?
    
    /**
       Conjunto das avaliações atribuídas à empresa.
    
       É representado por um vetor de `AvaliacaoCodable` opcional.
    */
    var avaliacao: [AvaliacaoCodable?]
}

/**
Struct que representa um usuário no contato com o servidor.
*/
struct UsuarioCodable: Codable {
    /**
       Identificador do usuário.
    
       É representado por uma string opcional.
    */
    var uuid: String?
    
    /**
       Conjunto das avaliações publicadas por um usuário.
    
       É representado por um vetor opcional de `AvaliacaoCodable`.
    */
    var avaliacoesUsuario: [AvaliacaoCodable]?
}

/**
Struct que representa uma avaliação no contato com o servidor.
*/
struct AvaliacaoCodable: Codable {
    /**
       Identificador da avaliação.
    
       É representado por uma string opcional.
    */
    var _id: String?
    
    /**
       Título dado à avaliação.
    
       É representado por uma string opcional.
    */
    var titulo: String?
    
    /**
       Data de publicação da avaliação.
    
       É representada por uma string opcional.
    */
    var data: String?
    
    /**
       Cargo do usuário que publicou a avaliação.
    
       É representado por uma string opcional.
    */
    var cargo: String?
    
    /**
       Tempo de serviço do usuário que publicou avaliação.
    
       É representado por um double opcional.
    */
    var tempoServico: Double?
    
    /**
       Descrição dos prós da avaliação.
    
       É representada por uma string opcional.
    */
    var pros: String?
    
    /**
       Descrição dos contras da avaliação.
    
       É representada por uma string opcional.
    */
    var contras: String?
    
    /**
       Descrição das melhorias da avaliação.
    
       É representada por uma string opcional.
    */
    var melhorias: String?
    
    /**
       Último ano de serviço do usuário que publicou a avaliação.
    
       É representado por um double opcional.
    */
    var ultimoAno: Double?
    
    /**
       Recomendação dada na avaliação.
    
       É representada por um bool opcional.
    */
    var recomenda: Bool?
    
    //categoria
    /**
       Nota de integração com a equipe.
    
       É representada por um double opcional.
    */
    var integracaoEquipe: Double?
    
    /**
       Nota de cultura e valores.
    
       É representada por um double opcional.
    */
    var culturaValores: Double?
    
    /**
       Nota de remuneração e benefícios.
    
       É representada por um double opcional.
    */
    var renumeracaoBeneficios: Double?
    
    /**
       Nota de oportunidade de crescimento.
    
       É representada por um double opcional.
    */
    var oportunidadeCrescimento: Double?
    
    //acessibilidade
    /**
       Acessibilidade para deficiência motora.
    
       É representada por um bool opcional.
    */
    var deficienciaMotora: Bool?
    
    /**
       Acessibilidade para deficiência visual.
    
       É representada por um bool opcional.
    */
    var deficienciaVisual: Bool?
    
    /**
       Acessibilidade para deficiência auditiva.
    
       É representada por um bool opcional.
    */
    var deficienciaAuditiva: Bool?
    
    /**
       Acessibilidade para deficiência intelectual.
    
       É representada por um bool opcional.
    */
    var deficienciaIntelectual: Bool?
    
    /**
       Acessibilidade para nanismo.
    
       É representada por um bool opcional.
    */
    var nanismo: Bool?
}

/**
 Classe com funções estáticas para contato com o servidor.
 */
class InternEmpresaAcessivel: NSObject {
    
    /**
     Função estática que retorna todas as avaliações de uma empresa.
     - parameters:
        - empresaId: Identificador da empresa cujas avaliações deseja-se buscar.
     - returns:
        Todas as avaliações atribuídas à empresa.
     - throws:
        Imprime descrição de erro, caso haja.
     */
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
            
            return avaliacoes
        } catch {
            print("\(error.localizedDescription)")
        }
        return avaliacoes
    }
    
    /**
    Função estática que retorna todas as avaliações de um usuário.
    - parameters:
       - uuid: Identificador do usuário cujas avaliações deseja-se buscar.
    - returns:
       Todas as avaliações publicadas pelo usuário.
    - throws:
       Imprime descrição de erro, caso haja.
    */
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
            
            return avaliacoes
        } catch {
            print("\(error.localizedDescription)")
        }
        return avaliacoes
    }
}
