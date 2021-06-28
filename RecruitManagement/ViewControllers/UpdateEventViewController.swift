//
//  UpdateEventViewController.swift
//  RecruitManagement
//
//  Created by Kai on 2021/05/23.
//

import UIKit
import Eureka

class UpdateEventViewController: FormViewController {
    
    var event:Event = Event()
    var company:Company!
    
    var eventType:EventType?
    var eventDate:Date?
    var eventLocate:String?
    var eventMemo:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "イベント情報を更新"
        form +++ Section("イベントの情報")
            <<< PushRow<String> {
                $0.title = "イベント内容"
                $0.options = EventType.allCases.compactMap({$0.name})
                $0.value = EventType(rawValue: event.eventType)!.name
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
                row.placeholder = "\(event.eventLocate!)"
            }.onChange() { row in
                if let locate = row.value {
                    self.eventLocate = locate
                }
            }
            +++ Section("メモ")
            
            <<< TextAreaRow(){ row in
                row.placeholder = "詳細を入力する"
                if let memo = eventMemo {
                    row.value = memo
                }
            }.onChange() { row in
                if let memo = row.value {
                    self.eventMemo = memo
                }
            }
            
            +++ Section("イベントの更新を確定する")
            <<< ButtonRow("フォームを送信") {row in
                row.title = "イベント情報更新"
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

