//
//  AvaliarDeficienciasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarDeficienciasViewController: UIViewController {
    
    var avaliacao: Avaliacao?
    var empresa: Empresa?
    var acessibilidadesImages: [UIImageView] = []
    var acessibilidadesTextos: [String] = []
    
    var acessibilidadeFisica: Bool = false
    @IBOutlet weak var siaImageView: UIImageView!
    @IBAction func alteraFisico(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIA"), let trueImage = UIImage(named: "SIACheck") {
            acessibilidadeFisica = alteraAcessibilidade(acessivel: acessibilidadeFisica,
                                                        imagemFalse: falseImage,
                                                        imagemTrue: trueImage,
                                                        imageView: siaImageView)
        }
    }
    
    var acessibilidadeVisual: Bool = false
    @IBOutlet weak var sidvImageView: UIImageView!
    @IBAction func alteraVisual(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIDV"), let trueImage = UIImage(named: "SIDVCheck") {
            acessibilidadeVisual = alteraAcessibilidade(acessivel: acessibilidadeVisual,
                                                        imagemFalse: falseImage,
                                                        imagemTrue: trueImage,
                                                        imageView: sidvImageView)
        }
    }
    
    var acessibilidadeAuditiva: Bool = false
    @IBOutlet weak var sidaImageView: UIImageView!
    @IBAction func alteraAuditiva(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIDA"), let trueImage = UIImage(named: "SIDACheck") {
            acessibilidadeAuditiva = alteraAcessibilidade(acessivel: acessibilidadeAuditiva,
                                                          imagemFalse: falseImage,
                                                          imagemTrue: trueImage,
                                                          imageView: sidaImageView)
        }
    }
    
    var acessibilidadeIntelectual: Bool = false
    @IBOutlet weak var sdiImageView: UIImageView!
    @IBAction func alteraIntelectual(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SDI"), let trueImage = UIImage(named: "SDICheck") {
            acessibilidadeIntelectual = alteraAcessibilidade(acessivel: acessibilidadeIntelectual,
                                                             imagemFalse: falseImage,
                                                             imagemTrue: trueImage,
                                                             imageView: sdiImageView)
        }
    }
    
    var acessibilidadeNanismo: Bool = false
    @IBOutlet weak var spnImageView: UIImageView!
    @IBAction func alteraNanismo(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SPN"), let trueImage = UIImage(named: "SPNCheck") {
            acessibilidadeNanismo = alteraAcessibilidade(acessivel: acessibilidadeNanismo,
                                                         imagemFalse: falseImage,
                                                         imagemTrue: trueImage,
                                                         imageView: spnImageView)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acessibilidadesImages = [siaImageView, sidvImageView, sidaImageView, sdiImageView, spnImageView]
        acessibilidadesTextos = ["pessoas com deficiência fisíca", "pessoas com deficiência visual","pessoas com deficiência auditiva","pessoas com deficiência intelectual","pessoas com nanismo"]
        
        for imageView in acessibilidadesTextos {
            imageView.accessibilityValue = "\(acessibilidadesTextos) não disponível"
        }
        
        siaImageView.alpha = 0.5
        sidvImageView.alpha = 0.5
        sidaImageView.alpha = 0.5
        sdiImageView.alpha = 0.5
        spnImageView.alpha = 0.5
    }
    
    func alteraAcessibilidade(acessivel: Bool, imagemFalse: UIImage, imagemTrue: UIImage, imageView: UIImageView) -> Bool {
        if acessivel == false {
            imageView.image = imagemTrue
            imageView.alpha = 1
            imageView.isAccessibilityElement = true
            imageView.accessibilityValue = "disponivel"
            
            return true
        } else {
            imageView.image = imagemFalse
            imageView.alpha = 0.5
            imageView.accessibilityValue = "não disponível"
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.acessibilidadeFisica {
            avaliacao?.acessibilidade.append(.deficienciaMotora)
        }
        
        if self.acessibilidadeVisual {
            avaliacao?.acessibilidade.append(.deficienciaVisual)
        }
        
        if self.acessibilidadeAuditiva {
            avaliacao?.acessibilidade.append(.deficienciaAuditiva)
        }
        
        if self.acessibilidadeIntelectual {
            avaliacao?.acessibilidade.append(.deficienciaIntelectual)
        }
        
        if self.acessibilidadeNanismo {
            avaliacao?.acessibilidade.append(.nanismo)
        }
        
        if let avaliarTextos = segue.destination as? AvaliarProsViewController {
            avaliarTextos.avaliacao = self.avaliacao
            avaliarTextos.empresa = self.empresa
        }
    }
}
