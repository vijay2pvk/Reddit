//
//  AlertPresentable.swift
//  Reddit
//
//  Created by Vijaya Kumar Pandurangan on 16/08/21.
//
import UIKit

protocol RedditAlertPresentable {
    func showAlert(title: String?, message: String?)
}

extension RedditAlertPresentable where Self: UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
