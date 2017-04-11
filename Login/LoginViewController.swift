//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    var titleUI: UILabel!
    var username: UITextField!
    var password: UITextField!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        let mainView = UIView()
        mainView.backgroundColor = UIColor.white
        mainView.layer.cornerRadius = 8;
        
        titleUI = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 0.75, height: 100))
        titleUI.text = "Login View Controller"
        titleUI.font = UIFont(name: "Avenir-Light", size: 30)
        titleUI.textColor = UIColor.white
        
        username = UITextField()
        username.placeholder = "enter username"
        password = UITextField()
        password.placeholder = "enter password"
        
        loginButton = UIButton()
        loginButton.backgroundColor = UIColor.blue
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        
        mainView.addSubview(username)
        mainView.addSubview(password)
        mainView.addSubview(loginButton)
        view.addSubview(titleUI)
        view.addSubview(mainView)
        
        
        // TODO: layout your views using frames or AutoLayout
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleUI.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        let mainViewConstraints = [
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ]
        
         NSLayoutConstraint.activate(mainViewConstraints)
        
        let titleConstraints = [
            titleUI.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleUI.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        
        let usernameConstraints = [
            username.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 6),
            username.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 6),
            username.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -6),
            username.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(usernameConstraints)
        
        let passwordConstraints = [
            password.heightAnchor.constraint(equalTo: username.heightAnchor),
            password.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 6),
            password.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -6),
            password.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            password.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(passwordConstraints)
        
        let loginButtonConstraints = [
            loginButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -6),
            loginButton.heightAnchor.constraint(equalTo: username.heightAnchor),
            loginButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 6),
            loginButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -6),
            loginButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ]
        
         NSLayoutConstraint.activate(loginButtonConstraints)
        
        
        
        
        
    }
    
    // TODO: create an IBAction for your login button
    func performLogin(sender: UIButton) {
        let username = self.username.text
        let password = self.password.text
        authenticateUser(username: username, password: password)
    }
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
