//
//  RatingControl.swift
//  UIKitNote
//
//  Created by HuangSenhui on 2020/12/19.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    @IBInspectable var count: Int = 1 {
        didSet {
            guard count > 0 else { return }
            setupSubViews()
        }
    }
    @IBInspectable var size: CGSize = CGSize(width: 45, height: 45) {
        didSet {
            guard size.width > 10, size.height > 10 else { return }
            setupSubViews()
        }
    }
    
    private var ratingButtons: [UIButton] = []
    
    var rating: Int = 0 {
        didSet {
            updateSubViews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    private func setupSubViews() {
        
        for button in ratingButtons {
            self.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let normalImage = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let seletedImage = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for i in 0..<count {
            let button = UIButton()
            button.setImage(normalImage, for: .normal)
            button.setImage(seletedImage, for: .selected)
            button.setImage(seletedImage, for: [.highlighted, .selected])
            button.addTarget(self, action: #selector(tapRatingButton(sender:)), for: .touchUpInside)
            addArrangedSubview(button)
            
            button.accessibilityLabel = "第\(i+1)颗星"
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: size.width),
                button.heightAnchor.constraint(equalToConstant: size.height)
            ])
            
            ratingButtons.append(button)
        }
        updateSubViews()
    }
    
    private func updateSubViews() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            let hintString: String?
            if rating == index + 1 {
                hintString = "轻点归零"
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch rating {
            case 0:
                valueString = "没有设置评级"
            default:
                valueString = "设置了\(rating)星"
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
        
    }
    
    @objc func tapRatingButton(sender: UIButton) {
        if let index = ratingButtons.firstIndex(of: sender) {
            let seletedIndex = index + 1
                        
            if seletedIndex == rating {
                rating = 0
            } else {
                rating = seletedIndex
                sender.accessibilityHint = nil
            }
            
        }
    }
}
