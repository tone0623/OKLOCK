//
//  StartAudioViewController.swift
//  enPiT2SUProduct
//
//  Created by 利根川涼介 on 2019/11/22.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import AVFoundation

class StartAudioViewController: UIViewController {

    var audioPlayerInstance : AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let soundFilePath = Bundle.main.path(forResource: "decision3", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成でエラー")
        }

        audioPlayerInstance.prepareToPlay()        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func sound(_ sender: UIButton) {
        audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
        audioPlayerInstance.play()                  // 再生する

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
