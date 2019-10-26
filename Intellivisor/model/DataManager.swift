//
//  DataManager.swift
//  Intellivisor
//
//  Created by PaleCosmos on 2019/10/25.
//  Copyright © 2019 PaleCosmos. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject{
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}

class DataManager
{
    
    static let shared = DataManager()
    private init(){}
    
    var mainContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    func fetchMemo(){
        let request:NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key : "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do{
            memoList = try mainContext.fetch(request)
        }catch{
            print(error)
        }
    }
    
    func addNewMemo(_ memo:String?)
    {
        let newMemo = Memo(context: mainContext)
        
        newMemo.content = memo
        newMemo.insertDate = Date()
        
        saveContext()
    }
    
    func deleteMemo(_ memo:Memo?)
    {
        if let memo = memo{
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: {
            (storeDescriptrion, error) in
            if (error as NSError?) != nil{
                fatalError()
            }
        })
        return container
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                if (error as NSError?) != nil{
                    fatalError()
                    
                }
            }
        }
    }
}
