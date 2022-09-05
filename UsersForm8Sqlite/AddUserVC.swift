//
//  AddUserVC.swift
//  UsersForm8Sqlite
//
//  Created by Dane on 29/8/22.
//

import UIKit

class AddUserVC: UIViewController {

    var topBarHeight: CGFloat {
        return ((view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0) + (self.navigationController?.navigationBar.frame.size.height ?? 0))
    }
    
    var tfUsername: UITextField!
    var tfUserrole: UITextField!
    var tfUserdob: UITextField!
    var createatlbl: UILabel!
    var uAddBtn: UIButton!
    var user: UserModel?
    var headerTitle = ""
    let datePicker = UIDatePicker()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        VCView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        VCView()
        headerTitleFlexibleChange()
    }
    
    
    @objc func addUserInfo(_ sender: UIButton) {
        
        if headerTitle != "" {
            let user = UserModel(id: user!.id, username: tfUsername.text!, userrole: tfUserrole.text!, userdob: tfUserdob.text!)
            let isUpdated = ModelManager.getInstance().updateUser(user: user)
            print("isUpdate: \(isUpdated)")
        }
        else {
            let user = UserModel(id: "", username: tfUsername.text!, userrole: tfUserrole.text!, userdob: tfUserdob.text!)
            let isSave = ModelManager.getInstance().saveUserData(user: user)
            print("isSave : \(isSave)")
        }
    
    }
    
    @objc func doneButtonTimePicker() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        tfUserdob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    func headerTitleFlexibleChange() {
        if headerTitle != "" {
            self.title = headerTitle
            tfUsername.text = user?.username
            tfUserrole.text = user?.userrole
            tfUserdob.text = user?.userdob
        }
    }
    
    func VCView() {
        
        self.view.backgroundColor = .systemGray5
        self.title = "Add User"
        
        let tfUNY = topBarHeight + 100
        let tfUNWidth:CGFloat = (view.frame.size.width - 80)
        let tfUNHeidht: CGFloat = 45
        tfUsername = UITextField(frame: CGRect(x: 40, y: tfUNY, width: tfUNWidth, height: tfUNHeidht))
        tfUsername.backgroundColor = .white
        tfUsername.layer.cornerRadius = tfUNHeidht / 3
        tfUsername.placeholder = "   Username"
        
        let tfURY = tfUNY + tfUNHeidht + 15
        let tfURWidth: CGFloat = (view.frame.size.width - 80)
        let tfURHeight: CGFloat = 45
        tfUserrole = UITextField(frame: CGRect(x: 40, y: tfURY, width: tfURWidth, height: tfURHeight))
        tfUserrole.backgroundColor = .white
        tfUserrole.layer.cornerRadius = tfURHeight / 3
        tfUserrole.placeholder = "  User Role"
        
        let tfUDY = tfURY + tfURHeight + 15
        let tfUDWd: CGFloat = (view.frame.size.width - 80)
        let tfUDHi: CGFloat = 45
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTimePicker))
        toolBar.setItems([doneBtn], animated: true)
        tfUserdob = UITextField(frame: CGRect(x: 40, y: tfUDY, width: tfUDWd, height: tfUDHi))
        tfUserdob.backgroundColor = .white
        tfUserdob.layer.cornerRadius = tfUDHi / 3
        tfUserdob.placeholder = "  User DOB"
        tfUserdob.inputAccessoryView = toolBar
        tfUserdob.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        let btnY = tfUDY + tfUDHi + 15
        let btnWidth: CGFloat = (view.frame.size.width - 130)
        let btnHeight: CGFloat = 40
        uAddBtn = UIButton(frame: CGRect(x: 65, y: btnY, width: btnWidth, height: btnHeight))
        uAddBtn.setTitle("Add", for: .normal)
        uAddBtn.setTitleColor(.white, for: .normal)
        uAddBtn.backgroundColor = .brown
        uAddBtn.layer.cornerRadius = btnHeight / 2
        uAddBtn.addTarget(self, action: #selector(addUserInfo), for: .touchUpInside)
        
        self.view.addSubview(tfUsername)
        self.view.addSubview(tfUserrole)
        self.view.addSubview(tfUserdob)
        self.view.addSubview((uAddBtn))
        
    }

}

