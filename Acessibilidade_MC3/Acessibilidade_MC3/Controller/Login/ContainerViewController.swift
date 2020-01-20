//
//  ContainerViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 19/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    weak var superView: LoginUsuarioViewController?
    
    var usuarioLogado: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.superView?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    var novoUsuario: Bool = false {
        didSet {
            updateView()
        }
    }
    
    private lazy var loginViewController: LoginVC = {
            // Load Storyboard
            let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)

            // Instantiate View Controller
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "loginvc") as? LoginVC else { return LoginVC() }
        
        viewController.superView = self

            // Add View Controller as Child View Controller
            self.add(asChildViewController: viewController)

            return viewController
        }()

    private lazy var cadastroViewController: RegisterVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)

        // Instantiate View Controller
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "registervc") as? RegisterVC else { return RegisterVC() }
        
        viewController.superView = self

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        novoUsuario = false
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if novoUsuario {
            remove(asChildViewController: loginViewController)
            add(asChildViewController: cadastroViewController)
        } else {
            remove(asChildViewController: cadastroViewController)
            add(asChildViewController: loginViewController)
        }
    }

}
