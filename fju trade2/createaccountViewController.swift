//
//  createaccountViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/11/29.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import MessageUI

class createaccountViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var accountTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    var activeTextField :UITextField!
    func showMessage() {
        let alertController = UIAlertController(title: "歡迎！", message: "來到孩子們的快樂天堂", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{(action:UIAlertAction!)-> Void in let _ = self.navigationController?.popViewController(animated: true)}))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func goregister(_ sender: UIButton) {
        // 建立帳號
        Auth.auth().createUser(withEmail: self.accountTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            
            if error != nil {
                let alertController = UIAlertController(title: "同學！", message: "輸入有錯哦", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            
                
            }else{
                self.showMessage()
                user?.sendEmailVerification() { error in
                   if let error = error {
                        print(error)
                    
                    }
                }
                return
            }
        }
    }
    
    
    @IBAction func backtostart(_ sender: UIButton) {
         let _=navigationController?.popViewController(animated: true)
    }
  
    @objc func keyboardDidShow(notification:Notification){
        let info:NSDictionary=notification.userInfo! as NSDictionary
        let keyboardsize=(info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY=self.view.frame.size.height - keyboardsize.height
        let editingTextFieldY:CGFloat! = self.accountTextField?.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25,delay:0.0,options:UIViewAnimationOptions.curveEaseIn, animations: {self.view.frame =  CGRect(x:0,y:self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 60)), width:self.view.bounds.width , height:self.view.bounds.height)},completion:nil)
            }
        }
    }
    @objc func keyboardWillHide(notification:Notification){
        UIView.animate(withDuration: 0.25,delay:0.0,options:UIViewAnimationOptions.curveEaseIn, animations: {self.view.frame=CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height)},completion:nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField=textField
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillShow,object:nil)
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillHide,object:nil)
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

