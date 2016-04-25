//
//  BusinessLayer.swift
//  NSURLSwift
//
//  Created by Ashwinkumar on 08/10/15.
//  Copyright © 2015 Ashwinkumar. All rights reserved.
//

import UIKit

class BusinessLayer: CommunicationManager {
    
    static var instance : BusinessLayer!

    // SHARED INSTANCE
    class func getInstance() -> BusinessLayer {
        instance = (instance ?? BusinessLayer())
        return instance
    }
    
    func attateamSignin(requestBody : [NSObject : AnyObject], withResponseCallback:(dictionary : [NSObject : AnyObject]!, error : NSError!) -> Void)
    {
        if super.isNetworkAvailable()
        {
            let urlString : String = URL_SIGNIN
            
            //called asynchronous method
            super.sendASynchronousRequestForPostMethod(super.request(urlString), requestBody: requestBody, withResponseCallback: { (responseDict : [NSObject : AnyObject]!, error : NSError!) -> Void in
                
                withResponseCallback(dictionary: responseDict, error: error)

            })
        }else
        {
            let alertController = UIAlertController(title: NSLocalizedString("ERROR_ALERT_TITLE", comment: ""), message: NSLocalizedString("MESSAGE_No_INTERNET_CONNECTION", comment: ""), preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: { () -> Void in
            })
        }
    }
    
    func getItunesData(withResponseCallback:(dictionary : [NSObject : AnyObject]!, error : NSError!) -> Void)
    {
        if super.isNetworkAvailable()
        {
            let urlString : String = URL_ITUNES_VERSION
            
            //called asynchronous method
            super.sendASynchronousRequestForGetMethod(super.request(urlString), withResponseCallback: { (responseDict : [NSObject : AnyObject]!, error : NSError!) -> Void in
                
                withResponseCallback(dictionary: responseDict, error: error)
                
            })
        }else
        {
            let alertController = UIAlertController(title: NSLocalizedString("ERROR_ALERT_TITLE", comment: ""), message: NSLocalizedString("MESSAGE_No_INTERNET_CONNECTION", comment: ""), preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: { () -> Void in
            })
        }
    }
    
}
