//
//  ErrorAlertView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ErrorAlertView: UIView, NibLoadable {

    // MARK: - Create

    static func create(with error: Error, reloadHandler: @escaping () -> Void) -> ErrorAlertView {
        let alert = ErrorAlertView.createFromNib()
        alert.error = error
        alert.reloadHandler = reloadHandler
        return alert
    }

    // MARK: - Views

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: - Private variables

    var error: Error!
    var reloadHandler: (() -> Void)?

    // MARK: - Actions

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn) {
            self.containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        } completion: { _ in
            self.removeFromSuperview()
        }
        reloadHandler?()
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
