//
//  BarraProgressoView.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
 Representação visual de uma barra de progresso ajustável.
 
 A classe herda de `UIView`.
 */
@IBDesignable
class BarraProgressoView: UIView {
    
    /**
     `CGFloat` correspondente ao comprimento total da linha.
     */
    @IBInspectable
    var comprimentoLinha: CGFloat = 10.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /**
     `CGFloat` correspondente ao valor do progresso até o momento.
    */
    @IBInspectable
    var valorProgresso: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /**
     Cor da linha base da barra.
    */
    @IBInspectable
    var corLinha: UIColor = #colorLiteral(red: 0.6027947068, green: 0.6290434003, blue: 0.6537475586, alpha: 0.6)
    
    /**
     Cor da linha de progresso da barra.
     */
    @IBInspectable
    var corProgresso: UIColor = #colorLiteral(red: 1, green: 0.7469202876, blue: 0.3515547514, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        comprimentoLinha = rect.height
        
        //Important constants for circle
        let inicio: CGPoint = CGPoint(x: rect.minX, y: rect.midY)
        let fim: CGPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        //Calculating end point of progress bar
        let espaco: CGFloat = fim.x - inicio.x
        let fimProgresso = CGPoint(x: inicio.x + espaco * valorProgresso, y: fim.y)
        
        //starting point for all drawing code is getting the context.
        let contexto = UIGraphicsGetCurrentContext()
        
        //set line attributes
        contexto?.setLineWidth(comprimentoLinha)
        
        // Draw the MAIN line
        contexto?.setStrokeColor(corLinha.cgColor)
        contexto?.move(to: CGPoint(x: inicio.x, y: inicio.y))
        contexto?.addLine(to: CGPoint(x: fim.x, y: fim.y))
        contexto?.strokePath()
        
        // Draw the PROGRESS line
        contexto?.setStrokeColor(corProgresso.cgColor)
        contexto?.move(to: CGPoint(x: inicio.x, y: inicio.y))
        contexto?.addLine(to: CGPoint(x: fimProgresso.x, y: fimProgresso.y))
        contexto?.strokePath()
    }
}
