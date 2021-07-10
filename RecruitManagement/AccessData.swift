//
//  Access.swift
//  RecuruitManagement
//
//  Created by Kai on 2021/05/14.
//

import UIKit
import CoreData

class AccessData: UIViewController {
        
    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static func getCompanies() ->[Company]? {
        var companies:[Company] = []
        let dataCondition = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        do{
            companies = try managedObjectContext.fetch(dataCondition) as! [Company]
            return companies
        }catch{
            print("エラーだよ")
        }
        return nil
    }
    
    static func canUnwrapDatas(dataArray: [String?]) -> Bool {
        return dataArray.filter({$0?.isEmpty ?? true}).count == 0
    }
    
    static func saveNewCompany(name: String, url: String, aspiration: String, status:SelectStatus) -> Void {
        var companies:[Company] = []
        let comp = AccessData.getCompanies()
        guard comp != nil else {
            print("accessError")
            return
        }
        companies = comp!
        
        let newCompany = Company(context: self.managedObjectContext)
        newCompany.companyName = name
        newCompany.url = url
        newCompany.aspiration = aspiration
        newCompany.selectionStatus = status.rawValue
        newCompany.companyId = UUID().uuidString
        companies.append(newCompany)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    static func saveNewEvent(company:Company, type: EventType, date:Date, locate:String, memo:String? = nil) -> Void {
        let newEvent = Event(context: self.managedObjectContext)
        newEvent.eventType = type.rawValue
        newEvent.eventLocate = locate
        newEvent.eventDate = date
        newEvent.eventId = UUID().uuidString
        if let eventMemo = memo {
            newEvent.eventMemo = eventMemo
        }
        company.addToEvent(newEvent)
    }
    
    static func updateSelectionStatus(company: Company, status: SelectStatus) {
        let dataCondition = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        let predict = NSPredicate(format: "%K = %@","selectionStatus", company.selectionStatus)
        dataCondition.predicate = predict
        do {
            let results = try managedObjectContext.fetch(dataCondition)
            for myData in results {
                managedObjectContext.setValue(status, forKey: "selectionStatus")
                }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }catch{
            
        }
    }
    static func deleteCompany(company: Company){
        let dataCondition = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        let predict = NSPredicate(format: "%K = %@","companyName", company.companyName!)
        dataCondition.predicate = predict
        do {
            let results = try managedObjectContext.fetch(dataCondition)
            for myData in results {
                managedObjectContext.delete(myData as! Company)
                }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }catch{
            
        }
    }
    
    static func deleteEvent(company:Company, event:Event) {
        let dataCondition = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        let predict = NSPredicate(format: "%K = %@","eventId", event.eventId!)
        dataCondition.predicate = predict
        do {
            let results = try managedObjectContext.fetch(dataCondition)
            for myData in results {
                managedObjectContext.delete(myData as! Event)
                }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }catch{
            
        }
    }
}
