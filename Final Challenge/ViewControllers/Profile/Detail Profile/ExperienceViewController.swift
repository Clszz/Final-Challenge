//
//  ExperienceViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 11/11/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit

class ExperienceViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    let content = "DetailProfileTableViewCellID"
    let contentDrop = "AnotherDetailProfileTableViewCellID"
    let contentDate = "MoreDetailTableViewCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Experience")
        setupData()
        registerCell()
        cellDelegate()
    }
    
    func setupData() {
        dataArray.append(("Title","Example: iOS Developer",0))
        dataArray.append(("Experience Type","PartTime",1))
        dataArray.append(("Company","Example: Apple Developer Academy",0))
        dataArray.append(("Location","Enter your Location",0))
        dataArray.append(true)
    }
    
}
extension ExperienceViewController:UITableViewDataSource,UITableViewDelegate{
    func registerCell() {
        tableView.register(UINib(nibName: "DetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: content)
        tableView.register(UINib(nibName: "AnotherDetailProfileTableViewCell", bundle: nil), forCellReuseIdentifier: contentDrop)
        tableView.register(UINib(nibName: "MoreDetailTableViewCell", bundle: nil), forCellReuseIdentifier: contentDate)
    }
    
    func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let keyValue = dataArray[indexPath.row] as? (key:String,value:String,code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: content, for: indexPath) as! DetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: contentDrop, for: indexPath) as! AnotherDetailProfileTableViewCell
                cell.setCell(text: keyValue.key, content: keyValue.value)
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: contentDate, for: indexPath) as! MoreDetailTableViewCell
            cell.setView(startText: "Start Date", endText: "End Date", buttStart: "", buttEnd: "")
            return cell
        }
        return UITableViewCell()
    }
}
