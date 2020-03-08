//
//  CreateBoxViewController.swift
//  lab3
//
//  Created by Асан Шакабаев on 3/7/20.
//  Copyright © 2020 Асан Шакабаев. All rights reserved.
//

import UIKit

class CreateBoxViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataShow()
        navBarItems()
    }

    
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var x: UITextField!
    @IBOutlet weak var y: UITextField!
    var color: UIColor?
    var selectBox: UIView?
    
    
    func navBarItems() {
        let deleteButton = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(DeleteBtn))
        let addButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(SaveBtn(_:)))

        guard selectBox != nil else {
            navigationItem.rightBarButtonItems = [ addButton]
            return
        }
        navigationItem.rightBarButtonItems = [deleteButton, addButton]
    }
    
    func dataShow(){
        
        guard let figure = selectBox else {return}
        print(figure.frame.width)
        self.width.text = figure.frame.width.description
        self.height.text = figure.frame.height.description
        self.x.text = figure.frame.origin.x.description
        self.y.text = figure.frame.origin.y.description
    }
    
    @IBAction func ChooseColor(_ sender: UIButton) {
        
        
        sender.isSelected = true;
        
        guard let backcolor = sender.backgroundColor else {return}
        color=backcolor
    }
    var onSave:((CGFloat, CGFloat,CGFloat,CGFloat,UIColor)-> Void)? = nil
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        guard
            let widthText=width.text,
            let dblwidth = Double(widthText),
            let heightText=height.text,
            let dblheight = Double(heightText),
            let yText=y.text,
            let dbly = Double(yText),
            let xText=x.text,
            let dblx = Double(xText),
            let selectedColor = self.color
        else {
            let alert = UIAlertController(title: "Error", message: "please, fill all inputs",  preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if CGFloat(dblwidth) > screenWidth || CGFloat(dblheight) > screenHeight || CGFloat(dblx) > screenWidth || CGFloat(dbly) > screenHeight {
            let alert = UIAlertController(title: "Error", message: "Data is bigger than view", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard selectBox != nil else {
            onSave?(CGFloat(dblx), CGFloat(dbly), CGFloat(dblwidth), CGFloat(dblheight), selectedColor)

            self.navigationController?.popViewController(animated: true)
            print("Second one")
            print((CGFloat(dblx), CGFloat(dbly), CGFloat(dblwidth), CGFloat(dblheight), selectedColor))
            return
        }
        
        selectBox?.backgroundColor = color
        selectBox?.frame = CGRect(x: CGFloat(dblx), y: CGFloat(dbly), width: CGFloat(dblwidth), height: CGFloat(dblheight))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DeleteBtn(_ sender: UIButton) {
        guard let i = selectBox else {return}
        i.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
}
