//
//  mainviewViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/12/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseStorageUI
import FirebaseDatabase
import FirebaseAuth
class mainviewViewController: UIViewController {
    var myScrollView: UIScrollView!
    var fullSize :CGSize!
    //var quantity:CGFloat=0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tryDatabase = Database.database().reference()
        /*tryDatabase.child("product").observeSingleEvent(of: .value, with: { (snapshot) in
            let childcount=snapshot.childrenCount
            self.quantity = CGFloat(childcount)
            print(self.quantity,"1")
        }) { (error) in
            print(error.localizedDescription)
        }*/
        //print(quantity,"2")
        fullSize = UIScreen.main.bounds.size
        myScrollView = UIScrollView()
        myScrollView.frame = CGRect(
            x: 0, y: 100, width: fullSize.width,
            height: fullSize.height - 145)
        myScrollView.contentSize = CGSize(
            width: fullSize.width * 1,
            height: fullSize.height * 3)
        //print(quantity,"3")
        myScrollView.delegate = self as? UIScrollViewDelegate
        myScrollView.showsVerticalScrollIndicator = true
        myScrollView.isScrollEnabled = true
        
        self.view.addSubview(myScrollView)
        
        
        tryDatabase.child("product").observeSingleEvent(of: .value, with: {(snapshot) in
            //read multi data
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                var count:Int=1
                for snap in snapshots{
                    let tempData = snap.value as? NSDictionary
                    var chooseproductid :String?
                    //let key = snap.key
                    //let act = Act(key: key, name: tempData!["name"] as! String,     startTime: tempData!["startTime"] as! String)
                    //self.data.append(act)
                    //set
                    chooseproductid=tempData?["productid"]as? String ?? ""
                    //set backgournd rectangle
                    var productView = IdentifiedButton(frame: CGRect(x: 0, y: 0, width: 375, height: 100))
                    productView.setImage(UIImage(named: "product rectangle.png"), for: .normal)
                    productView.center = CGPoint(x: 187.5,y: 50+100*(Double(count)-1));
                    productView.buttonIdentifier=chooseproductid
                    productView.addTarget(self, action: #selector(self.clickButton), for: .touchUpInside)
                    self.myScrollView.addSubview(productView)
                    //set product picture
                    var pictureView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    pictureView.center = CGPoint(x: 187.5,y: 50+100*(Double(count)-1));
                    let storage = Storage.storage()
                    var pictureURL:String? = tempData?["imageURL"]as? String ?? ""
                    let gsReference = storage.reference(forURL: pictureURL!)
                    let placeholderImage = UIImage(named: "袋鼠.jpg")
                    pictureView.sd_setImage(with: gsReference, placeholderImage: placeholderImage)
                    pictureView.center = CGPoint(x: 52.5,y: 50+100*(Double(count)-1));
                    self.myScrollView.addSubview(pictureView)
                    
                    //set namelabel
                    var nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
                    nameLabel.text = tempData?["name"]as? String ?? ""
                    nameLabel.font = UIFont(name: "Helvetica", size: 18)
                    nameLabel.numberOfLines = 1
                    nameLabel.center = CGPoint(x: 200,y: 20+100*(Double(count)-1));
                    self.myScrollView.addSubview(nameLabel)
                    
                    var priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
                    priceLabel.text = tempData?["price"]as? String ?? ""
                    priceLabel.font = UIFont(name: "Helvetica", size: 18)
                    priceLabel.numberOfLines = 1
                    priceLabel.center = CGPoint(x: 200,y: 40+100*(Double(count)-1));
                    self.myScrollView.addSubview(priceLabel)
                    count=count+1
                }}})
        
        // Do any additional setup after loading the view.
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
    @objc func clickButton(sender:IdentifiedButton) {
        let productid = sender.buttonIdentifier
        let gotoproduct = storyboard?.instantiateViewController(withIdentifier: "productview") as! productViewController
        gotoproduct.productid=productid!
        navigationController?.pushViewController(gotoproduct, animated: true)
    }
    

}
class IdentifiedButton: UIButton {
    var buttonIdentifier: String?
}
