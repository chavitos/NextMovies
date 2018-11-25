//
//  SettingsTableViewController.swift
//  NextMovies
//
//  Created by Tiago Chaves on 25/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

extension UserDefaults{
    enum Keys{
        static let darkTheme    = "darkTheme"
        static let autoPlay     = "autoPlay"
    }
}

class SettingsTableViewController: UITableViewController {

    var settingsArray:[Setting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let darkTheme = UserDefaults.standard.bool(forKey: UserDefaults.Keys.darkTheme)
        let autoPlay  = UserDefaults.standard.bool(forKey: UserDefaults.Keys.autoPlay)
        
        let settingTheme = Setting(name: "Tema escuro", status: darkTheme)
        let settingPlay = Setting(name: "Auto play", status: autoPlay)
        
        settingsArray = [settingTheme,settingPlay]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setting = settingsArray[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.configCell(forSetting: setting)
        
        return cell
    }
}

struct Setting {
    
    var name:String
    var status:Bool
    
    init(name:String,status:Bool) {
        
        self.name = name
        self.status = status
    }
}
