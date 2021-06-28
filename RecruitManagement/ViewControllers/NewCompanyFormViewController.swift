//
//  NewCompanyFormViewController.swift
//  RecruitManagement
//
//  Created by Kai on 2021/05/18.
//

import UIKit
import Eureka

class NewCompanyFormViewController: FormViewController {
    
    var companyName:String?
    var companyURL:String?
    var aspiration:String?
    var selectionStatus:SelectStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "企業を追加する"
        form +++ Section("会社の情報")
            <<< TextRow(){ row in
                row.title = "企業名"
                row.placeholder = ""
            }.onChange() { row in
                if let name = row.value {
                    self.companyName = name
                }
            }
            
            <<< TextRow(){ row in
                row.title = "URL"
                row.placeholder = ""
            }.onChange() { row in
                if let url = row.value {
                    self.companyURL = url
                }
            }
            +++ Section("あなたの状況")
            <<< SegmentedRow<String>() { row in
                row.title = "志望度"
                row.options = ["1","2","3","4","5"]
            }.onChange{[unowned self] row in
                if let aspi = row.value {
                    self.aspiration = aspi
                }
            }
            
            <<< ActionSheetRow<String>(){ row in
                row.title = "現在の状況"
                row.options = SelectStatus.allCases.compactMap({$0.name})
            }.onChange{[unowned self] row in
                guard let value = row.value, let eventStatus = SelectStatus.getEventType(name: value) else { return }
                self.selectionStatus = eventStatus
            }
            +++ Section("会社の追加を確定する")
            
            <<< ButtonRow("") {row in
                row.title = "新しい会社を追加"
                row.onCellSelection{[unowned self] ButtonCellOf, row in
                    if AccessData.canUnwrapDatas(dataArray: [companyName,aspiration,]){
                        guard selectionStatus != nil  else { return }
                        AccessData.saveNewCompany(name: companyName!, url: companyURL!, aspiration: aspiration!, status: selectionStatus!)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
    }
    
}
