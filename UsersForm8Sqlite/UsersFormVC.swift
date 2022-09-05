//
//  ViewController.swift
//  UsersForm8Sqlite
//
//  Created by Dane on 29/8/22.
//

import UIKit

class UsersFormVC: UIViewController {

    let tbUsers = UITableView()
    var users = [UserModel]()
    
        var topBarHeight: CGFloat {
            return ((view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0) + (self.navigationController?.navigationBar.frame.size.height ?? 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createFormView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = ModelManager.getInstance().getAllUserData()
        tbUsers.reloadData()
    }
    
    @objc func addAction(_ sender: UIBarButtonItem) {
        
        let vc = AddUserVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func editAction(_ sender: UIButton) {
        
        let vc = AddUserVC()
        vc.user = users[sender.tag]
        vc.headerTitle = "Edit"
//        vc.uAddBtn.setTitle("Save Edit", for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func deleteAction(_ sender: UIButton) {
        let isDeleted = ModelManager.getInstance().deleteUser(user: users[sender.tag])
        users.remove(at: sender.tag)
        tbUsers.reloadData()
        print("isDelete: \(isDeleted)")
    }

    func createFormView() {
        
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
//         view.addSubview(navBar)
//         let navItem = UINavigationItem(title: "SomeTitle")
//         let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(addAction))
//         navItem.rightBarButtonItem = doneItem
//         navBar.setItems([navItem], animated: false)
        
//        let mainWidth = self.view.frame.width
//        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: mainWidth, height: 44))
//
//        self.view.addSubview(navigationBar)
//        let navigationItem: UINavigationItem = UINavigationItem(title: "Users Form")
//        let addUserBtn = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addAction))
//        navigationItem.rightBarButtonItem = addUserBtn
//        navigationBar.setItems([navigationItem], animated: false)
        
        var btnBarName = UIImage(systemName: "plus.square")
        btnBarName = btnBarName?.withRenderingMode(.alwaysOriginal)
        let addButton = UIBarButtonItem(image: btnBarName, style: .plain, target: self, action: #selector(addAction))
        addButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [addButton]
        

        
        self.title = "Users Form"
        self.view.backgroundColor = .white
        
        
        tbUsers.frame = CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height - topBarHeight)
        tbUsers.backgroundColor = .white
        tbUsers.register(UsersFormCell.self, forCellReuseIdentifier: "usersFormCell")
        tbUsers.dataSource = self
        tbUsers.delegate = self
        
        self.view.addSubview(tbUsers)
    }

}

extension UsersFormVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbUsers.dequeueReusableCell(withIdentifier: "usersFormCell", for: indexPath) as! UsersFormCell
        cell.selectionStyle = .none
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 115, height: 30))
        nameLabel.text = "Username:"
        
        let userNameX = nameLabel.frame.origin.x + nameLabel.frame.width + 25
        let userNameWidth = cell.contentView.frame.width - userNameX - 115
        let userName = UILabel(frame: CGRect(x: userNameX, y: 10, width: userNameWidth, height: 30))
        userName.text = users[indexPath.row].username
        
        let roleLblY = nameLabel.frame.origin.y + nameLabel.frame.height + 10
        let roleLabel = UILabel(frame: CGRect(x: 20, y: roleLblY, width: 115, height: 30))
        roleLabel.text = "User Role:"
        
        let userRoleX = roleLabel.frame.origin.x + roleLabel.frame.width + 25
        let userRoleWidth = cell.contentView.frame.width - userRoleX - 115
        let userRole = UILabel(frame: CGRect(x: userRoleX, y: roleLblY, width: userRoleWidth, height: 30))
        userRole.text = users[indexPath.row].userrole
        
        let dobLblY = roleLblY + CGFloat(roleLabel.frame.size.height) + 10
        let dobLabel = UILabel(frame: CGRect(x: 20, y: dobLblY, width: 115, height: 30))
        dobLabel.text = "Date of Birth:"
        
        let uDobX = dobLabel.frame.origin.x + CGFloat(dobLabel.frame.size.width) + 25
        let uDobWd = cell.contentView.frame.size.width - uDobX - 115
        let userDob = UILabel(frame: CGRect(x: uDobX, y: dobLblY, width: uDobWd, height: 30))
        userDob.text = users[indexPath.row].userdob
        
        let crTimeLblWd: CGFloat = 235
        let trailingSpace: CGFloat = 25
        let crTimeLblX = cell.contentView.frame.size.width - crTimeLblWd - trailingSpace
        let crTimeLblY = dobLblY + dobLabel.frame.size.height + 05
        let createTimeLabel = UILabel(frame: CGRect(x: crTimeLblX, y: crTimeLblY, width: crTimeLblWd, height: 20))
        createTimeLabel.text = "Created At: " + users[indexPath.row].usercreateat!
        createTimeLabel.font = .systemFont(ofSize: 15)
        createTimeLabel.textColor = .systemGray2
        
        let editBtnWidth:CGFloat = 30
        let editBtnHeight:CGFloat = 35
        let editBtnX = userRole.frame.origin.x + userRole.frame.width + 30
        let editBtnY = (cell.contentView.frame.height / 2) - (editBtnHeight / 2)
        let editButton = UIButton(frame: CGRect(x: editBtnX, y: editBtnY, width: editBtnWidth, height: editBtnHeight))
        editButton.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.tag = indexPath.row
        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        
        let deleteBtnX = editButton.frame.origin.x + editButton.frame.size.width
        let deleteBtn = UIButton(frame: CGRect(x: deleteBtnX, y: editBtnY, width: editBtnWidth, height: editBtnHeight))
        deleteBtn.setImage(UIImage(systemName: "minus.rectangle.portrait"), for: .normal)
        deleteBtn.tintColor = .red.withAlphaComponent(0.7)
        deleteBtn.tag = indexPath.row
        deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        
        cell.contentView.addSubview(nameLabel)
        cell.contentView.addSubview(userName)
        cell.contentView.addSubview(roleLabel)
        cell.contentView.addSubview(userRole)
        cell.contentView.addSubview(dobLabel)
        cell.contentView.addSubview(userDob)
        cell.contentView.addSubview(createTimeLabel)
        cell.contentView.addSubview(editButton)
        cell.contentView.addSubview(deleteBtn)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 155
    }
}

