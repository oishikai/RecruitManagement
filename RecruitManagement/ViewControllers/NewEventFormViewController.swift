//
//  ViewController.swift
//  RecruitManagement
//
//  Created by Kai on 2021/05/18.
//

import UIKit
import Eureka

class NewEventFormViewController: FormViewController {
    
    var eventType:EventType?
    var eventDate:Date?
    var eventLocate:String?
    var eventMemo:String?
    
    var company:Company!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "イベント追加"
        form +++ Section("イベントの情報")
            <<< PushRow<String> {
                $0.title = "イベント内容"
                $0.options = EventType.allCases.compactMap({$0.name})
            }.onChange() { row in
                guard let value = row.value, let eventType = EventType.getEventType(name: value) else { return }
                self.eventType = eventType
            }
            
            <<< DateTimeInlineRow(){
                $0.title = "日時"
            }.onChange() { row in
                self.eventDate = row.value!
            }
            
            <<< TextRow(){ row in
                row.title = "場所"
                row.placeholder = ""
            }.onChange() { row in
                if let locate = row.value {
                    self.eventLocate = locate
                }
            }
            +++ Section("メモ")
            
            <<< TextAreaRow(){ row in
                row.placeholder = "詳細を入力する"
            }.onChange() { row in
                if let memo = row.value {
                    self.eventMemo = memo
                }
            }
            
            +++ Section("イベントの追加を確定する")
            <<< ButtonRow("フォームを送信") {row in
                row.title = "イベント追加"
                row.onCellSelection{[unowned self] ButtonCellOf, row in
                    if AccessData.canUnwrapDatas(dataArray: [eventLocate]) {
                        AccessData.saveNewEvent(company: company, type: eventType!, date: eventDate!, locate: eventLocate!, memo: eventMemo)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
    }
}
