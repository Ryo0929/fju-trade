//
//  postViewController.swift
//  fju trade2
//
//  Created by Apple on 2017/12/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class postViewController: UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var myscrollview: UIScrollView!
    @IBOutlet weak var mytextarea: UITextView!
    override func viewDidLoad() {
        mytextarea.delegate=self
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            myscrollview.contentInset = UIEdgeInsets.zero
        } else {
            myscrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        myscrollview.scrollIndicatorInsets = myscrollview.contentInset
        let scrollviewheight=myscrollview.contentSize.height-216
        let myCGRect=CGRect.init(x:100,y:scrollviewheight,width:100,height:100)
    
        myscrollview.scrollRectToVisible(myCGRect, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
