//
//  Constants.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

extension UIColor {
    static var main: UIColor = UIColor(red: 62/255, green: 193/255, blue: 215/255, alpha: 1)
}

extension UITableView {
    func register<T: UITableViewCell>(cellType cls: T.Type) {
        let cellClass = String(describing: cls)
        register(cls, forCellReuseIdentifier: cellClass)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass cls: T.Type) -> T {
        let nibName = String(describing: cls)
        return dequeueReusableCell(withIdentifier: nibName) as! T
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    func add(childViewController: UIViewController, to placeholder: UIView) {
        childViewController.willMove(toParent: self)
        self.addChild(childViewController)
        
        childViewController.view.frame = placeholder.bounds
        placeholder.addSubview(childViewController.view)
        placeholder.backgroundColor = .clear
        
        childViewController.didMove(toParent: self)
    }
    
    func removeFromParentController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        self.didMove(toParent: nil)
    }
}

extension UIImageView {
    public func image(with urlString: String?, placeHolderImage: String? = nil) {
        func setImage(image: UIImage?) {
            async {
                self.image = image
            }
        }
        
        if let imageName = placeHolderImage,
            let image = UIImage(named: imageName) {
            setImage(image: image)
        }
        
        guard let str = urlString, let url = URL(string: str) else {
            return
        }
        
        let theTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                setImage(image: UIImage(data: response))
            }
        }
        
        theTask.resume()
    }
}
