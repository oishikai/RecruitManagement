//
//  ViewController.swift
//  RecruitManagement
//
//  Created by Kai on 2021/04/30.
//

import UIKit

class RecruitListViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var companyTableView: UITableView!
    var addBarButtonItem: UIBarButtonItem!

    private var companies:[Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "企業一覧"
        
        navigationItem.leftBarButtonItem = editButtonItem
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        let comp = AccessData.getCompanies()
        guard comp != nil else {
            print("accessError")
            return
        }
        companies = comp!
        
        let nib = UINib(nibName: RecruitListTableViewCell.cellIdentifier, bundle: nil)
        companyTableView.register(nib, forCellReuseIdentifier: RecruitListTableViewCell.cellIdentifier)
        companyTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let comp = AccessData.getCompanies()
        guard comp != nil else {
            print("accessError")
            return
        }
        companies = comp!
        
        
        companyTableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        companyTableView.isEditing = editing
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "NewCompanyFormViewController", bundle: nil)
            let nextVC = storyboard.instantiateViewController(identifier: "NewCompanyFormViewController")as! NewCompanyFormViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension RecruitListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecruitListTableViewCell.cellIdentifier, for: indexPath) as! RecruitListTableViewCell
        cell.setup(company: companies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "EventListViewController", bundle: nil)
            let nextVC = storyboard.instantiateViewController(identifier: "EventListViewController")as! EventListViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            nextVC.title = self.companies[indexPath.row].companyName
            nextVC.company = self.companies[indexPath.row]
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let com = self.companies[indexPath.row]
        companies.remove(at: indexPath.row)
        AccessData.deleteCompany(company: com)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return UITableViewCell.EditingStyle.delete
            } else {
                return UITableViewCell.EditingStyle.none
            }
        
    }
}
