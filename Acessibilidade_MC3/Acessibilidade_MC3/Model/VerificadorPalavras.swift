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
            let texto = try String(contentsOfFile: "lista-palavroes-bloqueio.txt", encoding: .utf8)
            self.palavras = texto.components(separatedBy: "\n")
        } catch {
            palavras = []
            print("Erro ao ler arquivo")
        }
    }
    
    public func verificaPalavras(texto: String) -> Bool {
        return palavras.reduce(false) { $0 || texto.contains($1.lowercased()) }
    }
}
