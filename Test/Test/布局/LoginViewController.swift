//
//  LoginViewController.swift
//  Test
//
//  Created by neyo on 2018/1/23.
//  Copyright © 2018年 dzp181. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa
import SVProgressHUD
class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        //信号
        let namesignal  = nameTextField.reactive.continuousTextValues
        let pswsignal = passwordTextField.reactive.continuousTextValues
        
        let colorSignal1 : Signal<Bool, NoError> = namesignal.map {
            text in
    
            return text!.count < 6  ? false : true
        }
        let colorSignal2 : Signal<Bool ,NoError> = pswsignal.map { text in
             return text!.count < 6  ? false : true
        }
        
        //合并信号
        let  colorSignal: Signal<UIColor, NoError> = Signal.combineLatest(colorSignal1, colorSignal2).map{
           return $0 && $1 ? .red : .lightGray
            
        }
        let  validSignal = Signal.combineLatest(colorSignal1, colorSignal2).map{
            $0 && $1
        }
        
        //Property(首先接收一个初始的值)
        let tfColor = Property(initial: .lightGray, then: colorSignal)
        let loginEnable = Property(initial: false, then: validSignal)
        
        
        //属性绑定
        loginBtn.reactive.isEnabled <~ loginEnable
        loginBtn.reactive.backgroundColor <~ tfColor
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginClick(_ sender: UIButton) {
       SVProgressHUD.setBackgroundColor(UIColor.lightGray)
       SVProgressHUD.showSuccess(withStatus: "ReactiveSwift")
    
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
