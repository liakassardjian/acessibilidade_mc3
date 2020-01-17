//
//  AvaliacaoRequest.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

/**
Enumerador de possíveis respostas para o carregamento das avaliações de uma empresa, compatível com Error.
*/
enum AvaliacoesEmpresaLoadResponse: Error {
    /**
    Caso de sucesso no carregamento, recebendo um vetor de AvaliacaoCodable.
    */
    case success(avaliacoesEmpresa: [AvaliacaoCodable])
    
    /**
    Caso de erro no carregamento, recebendo uma string de descrição.
    */
    case error(description: String)
}

import Foundation

/**
Classe que controla a requisição das avaliações ao servidor.
*/
class AvaliacaoRequest {
    
    /**
    Função que envia uma avaliação criada ao servidor.
    - parameters:
        - idEmpresa: String opcional que representa o identificador da empresa que está sendo avaliada.
        - uuid: Identificador do usuário que enviou a avaliação.
        - avaliacao: Instância de AvaliacaoCodable que será enviada ao servidor.
        - completion: Closure que é chamada com um vetor opcional de strings como Any e um Error opcional.
    */
    func sendAvaliacao(idEmpresa: String?, uuid: String, avaliacao: AvaliacaoCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let parameters = ["titulo": avaliacao.titulo as Any,
                               "data": avaliacao.data as Any,
                               "cargo": avaliacao.cargo as Any,
                               "tempoServico": avaliacao.tempoServico as Any,
                               "pros": avaliacao.pros as Any,
                               "contras": avaliacao.contras as Any,
                               "melhorias": avaliacao.melhorias as Any,
                               "ultimoAno": avaliacao.ultimoAno as Any,
                               "recomenda": avaliacao.recomenda as Any,
                               "integracaoEquipe": avaliacao.integracaoEquipe as Any,
                               "culturaValores": avaliacao.culturaValores as Any,
                               "renumeracaoBeneficios": avaliacao.renumeracaoBeneficios as Any,
                               "oportunidadeCrescimento": avaliacao.oportunidadeCrescimento as Any,
                               "deficienciaMotora": avaliacao.deficienciaMotora as Any,
                               "deficienciaVisual": avaliacao.deficienciaVisual as Any,
                               "deficienciaAuditiva": avaliacao.deficienciaAuditiva as Any,
                               "deficienciaIntelectual": avaliacao.deficienciaIntelectual as Any,
                               "nanismo": avaliacao.nanismo as Any,
                               "uuid": uuid,
                               "estadoPendenteAvaliacao": avaliacao.estadoPendenteAvaliacao as Any] as [String: Any]
        
        guard let idEmpresa = idEmpresa else { return }
        guard let url = URL(string: RequestConstants.POSTAVALIACAO + idEmpresa) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")

        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                do {
                    print(data as Any)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: [])
                        if let safeJson = json as? [String: Any] {
                            print(safeJson)
                            for (key, value) in safeJson {
                                if key == "result" {
                                    if value as? Int == 0 {
                                        completion(nil, nil)
                                    } else {
                                        completion(safeJson, nil)
                                    }
                                } else {
                                    completion(nil, nil)
                                }
                            }
                        } else {
                            print("no file")
                        }
                        }
                } catch {
                    print(error.localizedDescription)
                }
            })
        })
        task.resume()
}
    
    /**
    Função estática que busca as avaliações de uma empresa no servidor.
    
    - parameters:
        - empresaId: String que representa o identificador da empresa cujas avaliações estão sendo buscadas.
        - completion: Closure que é chamada com caso do enumerador `AvaliacoesEmpresaLoadResponse`.
    */
    static func getAvaliacoesEmpresa(empresaId: String, completion: @escaping (AvaliacoesEmpresaLoadResponse) -> Void) {
        
        let BASE_URL: String = RequestConstants.GETAVALIACAOEMPRESA + empresaId
        
        //Valida a URL
        guard let url = URL(string: BASE_URL) else {
            completion(AvaliacoesEmpresaLoadResponse.error(description: "URL not initiated"))
            return
        }
        
        //Faz a chamada no Servidor
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let jsonData = data else {
                completion(AvaliacoesEmpresaLoadResponse.error(description: "Error to unwrapp data variable"))
                return
            }
            
            if let avaliacoesEmpresas = try? JSONDecoder().decode([AvaliacaoCodable].self, from: jsonData) {
                completion(AvaliacoesEmpresaLoadResponse.success(avaliacoesEmpresa: avaliacoesEmpresas))
            } else {
                completion(AvaliacoesEmpresaLoadResponse.error(description: "Error to convert data to [Empresa]"))
            }
        }).resume()
    }
    
    /**
    Função que deleta uma avaliação no servidor.
    
    - parameters:
        - uuid: Identificador do usuário que requisitou a exclusão da avaliação.
        - avaliacaoId: String que representa o identificador da avaliação que está sendo excluída.
        - completion: Closure que é chamada com um vetor opcional de strings como Any e um Error opcional.
    */
    func deleteAvaliacao(uuid: String, avaliacaoId: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let parameters = ["uuid": uuid, "avaliacaoId": avaliacaoId] as [String: Any]
        guard let url = URL(string: RequestConstants.POSTDELETEAVALIACAO) else {
            return
        }
        let session = URLSession.shared
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            //pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                do {
                    print(data as Any)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: [])
                        if let safeJson = json as? [String: Any] {
                            print(safeJson)
                            for (key, value) in safeJson {
                                if key == "result" {
                                    if value as? Int == 0 {
                                        completion(nil, nil)
                                    } else {
                                        completion(safeJson, nil)
                                    }
                                } else {
                                    completion(nil, nil)
                                }
                            }
                        }
                        } else {
                        print("no file")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
        })
        task.resume()
    }
    
    /**
    Função que atualiza uma avaliação no servidor.
    
    - parameters:
        - uuid: Identificador do usuário que requisitou a atualização da avaliação.
        - avaliacaoId: String que representa o identificador da avaliação que está sendo atualizada.
        - completion: Closure que é chamada com um vetor opcional de strings como Any e um Error opcional.
    */
    
    func updateAvaliacao(uuid: String, avaliacao: AvaliacaoCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let avaliacaoParams = ["titulo": avaliacao.titulo as Any,
                               "data": avaliacao.data as Any,
                               "cargo": avaliacao.cargo as Any,
                               "tempoServico": avaliacao.tempoServico as Any,
                               "pros": avaliacao.pros as Any,
                               "contras": avaliacao.contras as Any,
                               "melhorias": avaliacao.melhorias as Any,
                               "ultimoAno": avaliacao.ultimoAno as Any,
                               "recomenda": avaliacao.recomenda as Any,
                               "integracaoEquipe": avaliacao.integracaoEquipe as Any,
                               "culturaValores": avaliacao.culturaValores as Any,
                               "renumeracaoBeneficios": avaliacao.renumeracaoBeneficios as Any,
                               "oportunidadeCrescimento": avaliacao.oportunidadeCrescimento as Any,
                               "deficienciaMotora": avaliacao.deficienciaMotora as Any,
                               "deficienciaVisual": avaliacao.deficienciaVisual as Any,
                               "deficienciaAuditiva": avaliacao.deficienciaAuditiva as Any,
                               "deficienciaIntelectual": avaliacao.deficienciaIntelectual as Any,
                               "nanismo": avaliacao.nanismo as Any,
                               "uuid": uuid,
                               "estadoPendenteAvaliacao": avaliacao.estadoPendenteAvaliacao as Any] as [String: Any]
        
        guard let url = URL(string: RequestConstants.POSTUPDATEAVALIACAO + String(describing: avaliacao._id ?? "")) else {
            print("erro na construcao da url")
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: avaliacaoParams, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                do {
                    print(data as Any)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: [])
                        if let safeJson = json as? [String: Any] {
                            print(safeJson)
                            for (key, value) in safeJson {
                                if key == "result" {
                                    if value as? Int == 0 {
                                        completion(nil, nil)
                                    } else {
                                        completion(safeJson, nil)
                                    }
                                } else {
                                    completion(nil, nil)
                                }
                            }
                        } else {
                            print("no file")
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
        })
        task.resume()
        
    }
}
