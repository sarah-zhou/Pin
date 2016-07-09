//
//  LoginViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var logo = UIImageView()
    var usernameField = UITextField()
    var passwordField = UITextField()
    var loginButton = UIButton()
    var signUpButton = UIButton()
    var invalidLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        logo.frame = CGRect(x: 148, y: 95, width: 80, height: 80)
        usernameField.frame = CGRect(x: 25, y: 220, width: 320, height: 30)
        passwordField.frame = CGRect(x: 25, y: 270, width: 320, height: 30)
        invalidLabel.frame = CGRect(x: 0, y: 320, width: 375, height: 40)
        signUpButton.frame = CGRect(x: 37, y: 567, width: 300, height: 30)
        loginButton.frame = CGRect(x: 0, y: 607, width: 375, height: 60)
        
        logo.image = UIImage(named: "logo")
        
        usernameField.placeholder = "USERNAME"
        passwordField.placeholder = "PASSWORD"
        passwordField.secureTextEntry = true
        
        usernameField.font = usernameField.font?.fontWithSize(16.0)
        passwordField.font = passwordField.font?.fontWithSize(16.0)
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        usernameField.autocorrectionType = .No
        passwordField.autocapitalizationType = UITextAutocapitalizationType.None
        passwordField.autocorrectionType = .No
        
        invalidLabel.backgroundColor = UIColor.deepOrange()
        invalidLabel.textColor = UIColor.whiteColor()
        invalidLabel.textAlignment = NSTextAlignment.Center
        invalidLabel.hidden = true
        
        loginButton.backgroundColor = UIColor.cyan()
        loginButton.setTitle("LOGIN", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        signUpButton.setTitle("Don't have an account? Sign up!", forState: UIControlState.Normal)
        signUpButton.setTitleColor(UIColor.darkGray(), forState: UIControlState.Normal)
        
        loginButton.addTarget(self, action: #selector(loginClicked), forControlEvents: UIControlEvents.TouchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpClicked), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(logo)
        view.addSubview(passwordField)
        view.addSubview(usernameField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(invalidLabel)
    }
    
    func loginClicked() {
        
        if usernameField.text == "" {
            invalidLabel.text = "Username is required"
            invalidLabel.hidden = false
        } else if passwordField.text == "" {
            invalidLabel.text = "Password is required"
            invalidLabel.hidden = false
        } else {
            PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    print("Logged in successfully")
                    self.setupTabBarController()
                }
                if error?.code == 101 {
                    self.invalidLabel.text = "Username or password is invalid"
                    self.invalidLabel.hidden = false
                }
            }
        }
    }
    
    func setupTabBarController() {
        let tabBar = UITabBarController()
        
        let search = SearchViewController()
        let map = MapViewController()
        let profile = ProfileViewController()
        
        search.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        map.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag: 1)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 4)
        
        let vcs = [search, map, profile]
        tabBar.viewControllers = vcs
        tabBar.modalPresentationStyle = .FullScreen
        tabBar.modalTransitionStyle = .CoverVertical
        self.presentViewController(tabBar, animated: true, completion: nil)
    }
    
    func signUpClicked() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .FullScreen
        vc.modalTransitionStyle = .CoverVertical
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
