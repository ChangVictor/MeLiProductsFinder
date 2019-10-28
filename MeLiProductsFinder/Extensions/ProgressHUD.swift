//
//  ProgressHUD.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 25/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class ProgressHUD: UIView {
    
    var loadingView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    static let shared: ProgressHUD = {
        let instance = ProgressHUD()
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepared()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepared() {
        
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        let frame = keyWindow!.frame
        self.frame = frame
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingView.center = self.center
        loadingView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        self.addSubview(loadingView)
        
        activityIndicator.frame = loadingView.frame
        activityIndicator.center = loadingView.center
        activityIndicator.style = .large
        self.addSubview(activityIndicator)
    }
    
    public static func loadInstance() -> ProgressHUD {
        let window = UIApplication.shared.keyWindow!
        let view = UIView(frame: window.bounds)
        window.addSubview(view);
        return ProgressHUD()
    }
    
    func show() {
        let application = UIApplication.shared.delegate as! SceneDelegate
        application.window?.addSubview(self)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.bringSubviewToFront((application.window?.rootViewController?.view)!)
    }
    
    func hide() {
        self.removeFromSuperview()
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
