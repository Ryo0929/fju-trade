//
//  changepasswordViewController.swift
//  fju trade2
//
//  Created by Apple on 2018/1/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class changepasswordViewController: UIViewController {
    
    @IBOutlet weak var newpassword1: UITextField!
    @IBOutlet weak var newpassword2: UITextField!
    @IBOutlet weak var newpassword3: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changepasswordbtn(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        let newpassword:String=self.newpassword3.text!
        let oldemail:String=self.newpassword1.text!
        let oldpassword:String=self.newpassword2.text!
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: oldemail, password: oldpassword)

        // Prompt the user to re-provide their sign-in credentials
        
        user?.reauthenticate(with:credential) { error in
            if let error = error {
                // An error happened.
                print("原帳號密碼打錯")
                let alertController = UIAlertController(title: "同學！", message: "原帳號或密碼打錯", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else {
                // User re-authenticated.
                
                
                user?.updatePassword(to: newpassword) { (error) in
                    if let error = error {
                        // An error happened.
                        print("修改失敗")
                        
                    }else{
                        let alert = UIAlertController(title: "改密碼成功", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "ok!", style: UIAlertActionStyle.default, handler: {
                            (action: UIAlertAction!) -> Void in
                            let _=self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
        }
        
            
        
    
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        let _=self.navigationController?.popViewController(animated: true)
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
