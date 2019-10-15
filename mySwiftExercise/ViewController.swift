//
//  ViewController.swift
//  mySwiftExercise
//
//  Created by PaleCosmos on 2019/10/15.
//  Copyright © 2019 PaleCosmos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //click event
    
    @IBAction func onClick(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "detailController"){
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}

