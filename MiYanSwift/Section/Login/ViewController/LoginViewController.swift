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
        
        title = "登录"
        viewModel = LoginViewModel()
        setupView()
        accountTextField?.becomeFirstResponder()
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureClick))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK:  - event response
    @objc fileprivate func loginClick() -> Void {
        
        ProgressHub.show()
        viewModel?.login(messageHandler: { (message: String) in
            
            ProgressHub.showStatus(statusString: message)
        }, completeHandler: { (isSuccess: Bool) in
            
            if isSuccess {
                
                QHLog("跳转")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let tabBarController = TabBarViewController()
                appDelegate.window?.rootViewController = tabBarController
            }
        })
    }
    
    @objc fileprivate func tapGestureClick() -> Void {
        
        accountTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
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
        
        initLogoImageView()
        initAccountTextField()
        initPasswordTextField()
        initLoginButton()
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
            logoImageView              = UIImageView()
            logoImageView?.frame       = CGRect(x: 0.0, y: 0.0, width: FITSCREEN(f: 110.0), height: FITSCREEN(f: 71.0))
            logoImageView?.center      = CGPoint(x: SYSTEMMACROS_SCREEN_WIDTH / 2, y: FITSCREEN(f: 80.0))
            logoImageView?.contentMode = .scaleAspectFit
            logoImageView?.image       = logoImage
            view.addSubview(self.logoImageView!)
        }
    }
    
    func initAccountTextField() -> Void {
        
        if self.accountTextField == nil {
        
            accountTextField = textField()
            accountTextField?.qh_topMargin(toView: logoImageView!, margin: APPMACROS_BASE_MARGIN * 5)
            accountTextField?.leftView     = textFieldLeftView(image: UIImage(named: "login_account")!)
            accountTextField?.placeholder  = "请输入你的手机号"
            accountTextField?.keyboardType = .numberPad
            accountTextField?.delegate     = self
            accountTextField?.addTarget(self,
                                        action: #selector(accountTextFieldDidChange(_:)),
                                        for: UIControlEvents.editingChanged)
            
            view.addSubview(self.accountTextField!)
        }
    }
    
    func initPasswordTextField() -> Void {
        
        if passwordTextField == nil {
            
            passwordTextField = textField()
            passwordTextField?.qh_topMargin(toView: accountTextField!, margin: APPMACROS_LINE_HEIGHT)
            passwordTextField?.leftView          = textFieldLeftView(image: UIImage(named: "login_password")!)
            passwordTextField?.placeholder       = "请输入你的密码"
            passwordTextField?.keyboardType      = .default
            passwordTextField?.isSecureTextEntry = true
            passwordTextField?.delegate          = self
            passwordTextField?.addTarget(self,
                                         action: #selector(passwordTextFieldDidChange(_:)),
                                         for: UIControlEvents.editingChanged)
            
            view.addSubview(passwordTextField!)
        }
    }
    
    func initLoginButton() -> Void {
        
        if loginButton == nil {
        
            loginButton = UIButton(type: .custom)
            loginButton?.qh_x(APPMACROS_BASE_MARGIN * 3)
            loginButton?.qh_width(view.qh_width() - APPMACROS_BASE_MARGIN * 3 * 2)
            loginButton?.qh_height(44.0)
            loginButton?.qh_topMargin(toView: passwordTextField!, margin: APPMACROS_BASE_MARGIN * 3)
            loginButton?.layer.cornerRadius  = 3.0
            loginButton?.layer.masksToBounds = true
            loginButton?.isEnabled           = false
            loginButton?.titleLabel?.font    = APPMACROS_BIG_FONT
            loginButton?.setBackgroundImage(UIImage.qh_creatImageWithColor(color:APPMACROS_MAINCOLOR), for: .normal)
            loginButton?.setBackgroundImage(UIImage.qh_creatImageWithColor(color:APPMACROS_UNENBLECOLOR), for: .disabled)
            loginButton?.setTitleColor(UIColor.white, for: .normal)
            loginButton?.setTitle("登录", for: .normal)
            loginButton?.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
            view.addSubview(loginButton!)
        }
    }
    
    func textField() -> UITextField {
        
        let textField = UITextField()
        
        textField.qh_x(0.0)
        textField.qh_width(view.qh_width())
        textField.qh_height(40.0)
        textField.textColor       = APPMACROS_MAIN_TEXTCOLOR
        textField.font            = APPMACROS_MAIN_FONT
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode    = .always
        
        return textField
    }
    
    func textFieldLeftView(image:UIImage) -> UIView {
        
        let leftView: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: (accountTextField?.qh_height())!, height: (accountTextField?.qh_height())!))
        let width: CGFloat         = 20.0
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor  = .clear
        imageView.frame            = CGRect(x: (leftView.qh_width() - width) / 2, y: ((accountTextField?.qh_height())! - width) / 2, width: width, height: width)
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

