//
//  BlurEffectView.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

final class BlurEffectView: UIVisualEffectView {
    private var animator: UIViewPropertyAnimator!

    // MARK: Life cycle
    init(effect: UIVisualEffect = UIBlurEffect(style: .regular), intensity: CGFloat) {
        super.init(effect: nil)

        animator = UIViewPropertyAnimator(duration: Constants.Durations.blurEffectPropertyAnimatorDuration, curve: .linear) { [unowned self] in
            self.effect = effect
        }
        animator.fractionComplete = intensity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You can't use BlurEffectView from Xib's or StoryBoards")
    }
}
