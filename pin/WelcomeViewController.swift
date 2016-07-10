//
//  WelcomeViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var logo = UIImageView()
    var backgroundImage = UIImageView()
    var blur = UIVisualEffectView()
    var titleLabel = UILabel()
    var loginButton = UIButton()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = UIColor.whiteColor()
        
        // backgroundImage.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        logo.frame = CGRect(x: 148, y: 95, width: 80, height: 80)
        titleLabel.frame = CGRect(x: 61, y: 190, width: 253, height: 40)
        loginButton.frame = CGRect(x: 98, y: 455, width: 180, height: 40)
        signUpButton.frame = CGRect(x: 98, y: 505, width: 180, height: 40)
        
//        backgroundImage.image = UIImage(named: "welcome")
        logo.image = UIImage(named: "logo")
        
        let blurEffect = UIBlurEffect(style: .Light)
        blur = UIVisualEffectView(effect: blurEffect)
        blur.alpha = 0.8
        blur.frame = CGRect(x: 98, y: 505, width: 180, height: 40)
        blur.layer.cornerRadius = 20.0
        blur.clipsToBounds = true
        
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = titleLabel.font.fontWithSize(20.0)
        
        loginButton.setTitle("LOGIN", forState: UIControlState.Normal)
        loginButton.titleLabel?.font = loginButton.titleLabel?.font.fontWithSize(17.0)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginButton.backgroundColor = UIColor.cyan()
        loginButton.layer.cornerRadius = 20.0
        
        signUpButton.setTitle("SIGNUP", forState: UIControlState.Normal)
        signUpButton.titleLabel?.font = signUpButton.titleLabel?.font.fontWithSize(17.0)
        signUpButton.setTitleColor(UIColor.darkGray(), forState: UIControlState.Normal)
        signUpButton.layer.cornerRadius = 20.0
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor.darkGray().CGColor
        
        loginButton.addTarget(self, action: #selector(loginClicked), forControlEvents: UIControlEvents.TouchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpClicked), forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(backgroundImage)
        view.addSubview(logo)
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
        view.addSubview(blur)
        view.addSubview(signUpButton)
    }
    
    func loginClicked() {
        performSegueWithIdentifier("PresentLogin", sender: nil)
//        let vc = LoginViewController()
//        vc.modalPresentationStyle = .FullScreen
//        vc.modalTransitionStyle = .CoverVertical
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func signUpClicked() {
        performSegueWithIdentifier("PresentSignUp", sender: nil)
//        let vc = SignUpViewController()
//        vc.modalPresentationStyle = .FullScreen
//        vc.modalTransitionStyle = .CoverVertical
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
