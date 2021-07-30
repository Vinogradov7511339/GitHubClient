//
//  TestController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.07.2021.
//

import UIKit
import TextCompiler

class TestContoller: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5.0
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let text = loadText()
        let parser = Parser(text)
        let nodes = parser.parse()
        fillStackView(with: nodes)
    }
    
    func fillStackView(with nodes: [Node]) {
        var sumText = NSMutableAttributedString()
        for node in nodes {
            switch node {
            case .codeBlock(_, let code):
                if !sumText.string.isEmpty {
                    createViewForText(text: sumText)
                    sumText = NSMutableAttributedString()
                }
                createViewforCodeBlock(code)
            case .header(let depth, let text):
                if !sumText.string.isEmpty {
                    createViewForText(text: sumText)
                    sumText = NSMutableAttributedString()
                }
                createViewForHeader(depth: depth, text: text)
            case .plainText(let text):
                let attr: [NSMutableAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 14.0)]
                let attrstr = NSAttributedString(string: text, attributes: attr)
                sumText.append(attrstr)
            case .bold(let text):
                let attr: [NSMutableAttributedString.Key : Any] = [.font : UIFont.boldSystemFont(ofSize: 14.0) ]
                let attrstr = NSAttributedString(string: text, attributes: attr)
                sumText.append(attrstr)
            case .italic(let text):
                let attr: [NSMutableAttributedString.Key : Any] = [.font: UIFont.italicSystemFont(ofSize: 14.0) ]
                let attrstr = NSAttributedString(string: text, attributes: attr)
                sumText.append(attrstr)
            case .link(let name, _):
                let attr: [NSMutableAttributedString.Key : Any] = [.foregroundColor : UIColor.systemBlue]
                let attrstr = NSAttributedString(string: name, attributes: attr)
                sumText.append(attrstr)
            case .sigleCodeLine(let code):
                let attr: [NSMutableAttributedString.Key : Any] = [.backgroundColor : UIColor.placeholderText]
                let attrstr = NSAttributedString(string: code, attributes: attr)
                sumText.append(attrstr)
            }
        }
        
        func createViewforCodeBlock(_ code: String) {
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.isEditable = false
            textView.backgroundColor = .placeholderText
            textView.clipsToBounds = true
            textView.layer.cornerRadius = 8.0
            textView.text = code
            textView.sizeThatFits(CGSize(width: view.bounds.width - 32.0, height: CGFloat.greatestFiniteMagnitude))
            let height = textView.contentSize.height
            stackView.addArrangedSubview(textView)
            textView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            textView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            textView.heightAnchor.constraint(equalToConstant: height + 10.0).isActive = true
        }
        
        func createViewForHeader(depth: Int, text: String) {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            let size: CGFloat = 14.0 + CGFloat((depth * 3))
            label.font = .boldSystemFont(ofSize: size)
            
            let line = UIView()
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = .separator
            
            stackView.addArrangedSubview(label)
            label.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            
            stackView.addArrangedSubview(line)
            line.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            line.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        }
        
        func createViewForText(text: NSAttributedString) {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.attributedText = text
            stackView.addArrangedSubview(label)
            label.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height).isActive = true
        }
    }
}

private extension TestContoller {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func loadText() -> String{
        guard let path = Bundle.main.path(forResource: "MDTest", ofType: "md") else {
            assert(false, "Can not find file LanguageColors.json")
            return "Can not find file LanguageColors.json"
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let text = String(data: data, encoding: .utf8)
            return text ?? "Empty"
        } catch {
            assert(false, "Error \(error)")
            return "Catch \(error)"
        }
    }
}
