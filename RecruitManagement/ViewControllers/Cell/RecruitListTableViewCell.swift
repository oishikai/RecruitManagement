//
//  CompanyListTableViewCell.swift
//  RecruitManagement
//
//  Created by Kai on 2021/05/19.
//

import UIKit
import FaviconFinder

class RecruitListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyIcon: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var selectionStatus: UILabel!
    
    @IBOutlet weak var star1Image: UIImageView!
    @IBOutlet weak var star2Image: UIImageView!
    @IBOutlet weak var star3Image: UIImageView!
    @IBOutlet weak var star4Image: UIImageView!
    @IBOutlet weak var star5Image: UIImageView!
    
    var aspiration:Int = 0
    
    static let cellIdentifier = String(describing: RecruitListTableViewCell.self)
    
    let star = UIImage(named: "AspirationStar")
    
    func setup(company:Company) {
        companyName.text = company.companyName
        selectionStatus.text = SelectStatus(rawValue: company.selectionStatus)!.name
        aspiration = Int(string: company.aspiration!) ?? 0
        
        star1Image.image = star
        star2Image.image = star
        star3Image.image = star
        star4Image.image = star
        star5Image.image = star
        
        let intAspitarion = Int(string: company.aspiration!)
        switch intAspitarion {
        case 1:
            star1Image.isHidden = false
            star2Image.isHidden = true
            star3Image.isHidden = true
            star4Image.isHidden = true
            star5Image.isHidden = true
        case 2:
            star1Image.isHidden = false
            star2Image.isHidden = false
            star3Image.isHidden = true
            star4Image.isHidden = true
            star5Image.isHidden = true
        case 3:
            star1Image.isHidden = false
            star2Image.isHidden = false
            star3Image.isHidden = false
            star4Image.isHidden = true
            star5Image.isHidden = true
        case 4:
            star1Image.isHidden = false
            star2Image.isHidden = false
            star3Image.isHidden = false
            star4Image.isHidden = false
            star5Image.isHidden = true
        default :
            star1Image.isHidden = false
            star2Image.isHidden = false
            star3Image.isHidden = false
            star4Image.isHidden = false
            star5Image.isHidden = false
            
        }
        if let iconURL = URL(string:company.url!){
            FaviconFinder(url: iconURL).downloadFavicon { [weak self] result in
                switch result {
                case .success(let favicon):
                    self?.companyIcon.image = favicon.image
                case .failure(let error):
                    print("Error: \(error)")
                    self?.companyIcon.image = UIImage(named: "Building")
                }
            }
        }
    }
}
