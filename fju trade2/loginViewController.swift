//
//  loginViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/11/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class loginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var activeTextField :UITextField!
    @IBAction func backtostart(_ sender: UIButton) {
        let _=navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func gotomainview(_ sender: UIButton) {
        if self.accountTextField.text == "" || self.passwordTextField.text == "" {
            self.showmessage()
            return
        }else{
            Auth.auth().signIn(withEmail: self.accountTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                if error != nil{
                    self.showmessage()
                    return
                }else{
                    
                    let mainviewview = UIStoryboard(name: "Main" , bundle:nil).instantiateViewController(withIdentifier: "mainview")
                    self.navigationController?.pushViewController(mainviewview, animated: true)            }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let center:NotificationCenter=NotificationCenter.default;
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
         center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func keyboardDidShow(notification:Notification){
        let info:NSDictionary=notification.userInfo! as NSDictionary
        let keyboardsize=(info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY=self.view.frame.size.height - keyboardsize.height
        let editingTextFieldY:CGFloat! = self.activeTextField?.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
        
        if editingTextFieldY > keyboardY - 60 {
            UIView.animate(withDuration: 0.25,delay:0.0,options:UIViewAnimationOptions.curveEaseIn, animations: {self.view.frame =  CGRect(x:0,y:self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 60)), width:self.view.bounds.width , height:self.view.bounds.height)},completion:nil)
            }
    }
    }
    @objc func keyboardWillHide(notification:Notification){
        UIView.animate(withDuration: 0.25,delay:0.0,options:UIViewAnimationOptions.curveEaseIn, animations: {self.view.frame=CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height)},completion:nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField=textField
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillShow,object:nil)
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillHide,object:nil)
    }
    func showmessage() {
        let alertController = UIAlertController(title: "錯誤", message: "帳號密碼錯誤或空白", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
