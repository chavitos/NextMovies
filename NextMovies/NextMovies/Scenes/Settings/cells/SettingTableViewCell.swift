//
//  SettingTableViewCell.swift
//  NextMovies
//
//  Created by Tiago Chaves on 25/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var settingNameLabel: UILabel!
    @IBOutlet weak var settingStatus: UISwitch!
    
    var setting:Setting?
    
    func configCell(forSetting setting:Setting) {
        
        self.setting = setting
        
        self.settingNameLabel.text = setting.name
        self.settingStatus.setOn(setting.status, animated: true)
    }

    @IBAction func changeValue(_ sender: UISwitch) {
        
        var key = ""
        
        if setting?.name == "Auto play" {
            key = UserDefaults.Keys.autoPlay
        }else if setting?.name == "Tema escuro" {
            key = UserDefaults.Keys.darkTheme
        }
        
        UserDefaults.standard.set(self.settingStatus.isOn, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
