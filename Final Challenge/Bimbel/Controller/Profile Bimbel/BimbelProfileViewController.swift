//
//  BimbelProfileViewController.swift
//  Final Challenge
//
//  Created by Muhammad Reynaldi on 02/12/19.
//  Copyright © 2019 12. All rights reserved.
//

import UIKit
import CloudKit
class BimbelProfileViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[Any?] = []
    var bimbel:CKRecord?
    let header = "TitleTableViewCellID"
    let address = "DetailAddressTableViewCellID"
    let subject = "ContentTableViewCellID"
    let grade = "ContentViewTableViewCellID"
    let logoutView = "LogoutTableViewCellID"
    
    var sendToCustom:SendTutorToCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(text: "Bimbel Profile")
        setupData()
        registerCell()
        cellDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        sendToCustom?.sendTutor(tutor: self.tutorModel)
        setupView(text: "Profil")
        setupData()
        registerCell()
        cellDelegate()
    }
    
}
extension BimbelProfileViewController{
    private func setupData() {
        dataArray.removeAll() //Flush
        dataArray.append(bimbel) //0
        dataArray.append(("Address","Edit Address",0)) //1
        dataArray.append(("Teaching Subjects","Add Subjects",1)) //2
        dataArray.append(("Teaching Grades","Edit Grades",2)) //3
        dataArray.append(true) //4
    }
    
}
extension BimbelProfileViewController:BimbelProtocol{
    func pencilTapped() {
        let destVC = DetailProfileBimbelViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func addressTapped() {
        let destVC = DetailAddressViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func subjectTapped() {
        let destVC = SubjectViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func gradesTapped() {
        let destVC = GradeBimbelViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func logout() {
        //Pindah logout
    }
    
}
extension BimbelProfileViewController:UITableViewDataSource, UITableViewDelegate{
    private func registerCell() {
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: header)
        tableView.register(UINib(nibName: "DetailAddressTableViewCell", bundle: nil), forCellReuseIdentifier: address)
        tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: subject)
        tableView.register(UINib(nibName: "ContentViewTableViewCell", bundle: nil), forCellReuseIdentifier: grade)
        tableView.register(UINib(nibName: "LogoutTableViewCell", bundle: nil), forCellReuseIdentifier: logoutView)
    }
    
    private func cellDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //NGE SET CONTENT BERDASARKAN ROW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: header, for: indexPath) as! TitleTableViewCell
            cell.setCell(image: "", name: "Ming Ho", university: "Binus", age: 10)
            if let course = dataArray[indexPath.row] as? Courses {
                //GENERATE DATANYA HEADER
            }
            cell.index = 1
            cell.bimbelDelegate = self
            cell.outerProfile.outerRound()
            return cell
        }else if let keyValue = dataArray[indexPath.row] as? (key:String, value:String, code:Int){
            if keyValue.code == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: address, for: indexPath) as! DetailAddressTableViewCell
                cell.setCell(keyValue.key, keyValue.value)
                cell.bimbelDelegate = self
                return cell
            }else if keyValue.code == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: subject, for: indexPath) as! ContentTableViewCell
                cell.setCell(title: keyValue.key, button: keyValue.value)
                cell.bimbelDelegate = self
                return cell
            }else if keyValue.code == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: grade, for: indexPath) as! ContentViewTableViewCell
                cell.setCell(text: keyValue.key, button: keyValue.value)
                cell.bimbelDelegate = self
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: logoutView, for: indexPath) as! LogoutTableViewCell
            cell.setInterface()
            return cell
        }
        return UITableViewCell()
    }
    
}