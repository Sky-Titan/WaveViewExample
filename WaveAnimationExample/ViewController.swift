//
//  ViewController.swift
//  WaveAnimationExample
//
//  Created by 박준현 on 2022/07/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var waveView: WaveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func startWave(_ sender: Any) {
        waveView.startWave()
    }
    
    @IBAction func colorChange(_ sender: Any) {
        let colors: [UIColor] = [.red, .green, .blue, .black, .purple, .orange, .yellow, .systemPink]
        let color = colors.randomElement() ?? .clear
        
        let circleColor = color
        let waveColor = color.withAlphaComponent(0.2)
        waveView.circleColor = circleColor
        waveView.waveColor = waveColor
    }
}

