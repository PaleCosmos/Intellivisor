//
//  ComposeViewController.swift
//  Intellivisor
//
//  Created by PaleCosmos on 2019/10/25.
//  Copyright © 2019 PaleCosmos. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var editTarget: Memo?
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
        let data = memoTextView?.text ?? ""
        
        if let editTarget = editTarget{
            editTarget.content = data
            DataManager.shared.saveContext()
        }else{
            if(data.isNotBlank())
            {
                DataManager.shared.addNewMemo(data)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    var willShowToken : NSObjectProtocol?
    var willHideToken : NSObjectProtocol?
    
    deinit{
        if let token = willShowToken{
            NotificationCenter.default.removeObserver(token)
        }
        
        if let token = willHideToken{
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let memo = editTarget{
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
        }else{
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }
        
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            guard let strongSelf = self else{return}
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
                let height = frame.cgRectValue.height
                var inset = strongSelf.memoTextView.contentInset
                inset.bottom = height
                
                strongSelf.memoTextView.contentInset = inset
                
                inset = strongSelf.memoTextView.verticalScrollIndicatorInsets
                inset.bottom = height
                
                strongSelf.memoTextView.scrollIndicatorInsets = inset
            }
        })
        
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            guard let strongSelf = self else{return}
            var inset = strongSelf.memoTextView.contentInset
            inset.bottom = 0
            
            strongSelf.memoTextView.contentInset = inset
            
            inset = strongSelf.memoTextView.verticalScrollIndicatorInsets
            inset.bottom = 0
            
            strongSelf.memoTextView.scrollIndicatorInsets = inset
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memoTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        memoTextView.resignFirstResponder()
    }
    
}
