//
//  VerificadorPalavras.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 21/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

class VerificadorPalavras {
    var palavras: [String]
    
    static let shared = VerificadorPalavras()
    
    private init() {
        do {
            let caminho = "/Projetos/Acessibilidade/acessibilidade_mc3/Acessibilidade_MC3/Acessibilidade_MC3/lista-palavroes-bloqueio.txt"
            let texto = try String(contentsOfFile: caminho)
            self.palavras = texto.components(separatedBy: "\n")
        } catch {
            palavras = []
            print("Erro ao ler arquivo")
        }
    }
    
//    public func verificaPalavras(texto: String) -> Bool {
//        let palavrao = palavras.reduce(false) { $0 || texto.contains($1.lowercased()) }
//        return palavrao
//    }
}
