//
//  BaseTableViewController.swift
//  Test
//
//  Created by neyo on 2018/1/19.
//  Copyright © 2018年 dzp181. All rights reserved.
//

import UIKit


class BaseTableViewController: UITableViewController {

    @IBOutlet var main: UITableView!
    var dataSource : NSMutableArray = []
    var frameworkArray :NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.main.tableFooterView = UIView.init()
        self.dataSource = NSMutableArray.init()
        self.frameworkArray = NSMutableArray.init()
        
        let items  = ["UIButton","UILabel","UIImageView","UICollectionView","UIScrollView","UITextField","UIStackView","UIAlertController"]
        self.dataSource .addObjects(from: items)
        
        let fItems = ["Alamofire","ReactiveCocoa"]
        self.frameworkArray.addObjects(from: fItems)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "UI 控件"
        }else{
            return "常用框架使用"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return self.dataSource.count

        }else {
            return self.frameworkArray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            cell?.accessoryType =  UITableViewCellAccessoryType.disclosureIndicator
        }
        if (indexPath.section == 0) {
            let title = self.dataSource[indexPath.row]
            cell?.textLabel?.text = title as? String
        }else{
            let title = self.frameworkArray[indexPath.row]
            cell?.textLabel?.text = title as? String
        }
           
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0 ){
            let vc = ViewController.init(nibName: nil, bundle: nil)
            vc.type = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let sb = UIStoryboard.init(name: "FrameWork", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "FrameWorkViewControllerId") as! FrameWorkViewController
            vc.fType = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
}
