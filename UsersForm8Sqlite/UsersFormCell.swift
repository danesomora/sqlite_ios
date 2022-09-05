//
//  UsersFormCell.swift
//  UsersForm8Sqlite
//
//  Created by Dane on 29/8/22.
//

import UIKit

class UsersFormCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let userName = UILabel()
    let roleLabel = UILabel()
    let userRole = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        drawCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        drawCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func drawCell() {
        
        nameLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 40)
        nameLabel.text = "Username"
        
        let userNameX = nameLabel.frame.origin.x + nameLabel.frame.width + 15
        let userNameWidth = self.contentView.frame.width - userNameX - 15
        userName.frame = CGRect(x: userNameX, y: 10, width: userNameWidth, height: 40)
        
        let roleLblY = nameLabel.frame.origin.y + nameLabel.frame.height + 20
        roleLabel.frame = CGRect(x: 10, y: roleLblY, width: 100, height: 40)
        roleLabel.text = "User Role"
        
        let userRoleX = roleLabel.frame.origin.x + roleLabel.frame.width + 15
        let userRoleWidth = self.contentView.frame.width - userRoleX - 15
        userRole.frame = CGRect(x: userRoleX, y: roleLblY, width: userRoleWidth, height: 40)
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(roleLabel)
        self.contentView.addSubview(userRole)
        
    }

}
