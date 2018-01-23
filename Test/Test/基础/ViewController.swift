//
//  ViewController.swift
//  Test
//
//  Created by neyo on 2018/1/19.
//  Copyright © 2018年 dzp181. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReactiveCocoa

class CustomCell: UICollectionViewCell{
    @IBOutlet weak var imv: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}

class StackView: UIView ,LoadXibProtocol{
    
}

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UIScrollViewDelegate
 {

    var type : Int!
    let nib = UINib(nibName: "CollectionViewCell", bundle: Bundle.main)
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView! = nil
//    let stackView = Bundle.main.loadNibNamed("StackView", owner: nil, options: nil)?[0] as! StackView

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white

        if type == 0 {
            

            let btn = UIButton.init(type: UIButtonType.custom)
            btn.setTitle("UIButton1", for: UIControlState.normal)
            btn.frame = CGRect(x: 100, y: 200,width:150,height:50)
            btn.backgroundColor = UIColor.red
            btn.addTarget(self, action: #selector(self.foo) , for: .touchDown)
            self.view .addSubview(btn)
            
            let btn1 = UIButton.init(type: UIButtonType.custom)
            btn1.setTitle("UIButton2", for: UIControlState.normal)
            btn1.frame = CGRect(x: 100, y: 400,width:150,height:50)
            btn1.backgroundColor = UIColor.red
            btn1.addTarget(self, action: #selector(foo1(sender:)), for: .touchDown)
            self.view .addSubview(btn1)
            
        }else if  type == 1{
            
            let lal = UILabel.init(frame: CGRect(x: 100, y: 200,width:250,height:50))
            lal.text = "我是UILabel"
            lal.textColor = UIColor.green
            lal.backgroundColor = UIColor.lightGray
            self.view .addSubview(lal)
            
        } else if  type == 2 {
            let imv = UIImageView.init(frame: CGRect(x: 100, y: 200,width:250,height:250))
            imv.image = UIImage.init(named: "1.jpg")
            self.view .addSubview(imv)
            
        }else if  type == 3 {
            
            let rb = UIButton.init(type: UIButtonType.custom)
            rb.frame  = CGRect(x:0,y:0,width:30,height:30)
            rb.setTitle("点击", for: UIControlState.normal)
            rb.setTitleColor(UIColor.blue, for: UIControlState.normal)
            rb .addTarget(self, action: #selector(rbClick as()->()), for: .touchDown)
            let rightBtn = UIBarButtonItem.init(customView: rb)
            self.navigationItem.rightBarButtonItem = rightBtn
            
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
            layout.itemSize = CGSize(width:120,height:110)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 5.0
            
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 64,width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height - 64),
                                              collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
            self.view .addSubview(collectionView)

        }else if type == 4{
            
            let messageLal = UILabel.init(frame: CGRect(x: 50, y: 70, width: 300, height: 30))
            messageLal.text = "水平"
            self.view .addSubview(messageLal)
            
            let scroller = UIScrollView.init(frame: CGRect(x: 50, y: 100, width: 300, height: 200))
            scroller.contentSize = CGSize(width: 600, height: 200)
            scroller.delegate = self
            scroller.backgroundColor = UIColor.lightGray
            
            //这个屌
            for i in 0..<2 {
                 let imv = UIImageView.init(frame: CGRect(x: i*300, y: 0, width: 300, height: 200))
                imv.image = UIImage.init(named: "1.jpg")
                scroller .addSubview(imv)
            }
            self.view.addSubview(scroller)
            
            
            let messageLal1 = UILabel.init(frame: CGRect(x: 50, y: 370, width: 300, height: 30))
            messageLal1.text = "竖直"
            self.view .addSubview(messageLal1)
            let scroller1 = UIScrollView.init(frame: CGRect(x: 50, y: 400, width: 300, height: 200))
            scroller1.contentSize = CGSize(width: 300, height: 600)
            scroller1.delegate = self
            scroller1.isPagingEnabled = true
            scroller1.backgroundColor = UIColor.lightGray
            
          
            for i in 0..<3 {
                let imv = UIImageView.init(frame: CGRect(x: 0, y:i*200, width: 300, height: 200))
                imv.image = UIImage.init(named: "1.jpg")
                scroller1 .addSubview(imv)
            }
            
            self.view.addSubview(scroller1)
        }else if type == 5{
            
            let textField = UITextField.init(frame: CGRect(x: 50, y: 100, width: 300, height: 200))
            textField.delegate = self
            textField.placeholder = "我是placeholder"
            textField.backgroundColor = UIColor.green
            textField.keyboardType = UIKeyboardType.emailAddress
            self.view .addSubview(textField)
        }else if type==6{
            
//            let stackView = StackView.instantiateFromNib()
            let stackView = StackView.loadXib(xibStr: "StackView")
            stackView.frame = CGRect(x:0,y:0,width:300,height:400)
            stackView.center = self.view.center
            self.view .addSubview(stackView)
            
        }else if type == 7{
            
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect.init(x: 100, y: 100, width: 80, height: 80)
            btn .setTitle("click", for: .normal)
            btn.backgroundColor = UIColor.brown
            btn.reactive.controlEvents(.touchDown).observeValues({ (btn) in
                let alter = UIAlertController.init(title: "this is a title", message: "this is message", preferredStyle: .alert)
                let cancle = UIAlertAction.init(title: "取消", style: .cancel, handler: { (nil) in
//                    self.navigationController?.popViewController(animated: true)
                })
                let sure = UIAlertAction.init(title: "确定", style: .default, handler: { (nil) in
                    print("确定")
                })
                alter.addAction(sure)
                alter.addAction(cancle)
                self.present(alter, animated: true, completion: {
                    
                })
            })
            self.view.addSubview(btn)
            
            
            let btn1 = UIButton.init(type: .custom)
            btn1.frame = CGRect.init(x: 100, y: 200, width: 80, height: 80)
            btn1 .setTitle("click", for: .normal)
            btn1.backgroundColor = UIColor.brown
            btn1.reactive.controlEvents(.touchDown).observeValues({ (btn1) in
                let acsheet = UIAlertController.init(title: "this is a title", message: "this is message", preferredStyle: .actionSheet)
                let cancle = UIAlertAction.init(title: "取消", style: .cancel, handler: { (nil) in
                    print("取消")
                })
                let sure = UIAlertAction.init(title: "确定", style: .default, handler: { (nil) in
                     print("确定")
                })
                acsheet.addAction(sure)
                acsheet.addAction(cancle)
                self.present(acsheet, animated: true, completion: {
                    
                })
            })
            self.view.addSubview(btn1)
            
        }
        
  
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CustomCell
        cell.imv.image = UIImage.init(named: "1.jpg")
        cell.titleLabel.text = "我是谁"
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
//    @objc func foo() {
//
//        SVProgressHUD.showInfo(withStatus: "who am i ?")
//        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
//    }
//
//    @objc func foo1(sender: UIButton){
//        SVProgressHUD.showInfo(withStatus: "who cares?")
//        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
//    }

    @objc func rbClick(){
        if (layout.scrollDirection == UICollectionViewScrollDirection.horizontal){
            layout.scrollDirection = UICollectionViewScrollDirection.vertical
        }else{
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal

        }
        
    }

  
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("hello world")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension StackView {
    public class func instantiateFromNib() -> StackView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! StackView
    }
}

protocol LoadXibProtocol {
    
}
extension LoadXibProtocol where Self: UIView {

    static func loadXib(xibStr: String? = nil) -> Self {
        print("\(self)")
        // ?? 缺省值
        return Bundle.main.loadNibNamed(xibStr ?? "\(self)", owner: nil, options: nil)?.last as! Self
    }
}

 @objc extension ViewController{
    func foo(){
        SVProgressHUD.showInfo(withStatus: "who am i ?")
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
    }
    func foo1(sender:UIButton){
        print(sender)
        SVProgressHUD.showInfo(withStatus: "who cares?")
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
    }
}
