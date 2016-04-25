//
//  ViewController.swift
//  NSURLSwift
//
//  Created by Ashwinkumar on 07/10/15.
//  Copyright (c) 2015 Ashwinkumar. All rights reserved.
//

import UIKit

class ViewController: SuperViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.requestForLogin()
        self.requestForItunesData()
    }
    
    /*
    /Web service for login
    */
    func requestForLogin()
    {
        MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        
        let dict = NSMutableDictionary()
        
        dict.setValue("ashwin@yopmail.com", forKey: "email")
        dict.setValue("123456@A", forKey: "password")
        
        BusinessLayer.getInstance().attateamSignin(dict as [NSObject : AnyObject], withResponseCallback:{(dictionary : [NSObject : AnyObject]!, error : NSError!) -> Void in
            
            let responseDictionary : NSDictionary = dictionary as NSDictionary
            
            print("login data \(responseDictionary)")
            
            MBProgressHUD.hideHUDForView(self.navigationController?.view, animated: true)
            
            if ((error) == nil)
            {
                if responseDictionary.valueForKey("result")!.valueForKey("status")!.isEqualToString("OK")
                {
                    let token = responseDictionary.valueForKey("result")!.valueForKey("_token") as! String
                    
                    print("token : \(token)", terminator: "")
                }
                else
                {
                    let alertController = UIAlertController(title: NSLocalizedString("ALERT_TITLE", comment: ""), message: responseDictionary.valueForKey("result")!.valueForKey("message") as? String, preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) { }
                }
            }else
            {
                let alertController = UIAlertController(title: NSLocalizedString("ERROR_ALERT_TITLE", comment: ""), message: NSLocalizedString("MESSAGE_SERVER_NOT_RESPONDING", comment: ""), preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) { }
            }
        })
    }
    
    /*
    /Web service for itunes data
    */
    func requestForItunesData()
    {
        MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
        
        BusinessLayer.getInstance().getItunesData({(dictionary : [NSObject : AnyObject]!, error : NSError!) -> Void in
            
            let responseDictionary : NSDictionary = dictionary as NSDictionary
            
            print("itunes data \(responseDictionary)")
            
            MBProgressHUD.hideHUDForView(self.navigationController?.view, animated: true)
            
            if ((error) == nil)
            {
                if responseDictionary.valueForKey("resultCount")!.integerValue == 1
                {
                    let artistName = responseDictionary.valueForKey("results")?.objectAtIndex(0).valueForKey("artistName") as! String
                    
                    print("artistName : \(artistName)")
                }
                else
                {
                    let alertController = UIAlertController(title: NSLocalizedString("ALERT_TITLE", comment: ""), message: responseDictionary.valueForKey("result")!.valueForKey("message") as? String, preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) { }
                }
            }else
            {
                let alertController = UIAlertController(title: NSLocalizedString("ERROR_ALERT_TITLE", comment: ""), message: NSLocalizedString("MESSAGE_SERVER_NOT_RESPONDING", comment: ""), preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) { }
            }
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

