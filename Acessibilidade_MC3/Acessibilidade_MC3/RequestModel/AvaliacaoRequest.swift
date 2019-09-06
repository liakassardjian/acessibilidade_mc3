//
//  AvaliacaoRequest.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

enum AvaliacoesEmpresaLoadResponse: Error {//varias avaliacoes de um id especifico de empresa
    case success(avaliacoesEmpresa: [AvaliacaoCodable])
    case error(description: String)
}

//enum AvaliacoesUsuarioLoadResponsee: Error {//varias avaliacoes de um id especifico de usuario
//    case success(avaliacoesUsuario: [AvaliacaoCodable])
//    case error(description: String)
//}

import Foundation
class AvaliacaoRequest {
    //sendAvaliacao
    func sendAvaliacao(uuid: String, avaliacao: AvaliacaoCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let avaliacaoParams = ["titulo": avaliacao.titulo as Any,
                               "data": avaliacao.data as Any,
                               "cargo": avaliacao.cargo as Any,
                               "cempoServico": avaliacao.tempoServico as Any,
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
                               "deficienciasVisual": avaliacao.deficienciaVisual as Any,
                               "deficienciaAuditiva": avaliacao.deficienciaAuditiva as Any,
                               "deficienciaIntelectual": avaliacao.deficienciaIntelectual as Any,
                               "nanismo": avaliacao.nanismo as Any] as [String: Any]
        let parameters = ["uuid": uuid, "Avaliacoes": avaliacaoParams] as [String: Any]
        guard let url = URL(string: RequestConstants.POSTAVALIACAO) else {
            return
        }
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
    //READ AVALIACOES DE EMPRESA
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
    //delete
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
}
