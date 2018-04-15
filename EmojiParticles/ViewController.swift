//
//  ViewController.swift
//  ParticlesBackground
//
//  Created by Andrew Turkin on 29.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet weak var particleView: SKView!
    @IBOutlet weak var messageTextField: UITextField!
    var scene: SKScene!
    var messages: [Message] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        scene = SKScene(size: particleView.frame.size)
        particleView.presentScene(scene)
    }
    
    func setupParticleView(text: String) {
        let image = generateImageWithText(text: text)
        let emitter = SKEmitterNode()
        emitter.particleTexture = SKTexture(image: image)
        emitter.numParticlesToEmit = 5
        emitter.particleLifetime = 5
        emitter.particleLifetimeRange = 0
        emitter.particleScale = 0.5
        emitter.particleScaleRange = 0.3
        emitter.particleScaleSpeed = 0.15
        emitter.particleBirthRate = 3
        emitter.particleSpeed = 120
        emitter.particleSpeedRange = 50
        emitter.particlePositionRange = CGVector(dx: particleView.frame.size.width/2, dy: 5)
        emitter.particlePosition = CGPoint(x: particleView.frame.size.width/2, y: 0)
        emitter.targetNode = scene
        scene.addChild(emitter)
    }
    
    func generateImageWithText(text: String) -> UIImage
    {
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 36)]
        let size = text.size(withAttributes: attributes)
        UIGraphicsBeginImageContext(size)
        text.draw(in: CGRect(origin: CGPoint.zero, size: size), withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func sendMessageAction(_ sender: Any) {
        if let text = messageTextField.text {
            if text.count == 1 {
                if text.emojis.count > 0 {
                    setupParticleView(text: text)
                }
            }
            let message = Message(author: "Player", message: text)
            messages += [ message ]
            messageTextField.text = ""
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageCell.self), for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.authorLabel.text = message.author
        cell.contentLabel.text = message.message
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}
