//
//  productViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/12/23.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseStorageUI
import FirebaseDatabase
class productViewController: UIViewController {
    var productid : String=""
    var imgURL:String=""
    @IBOutlet weak var productimg: UIImageView!
    override func viewDidLoad() {
        print(productid)
        let tryDatabase = Database.database().reference()
        tryDatabase.child("product").child(productid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.imgURL = value?["imageURL"] as? String ?? ""
            print(self.imgURL)
            let storage = Storage.storage()
            let gsReference = storage.reference(forURL: self.imgURL)
            let placeholderImage = UIImage(named: "袋鼠.jpg")
            self.productimg.sd_setImage(with: gsReference, placeholderImage: placeholderImage)
        }
        
 
 super.viewDidLoad()
        print(productid)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
