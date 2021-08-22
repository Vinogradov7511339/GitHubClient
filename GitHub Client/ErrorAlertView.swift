//
//  ErrorAlertView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ErrorAlertView: UIView, NibLoadable {

    // MARK: - Create

    static func create(with error: Error) -> ErrorAlertView {
        let alert = ErrorAlertView.createFromNib()
        alert.error = error
        return alert
    }

    // MARK: - Views

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Private variables

    var error: Error!

    // MARK: - Actions

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn) {
            self.containerView.transform = CGAffineTransform.identity
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    func show(in view: UIView) {
        view.addSubview(self)
        configure()
    }

    // MARK: - Private

    private func configure() {
        titleLabel.text = NSLocalizedString("Error happend here", comment: "")
        descriptionLabel.text = error.localizedDescription
    }
}
