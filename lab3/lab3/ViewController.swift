//
//  ViewController.swift
//  lab3
//
//  Created by Асан Шакабаев on 3/6/20.
//  Copyright © 2020 Асан Шакабаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addButton))
    }
    
    @objc func addButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        
        guard let createBoxController = storyboard.instantiateViewController(identifier: "CreateBoxViewController") as? CreateBoxViewController else {return}
        self.navigationController?.pushViewController(createBoxController, animated: true)
        
        createBoxController.onSave = {(x,y,width,height,color) in
            let figure = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            figure.backgroundColor = color
            self.view.addSubview(figure)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.figureDidTap))
            figure.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.figureDidPan(recognizer:)))
            figure.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.figureDidPinch))
            figure.addGestureRecognizer(pinchGestureRecognizer)
        }
    }
    @objc func figureDidTap(_ recognizer: UITapGestureRecognizer) {
        let newView = recognizer.view!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createBoxViewController = storyboard.instantiateViewController(identifier: "CreateBoxViewController") as CreateBoxViewController
        createBoxViewController.selectBox = newView
        navigationController?.pushViewController(createBoxViewController, animated: true)
    }
    
    var baseOrigin: CGPoint!
    @objc func figureDidPan(recognizer: UIPanGestureRecognizer) {
        let newView = recognizer.view!
        let translation = recognizer.translation(in: view)
        switch recognizer.state {
        case .changed:
            newView.center = CGPoint(x: newView.center.x + translation.x, y: newView.center.y + translation.y)
            recognizer.setTranslation(CGPoint.zero, in: view)
        default:
            break
        }
    }
    
    @objc func figureDidPinch(_ recognizer: UIPinchGestureRecognizer) {
        recognizer.view?.transform = ((recognizer.view?.transform.scaledBy(x: recognizer.scale, y: recognizer.scale))!)
        recognizer.scale = 1
    }
    
}

