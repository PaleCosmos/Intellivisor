//
//  ComposeViewController.swift
//  Intellivisor
//
//  Created by PaleCosmos on 2019/10/25.
//  Copyright © 2019 PaleCosmos. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
        let data = memoTextView?.text ?? ""
        
        if(data.isNotBlank())
        {
            DataManager.shared.addNewMemo(data)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
