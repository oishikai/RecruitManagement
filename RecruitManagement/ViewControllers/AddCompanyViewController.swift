//
//  ViewController.swift
//  RecuruitManagement
//
//  Created by Kai on 2021/05/13.
//

import UIKit

class AddCompanyViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var aspirationField: UITextField!
    @IBOutlet weak var addCompButton: UIButton! {
        didSet {
            addCompButton.isEnabled = false
        }
    }
    
    var pickerView: UIPickerView = UIPickerView()
    let aspiration = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "企業を追加する"
        
        companyNameField.delegate = self
        urlField.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 44))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        let toolbarbuttongap = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([toolbarbuttongap, doneItem], animated: true)
        
        self.aspirationField.inputView = pickerView
        self.aspirationField.inputAccessoryView = toolbar
        
    }
    
    @IBAction func addCompanyButton(_ sender: Any) {

        guard let companyURL = URL(string: urlField.text!) else { return }
        
//        AccessData.saveNewCompany(name: companyNameField.text!, url: companyURL, aspiration: aspirationField.text!)
//        DispatchQueue.main.async {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if AccessData.canUnwrapDatas(dataArray: [companyNameField.text,urlField.text,aspirationField.text]){
            addCompButton.isEnabled = true
        }
        print("called")
        return true
    }
}

extension AddCompanyViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aspiration.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return aspiration[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.aspirationField.text = aspiration[row]
    }
    
    @objc func done() {
        self.aspirationField.endEditing(true)
        if AccessData.canUnwrapDatas(dataArray: [companyNameField.text,urlField.text,aspirationField.text]){
            addCompButton.isEnabled = true
        }
    }
    
}
