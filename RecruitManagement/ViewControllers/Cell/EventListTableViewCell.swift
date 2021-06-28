//
//  EventListTableViewCell.swift
//  RecuruitManagement
//
//  Created by Kai on 2021/05/20.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventIcon: UIImageView!
    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var locateIcon: UIImageView!
    @IBOutlet weak var memoIcon: UIImageView!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocateLabel: UILabel!
    @IBOutlet weak var eventMemoLabel: UILabel!
    static var formatt = "MM月dd日HH時mm分"
    static let cellIdentifier = String(describing: EventListTableViewCell.self)
    let star = UIImage(named: "AspirationStar")
    
    let locate = UIImage(named: "Locate")
    let pencil = UIImage(named: "Pencil")
    let clock = UIImage(named: "Clock")
    
    func setup(event:Event) {
        eventNameLabel.text = EventType(rawValue: event.eventType)!.name
        let strDate = stringFromDate(date: event.eventDate!, format: "MM/dd HH:mm")
        eventDateLabel.text = strDate
        eventLocateLabel.text = event.eventLocate
        if event.eventMemo != nil {
            eventMemoLabel.text = event.eventMemo
        }else {
            eventMemoLabel.text = "---"
        }
        eventIcon.image = EventType(rawValue: event.eventType)!.image
        dateIcon.image = clock
        locateIcon.image = locate
        memoIcon.image = pencil
        
    }
    
    func stringFromDate(date: Date, format: String) -> String {
            let formatter: DateFormatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
}
