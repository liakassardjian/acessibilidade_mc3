//
//  RequestConstants.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 02/09/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

/**
 Struct que possui as constantes de Request com o servidor que são utilizados em outros trechos de código.
 */
struct RequestConstants {
    /**
     URL da API do servidor.
     */
    static let URL = "https://br-empresa-acessivel.herokuapp.com/api/"
    
    /**
    Endereço para trazer as empresas do servidor.
    */
    static let GETEMPRESAS = "\(RequestConstants.URL)empresas"
    
    /**
    Endereço para trazer uma empresa pelo nome do servidor.
    */
    static let GETEMPRESA = "\(RequestConstants.URL)empresaNome/"
    
    /**
    Endereço para criar uma empresa no servidor.
    */
    static let POSTEMPRESA = "\(RequestConstants.URL)createEmpresa"
    
    /**
    Endereço para atualizar uma empresa no servidor.
    */
    static let PUTEMPRESA = "\(RequestConstants.URL)updateEmpresa/"
    
    /**
    Endereço para enviar uma avaliação ao servidor.
    */
    static let POSTAVALIACAO = "\(RequestConstants.URL)createAvaliacao/"
    
    /**
    Endereço para deletar uma avaliação do servidor.
    */
    static let POSTDELETEAVALIACAO = "\(RequestConstants.URL)deleteAvaliacao"
    
    /**
    Endereço para atualizar uma avaliação do servidor.
    */
    static let PUTAVALIACAO = "\(RequestConstants.URL)updateAvaliacao/"
    
    /**
    Endereço para buscar as avaliações de uma empresa no servidor.
    */
    static let GETAVALIACAOEMPRESA = "\(RequestConstants.URL)avavaliacoes/"
    
    /**
    Endereço para criar um usuário no servidor.
    */
    static let POSTUSUARIO = "\(RequestConstants.URL)createUsuario"
}
