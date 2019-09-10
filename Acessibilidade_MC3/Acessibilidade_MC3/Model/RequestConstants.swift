//
//  RequestConstants.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

struct RequestConstants {
    static let URL = "https://br-empresa-acessivel.herokuapp.com/api/"
    static let GETEMPRESAS = "\(RequestConstants.URL)empresas"
    static let GETEMPRESA = "\(RequestConstants.URL)empresaNome/"
    
    static let POSTEMPRESA = "\(RequestConstants.URL)createEmpresa"
    
    static let PUTEMPRESA = "\(RequestConstants.URL)updateEmpresa/"
    
    static let POSTAVALIACAO = "\(RequestConstants.URL)createAvaliacao/"
    static let POSTDELETEAVALIACAO = "\(RequestConstants.URL)deleteAvaliacao"
    
    static let GETAVALIACAOEMPRESA = "\(RequestConstants.URL)avavaliacoes/"
    
    static let POSTUSUARIO = "\(RequestConstants.URL)createUsuario"
}
