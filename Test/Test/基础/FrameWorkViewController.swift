

//
//  FrameWorkViewController.swift
//  Test
//
//  Created by neyo on 2018/1/19.
//  Copyright © 2018年 dzp181. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveCocoa
import SwiftyJSON

class FrameWorkViewController: UIViewController {
    
     var fType : Int!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        if fType == 0 {
            
            Alamofire.request("http://www.hlc.ph/config/json/game_group.json", parameters: [:])
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result.isSuccess {
                    case true:

                        if let value = response.result.value {
                            let json = JSON(value)
                            print(json)
                        }
                    case false:
                        print(response.result.error as Any)
                    }
            }


        }else if fType == 1 {
            
            //1.basic
//            username.reactive.continuousTextValues.observeValues({ (text) in
//                print(text ?? "")
//            })
            
            //2.过滤
            username.reactive.continuousTextValues.filter({ (text ) -> Bool in
                return text!.count > 6
            }).observeValues({ (text) in
                print(text ?? "" )
            })
            
            //
            

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
