//
//  ViewController.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 12/10/2018.
//  Copyright (c) 2018 Zandor Smith. All rights reserved.
//

import UIKit
import GeneralToolsFramework

class ViewController: UIViewController {

    @IBOutlet weak var button: UIBlueButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        let image = Image(url: "https://picsum.photos/240/128", cachingKey: "https://picsum.photos/240/128")

        image.getImage(available: { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }, onError: { error in
            print(error)
            DispatchQueue.main.async {
                self.imageView.image = nil
            }
        })
    }

}
