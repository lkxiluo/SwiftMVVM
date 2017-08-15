//
//  MYLoginViewController.swift
//  MiYanSwift
//
//  Created by QianHan on 2017/7/20.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    fileprivate var logoImageView: UIImageView?
    fileprivate var accountTextField: UITextField?
    fileprivate var passwordTextField: UITextField?
    fileprivate var loginButton: UIButton?
    
    var viewModel: LoginViewModel?
    
    // MARK: - public method
    
    // MARK: - life cyclic
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "登录"
        self.viewModel = LoginViewModel()
        self.setupView()
        self.accountTextField?.becomeFirstResponder()
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureClick))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK:  - event response
    @objc fileprivate func loginClick() -> Void {
        
        viewModel?.login(completeHandler: { (isSuccess: Bool) in
            
            if isSuccess {
            
                QHLog("跳转")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let tabBarController = TabBarViewController()
                appDelegate.window?.rootViewController = tabBarController
            }
        })
    }
    
    @objc fileprivate func tapGestureClick() -> Void {
        
        self.accountTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
    }
    
    func accountTextFieldDidChange(_ textField: UITextField) {
        
        if let text = textField.text {
            
            viewModel?.account = text
            loginButton?.isEnabled = (viewModel?.isCanLogin())!
        }
    }
    
    func passwordTextFieldDidChange(_ textField: UITextField) {
        
        if let text = textField.text {
            
            viewModel?.password = text
            loginButton?.isEnabled = (viewModel?.isCanLogin())!
        }
    }
    
    // MARK:  - private method
    private func setupView() {
        
        self.initLogoImageView()
        self.initAccountTextField()
        self.initPasswordTextField()
        self.initLoginButton()
    }
}

// MARK:  - Delegate
// MARK:  - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}

// MARK:  - init subview
fileprivate extension LoginViewController {

    func initLogoImageView() -> Void {
        
        if (self.logoImageView == nil) {

            let logoImage:UIImage      = UIImage(named: "login_sign_logo")!
            self.logoImageView         = UIImageView()
            self.logoImageView?.frame  = CGRect(x: 0.0, y: 0.0, width: FITSCREEN(f: 110.0), height: FITSCREEN(f: 71.0))
            self.logoImageView?.center = CGPoint(x: SYSTEMMACROS_SCREEN_WIDTH / 2, y: FITSCREEN(f: 80.0))
            self.logoImageView?.contentMode = .scaleAspectFit
            self.logoImageView?.image  = logoImage
            self.view.addSubview(self.logoImageView!)
        }
    }
    
    func initAccountTextField() -> Void {
        
        if self.accountTextField == nil {
        
            self.accountTextField = self.textField()
            self.accountTextField?.qh_topMargin(toView: self.logoImageView!, margin: APPMACROS_BASE_MARGIN * 5)
            self.accountTextField?.leftView     = self.textFieldLeftView(image: UIImage(named: "login_account")!)
            self.accountTextField?.placeholder  = "请输入你的手机号"
            self.accountTextField?.keyboardType = .numberPad
            self.accountTextField?.delegate     = self
            self.accountTextField?.addTarget(self,
                                             action: #selector(accountTextFieldDidChange(_:)),
                                             for: UIControlEvents.editingChanged)
            
            self.view.addSubview(self.accountTextField!)
        }
    }
    
    func initPasswordTextField() -> Void {
        
        if self.passwordTextField == nil {
            
            self.passwordTextField = self.textField()
            self.passwordTextField?.qh_topMargin(toView: self.accountTextField!, margin: APPMACROS_LINE_HEIGHT)
            self.passwordTextField?.leftView          = self.textFieldLeftView(image: UIImage(named: "login_password")!)
            self.passwordTextField?.placeholder       = "请输入你的密码"
            self.passwordTextField?.keyboardType      = .default
            self.passwordTextField?.isSecureTextEntry = true
            self.passwordTextField?.delegate          = self
            self.passwordTextField?.addTarget(self,
                                             action: #selector(passwordTextFieldDidChange(_:)),
                                             for: UIControlEvents.editingChanged)
            
            self.view.addSubview(self.passwordTextField!)
        }
    }
    
    func initLoginButton() -> Void {
        
        if self.loginButton == nil {
        
            self.loginButton = UIButton(type: .custom)
            self.loginButton?.qh_x(APPMACROS_BASE_MARGIN * 3)
            self.loginButton?.qh_width(self.view.qh_width() - APPMACROS_BASE_MARGIN * 3 * 2)
            self.loginButton?.qh_height(44.0)
            self.loginButton?.qh_topMargin(toView: self.passwordTextField!, margin: APPMACROS_BASE_MARGIN * 3)
            self.loginButton?.layer.cornerRadius  = 3.0
            self.loginButton?.layer.masksToBounds = true
            self.loginButton?.isEnabled           = false
            self.loginButton?.titleLabel?.font    = APPMACROS_BIG_FONT
            self.loginButton?.setBackgroundImage(UIImage.qh_creatImageWithColor(color:APPMACROS_MAINCOLOR), for: .normal)
            self.loginButton?.setBackgroundImage(UIImage.qh_creatImageWithColor(color:APPMACROS_UNENBLECOLOR), for: .disabled)
            self.loginButton?.setTitleColor(UIColor.white, for: .normal)
            self.loginButton?.setTitle("登录", for: .normal)
            self.loginButton?.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
            self.view.addSubview(self.loginButton!)
        }
    }
    
    func textField() -> UITextField {
        
        let textField = UITextField()
        
        textField.qh_x(0.0)
        textField.qh_width(self.view.qh_width())
        textField.qh_height(40.0)
        textField.textColor       = APPMACROS_MAIN_TEXTCOLOR
        textField.font            = APPMACROS_MAIN_FONT
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode    = .always
        
        return textField
    }
    
    func textFieldLeftView(image:UIImage) -> UIView {
        
        let leftView: UIView = UIView(frame: CGRect(x: 0.0,
                                                    y: 0.0,
                                                    width: (self.accountTextField?.qh_height())!,
                                                    height: (self.accountTextField?.qh_height())!))
        
        let width: CGFloat         = 20.0
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor  = .clear
        imageView.frame            = CGRect(x: (leftView.qh_width() - width) / 2,
                                            y: ((self.accountTextField?.qh_height())! - width) / 2,
                                            width: width,
                                            height: width)
        imageView.contentMode      = .scaleAspectFit
        imageView.image            = image;
        leftView.addSubview(imageView)
        
        return leftView;
    }
}

extension LoginViewController {

    override func isNeedLogin() -> Bool {
        
        return false
    }
}

