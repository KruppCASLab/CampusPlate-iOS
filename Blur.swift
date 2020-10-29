//
//  Blur.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 10/8/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
