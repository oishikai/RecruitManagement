//
//  EventType.swift
//  RecuruitManagement
//
//  Created by Kai on 2021/05/23.
//

import Foundation
import UIKit

    enum EventType: Int16, CaseIterable{
        case informationSession
        case symposium
        case writtenTest
        case aptitudeTest
        case practicaltask
        case presentation
        case groupWork
        case groupDiscussion
        case groupInterview
        case interview
        case finalInterview
        
        var name: String {
            switch self {
            case .informationSession: return "会社説明会"
            case .symposium: return "座談会"
            case .writtenTest: return "筆記試験"
            case .aptitudeTest: return "適正検査"
            case .practicaltask: return "実技課題"
            case .presentation: return "プレゼン発表"
            case .groupWork: return "グループワーク"
            case .groupDiscussion: return "グループディスカッション"
            case .groupInterview: return "集団面接"
            case .interview: return "面接"
            case .finalInterview: return "最終面接"
            }
        }
        
        var image: UIImage {
            switch self {
            case .informationSession:
                return UIImage(named: "Session")!
            case .symposium:
                return UIImage(named: "Symposium")!
            case .writtenTest:
                return UIImage(named: "Test")!
            case .aptitudeTest:
                return UIImage(named: "Test")!
            case .practicaltask:
                return UIImage(named: "Test")!
            case .presentation:
                return UIImage(named: "Session")!
            case .groupWork:
                return UIImage(named: "Discuss")!
            case .groupDiscussion:
                return UIImage(named: "Discuss")!
            case .groupInterview:
                return UIImage(named: "Interview")!
            case .interview:
                return UIImage(named: "Interview")!
            case .finalInterview:
                return UIImage(named: "Interview")!
            }
        }

        static func getEventType(name: String) -> EventType? {
            let types = EventType.allCases.compactMap({$0.name})
            if let index = types.firstIndex(of: name) {
                return EventType.allCases[index]
            }
            return nil
        }
    }

