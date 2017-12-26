//
//  updateViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseStorageUI
import FirebaseDatabase
import FirebaseAuth
class updateViewController: UIViewController {

    @IBOutlet weak var productname: UITextField!
    var isnew:Bool?
    var productid : String=""
    var imgURL:String=""
    @IBOutlet weak var productprice: UITextField!
    @IBOutlet weak var newcheck: UIImageView!
    @IBOutlet weak var secondhandcheck: UIImageView!
    @IBOutlet weak var story: UITextView!
    @IBOutlet weak var uploadedimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tryDatabase = Database.database().reference()
        tryDatabase.child("product").child(productid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.imgURL = value?["imageURL"] as? String ?? ""
            let storage = Storage.storage()
            let gsReference = storage.reference(forURL: self.imgURL)
            let placeholderImage = UIImage(named: "袋鼠.jpg")
            self.uploadedimg.sd_setImage(with: gsReference, placeholderImage: placeholderImage)
            self.productname.text=value?["name"] as? String ?? ""
            self.productprice.text=value?["price"] as? String ?? ""
            self.story.text=value?["story"] as? String ?? ""
            if(value?["isnew"] as? String ?? "" == "true"){
                self.newcheck.isHidden=false
                self.secondhandcheck.isHidden=true
                self.isnew=true
            }else{
                self.newcheck.isHidden=true
                self.secondhandcheck.isHidden=false
                self.isnew=false
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func isnewbtn(_ sender: UIButton) {
        self.newcheck.isHidden=false
        self.secondhandcheck.isHidden=true
        self.isnew=true
    }
    
    @IBAction func secondhandbtn(_ sender: UIButton) {
        self.newcheck.isHidden=true
        self.secondhandcheck.isHidden=false
        self.isnew=false
    }
    
    @IBAction func updatebtn(_ sender: UIButton) {
        let name = productname.text
        let price = productprice.text
        let isnew = self.isnew
        let story = self.story.text
        let ref = Database.database().reference().child("product").child(productid)
        ref.updateChildValues(["name" : name,
                               "price":price,
                               "story":story,
                               "isnew":isnew
                               ])
        let alert = UIAlertController(title: "修改成功", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok!", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            let _=self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deletebtn(_ sender: UIButton) {
        let ref = Database.database().reference().child("product").child(productid)
        let storage = Storage.storage().reference()
        storage.child("AppCodaFireUpload").child(productid).delete { error in
            if let error = error {
                print("Uh-oh, an error occurred!")
            } else {
                print("File deleted successfully")
            }
        }
        print(productid," is delete")
        ref.removeValue()
        
        let alert = UIAlertController(title: "刪除成功", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok!", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            let _=self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: UIButton) {
        let _=navigationController?.popViewController(animated: true)
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
