//
//  EmpresaRequest.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

//LETTER = AVALIACOES
//USUARIO = USUARIO

enum EmpresasLoadResponse: Error {
    case success(empresas: [EmpresaCodable])
    case error(description: String)
}

enum EmpresaLoadResponse: Error {
    case success(empresa: EmpresaCodable)
    case error(description: String)
}

import Foundation

class EmpresaRequest {
    
    func empresaCreate(uuid: String, empresa: EmpresaCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let empresaParams = ["nome": empresa.nome as Any,
                             "site": empresa.site as Any,
                             "telefone": empresa.telefone as Any,
                             "media": empresa.media as Any,
                             "mediaRecomendacao": empresa.mediaRecomendacao as Any,
                             "cidade": empresa.cidade as Any,
                             "estado": empresa.estado as Any] as [String: Any]
        
        //let parameters = ["uuid": uuid, "Empresas": empresaParams] as [String : Any]

        guard let url = URL(string: RequestConstants.POSTEMPRESA) else {
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: empresaParams, options: .prettyPrinted)
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
    //READ
    
    static func getEmpresas(completion: @escaping (EmpresasLoadResponse) -> Void) {
        
        let BASE_URL: String = RequestConstants.GETEMPRESAS
        
        //Valida a URL
        guard let url = URL(string: BASE_URL) else {
            completion(EmpresasLoadResponse.error(description: "URL not initiated"))
            return
        }
        
        //Faz a chamada no Servidor
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let jsonData = data else {
                completion(EmpresasLoadResponse.error(description: "Error to unwrapp data variable"))
                return
            }
            
            if let empresas = try? JSONDecoder().decode([EmpresaCodable].self, from: jsonData) {
                completion(EmpresasLoadResponse.success(empresas: empresas))
            } else {
                completion(EmpresasLoadResponse.error(description: "Error to convert data to [Empresa]"))
            }
        }).resume()
    }
    
    static func getEmpresa(idEmpresa: String, completion: @escaping (EmpresaLoadResponse) -> Void) {
        
        let BASE_URL: String = RequestConstants.GETEMPRESA + idEmpresa
        
        //Valida a URL
        guard let url = URL(string: BASE_URL) else {
            completion(EmpresaLoadResponse.error(description: "URL not initiated"))
            return
        }
        
        //Faz a chamada no Servidor
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let jsonData = data else {
                completion(EmpresaLoadResponse.error(description: "Error to unwrapp data variable"))
                return
            }
            
            if let empresas = try? JSONDecoder().decode(EmpresaCodable.self, from: jsonData) {
                completion(EmpresaLoadResponse.success(empresa: empresas))
            } else {
                completion(EmpresaLoadResponse.error(description: "Error to convert data to [Empresa]"))
            }
        }).resume()
    }
    
    //update empresa
    func updateEmpresa(uuid: String, empresa: EmpresaCodable, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let empresaParams = ["nome": empresa.nome ?? "",
                             "site": empresa.site ?? "",
                             "telefone": empresa.telefone ?? "",
                             "media": empresa.media ?? "",
                             "mediaRecomendacao": empresa.mediaRecomendacao ?? "",
                             "cidade": empresa.cidade ?? "",
                             "estado": empresa.estado ?? ""] as [String: Any]
        //let parameters = ["uuid": uuid, "Empresas": empresaParams] as [String: Any]
        guard let url = URL(string: RequestConstants.PUTEMPRESA + String(describing: empresa._id ?? "")) else {
            print("erro na construcao da url")
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: empresaParams, options: .prettyPrinted)
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
