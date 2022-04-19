//
//  ProgressView.swift
//  teste_tecnico
//
//  Created by Maria Tupich on 15/04/22.
//

import UIKit

class ProgressView: UIView {
    
    lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.trackTintColor = UIColor(white: 1, alpha: 0.0)
        bar.tintColor = UIColor(red: 112.0/255.0, green: 10.0/255.0, blue: 248.0/255.0, alpha: 0.7)
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        addSubview(progressBar)
        
        let width = bounds.width
        let height = bounds.height

        progressBar.bounds.size.width = width
        progressBar.bounds.size.height = height
        progressBar.center.x = bounds.midX
        progressBar.center.y = bounds.midY
    }
    
}




