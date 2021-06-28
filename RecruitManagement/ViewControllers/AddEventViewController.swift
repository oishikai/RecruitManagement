//
//  AddEventViewController.swift
//  RecuruitManagement
//
//  Created by Kai on 2021/05/15.
//

import UIKit
import CoreData

class AddEventViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var eventLocateField: UITextField!
    @IBOutlet weak var eventMemoText: UITextView!
    @IBOutlet weak var addNewEventButton: UIButton!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var company:Company!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "イベントを追加する"
        
        eventNameField.delegate = self

    }
    
    @IBAction func addNewEventButton(_ sender: Any) {
        guard !(eventNameField.text?.isEmpty ?? true) else {
            print("Name is Empty or nil")
            return
        }
        let newEvent = Event(context: self.managedObjectContext)
        newEvent.eventName = eventNameField.text
        company.addToEvent(newEvent)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
