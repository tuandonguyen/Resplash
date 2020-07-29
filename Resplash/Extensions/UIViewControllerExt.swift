//
//  UIViewControllerExt.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/28/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    //Input behavior to show the alert controller.
    //In any view controller, we can call this function and it will show the alert.
//    func presentGFAlertONMainThread(title: String, message: String, buttonTitle: String) {
//
//        //Put code on main thread.
//        DispatchQueue.main.async {
//            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
//            alertVC.modalPresentationStyle = .overFullScreen
//            //Fade in
//            alertVC.modalTransitionStyle = .crossDissolve
//            self.present(alertVC, animated: true)
//        }
//    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }

    
}
