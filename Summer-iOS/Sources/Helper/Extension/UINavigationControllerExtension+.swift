//
//  UINavigationControllerExtension+.swift
//  Summer-iOS
//
//  Created by 김승창 on 2022/10/20.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
