//
//  UIViewController+NoData.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit
import Lottie

extension UIViewController {
    func showNoData() {
        let view = AnimationView(frame: view.frame)
        view.animation = Animation.named(String.LoadingAnimation.paperplane)
        view.loopMode = .loop
        view.play()
    }

    func hideNoData() {
        let loader = view.subviews.first(where: { $0 is AnimationView }) as? AnimationView
        loader?.stop()
        loader?.removeFromSuperview()
    }
}
