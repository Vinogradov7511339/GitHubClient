//
//  Event+Extensions.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

extension Event {
    var title: String {
        switch type {
        case .createEvent:
            return "\(user.login) create \(repositoryName)"
        case .deleteEvent:
            return "\(user.login) delete \(repositoryName)"
        case .forkEvent:
            return "\(user.login) forked \(repositoryName)"
        case .pushEvent:
            return "\(user.login) contributed to \(repositoryName)"
        case .releaseEvent:
            return "New release in \(repositoryName) created by \(user.login)"
        case .pullRequestReviewEvent:
            return "\(user.login) reviewed pull request in \(repositoryName)"
        case .watchEvent:
            return "\(user.login) watched \(repositoryName)"
        default:
            return type.rawValue
        }
    }

    var tempTitle: String {
        fullTitle.string
    }

    var tempLinks: [(String, URL)] {
        let userLink = (user.login, user.url)
        let repositoryLink = (repositoryName, repositoryURL)
        let links = [userLink, repositoryLink]
        return links
    }

    var fullTitle: NSAttributedString {
        let userLink = (user.login, user.url)
        let repositoryLink = (repositoryName, repositoryURL)
        let links = [userLink, repositoryLink]
        switch type {
        case .commitCommentEvent:
            return "\(user.login) commited in \(repositoryName)".attributed(links)
        case .createEvent:
            return "\(user.login) create \(repositoryName)".attributed(links)
        case .deleteEvent:
            return "\(user.login) delete \(repositoryName)".attributed(links)
        case .forkEvent:
            return "\(user.login) fork \(repositoryName)".attributed(links)
        case .gollumEvent:
            return "\(user.login) create wiki in \(repositoryName)".attributed(links)
        case .issueCommentEvent:
            return "\(user.login) commented \(repositoryName)".attributed(links)
        case .issuesEvent:
            return "\(user.login) create issue in \(repositoryName)".attributed(links)
        case .memberEvent:
            return "\(user.login) become member in \(repositoryName)".attributed(links)
        case .publicEvent:
            return "\(user.login) make public \(repositoryName)".attributed(links)
        case .pullRequestEvent:
            return "\(user.login) open pull request \(repositoryName)".attributed(links)
        case .pullRequestReviewEvent:
            return "\(user.login) reviewed pull request in \(repositoryName)".attributed(links)
        case .pullRequestReviewCommentEvent:
            return "\(user.login) commented pull request in \(repositoryName)".attributed(links)
        case .pushEvent:
            return "\(user.login) pushed in \(repositoryName)".attributed(links)
        case .releaseEvent:
            return "\(user.login) make release in \(repositoryName)".attributed(links)
        case .sponsorshipEvent:
            return "\(user.login) start sponsored \(repositoryName)".attributed(links)
        case .watchEvent:
            return "\(user.login) watched \(repositoryName)".attributed(links)
        }
    }

    var image: UIImage? {
        switch type {
        case .commitCommentEvent: return UIImage.Event.comment
        case .createEvent: return UIImage.Event.repository
        case .deleteEvent: return UIImage.Event.repository
        case .forkEvent: return UIImage.Event.fork
        case .gollumEvent: return UIImage.Event.gollum
        case .issueCommentEvent: return UIImage.Event.comment
        case .issuesEvent: return UIImage.Event.issue
        case .memberEvent: return UIImage.Event.group
        case .publicEvent: return UIImage.Event.repository
        case .pullRequestEvent: return UIImage.Event.pullRequest
        case .pullRequestReviewEvent: return UIImage.Event.watch
        case .pullRequestReviewCommentEvent: return UIImage.Event.comment
        case .pushEvent: return UIImage.Event.commit
        case .releaseEvent: return UIImage.Event.release
        case .sponsorshipEvent: return UIImage.Event.group
        case .watchEvent: return UIImage.Event.watch
        }
    }
}

private extension String {
    func attributed(_ links: [(String, URL)]) -> NSAttributedString {
        let startAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.secondaryLabel]
        let attrStr = NSMutableAttributedString(string: self,attributes: startAttributes)
        for link in links {
            let range = attrStr.mutableString.range(of: link.0)
            attrStr.addAttribute(.link, value: link.1, range: range)
        }
        return attrStr
    }
}
