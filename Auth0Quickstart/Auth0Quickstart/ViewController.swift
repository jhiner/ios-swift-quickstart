//
//  ViewController.swift
//  Auth0Quickstart
//
//  Created by Justin Hinerman on 10/19/16.
//  Copyright © 2016 Justin Hinerman. All rights reserved.
//

import UIKit

import Auth0


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func Pipeline2AuthPKCEClicked( sender: AnyObject? ) {
        
        let params: [String: String] = [
            "audience":"http://todoapi2.api",
            "scope":"openid profile email read:todo offline_access",
            "response_type":"code",
            ]
        
        Auth0
            .webAuth()
            .parameters(params)
            .start(authCallback);
        
    }
    
    func authCallback(result:Result<Credentials>) {
        print("In callback...")
        
        print(result)
        
        switch result {
        case .success(let credentials):
            print("accessToken: \(credentials.accessToken)")
            print("idToken: \(credentials.idToken)")
            print("refreshToken: \(credentials.refreshToken)")
            print("tokenType: \(credentials.tokenType)")
            
            DispatchQueue.main.async {
                // here you have the access token, id token, and (optionally) refresh token available to your app
                self.accessTokenText.text=credentials.accessToken
                self.idTokenText.text=credentials.idToken
                self.refreshTokenText.text = credentials.refreshToken
            }
        case .failure(let error):
            print(error)
        }
        
    }
    
    @IBOutlet weak var refreshTokenText: UITextView!
    @IBOutlet weak var accessTokenText: UITextView!
    @IBOutlet weak var idTokenText: UITextView!

}

