//
//  Switcher.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 15/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC() {
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC: UIViewController?
        
        if status == true {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainvc")
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as? LoginVC
        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = rootVC
        
    }
    
}
