//
//  DetailViewController.swift
//  Intellivisor
//
//  Created by PaleCosmos on 2019/10/25.
//  Copyright © 2019 PaleCosmos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var memo:Memo?
    
    @IBOutlet weak var memoTableView: UITableView!
    
    let formatter:DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        f.locale = Locale(identifier: "KO_kr")
        return f
    }()
    
    @IBAction func share(_ sender: Any) {
        guard let memo = memo?.content else {
            return
        }
        
        let vc = UIActivityViewController(activityItems: [ memo], applicationActivities: nil)
        
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController
        {
            vc.editTarget = memo;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memoTableView.reloadData()
    }
    
    
    @IBAction func deleteMemo(_ sender: Any) {
        present(UIAlertController(title: "삭제 확인", message: "메모를 삭제할까요?", preferredStyle: .alert).apply{ it in
            it.addAction(UIAlertAction(title: "삭제", style: .destructive){ (action) in
                DataManager.shared.deleteMemo(self.memo)
                self.navigationController?.popViewController(animated: true)
            })
            it.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        }, animated: true, completion: nil)
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

extension DetailViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath)
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
        default:
            fatalError()
        }
        
    }
    
}
