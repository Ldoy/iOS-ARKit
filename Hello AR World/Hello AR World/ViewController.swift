//
//  ViewController.swift
//  Hello AR World
//
//  Created by Joey deVilla on 12/4/18.
//  Copyright © 2018 Joey deVilla. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // 디버그 해주는 기능
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,
                                ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        drawSphereAtOrigin()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

  func drawSphereAtOrigin() {
      //SCNNode : 3d오브젝트
    let sphere = SCNNode(geometry: SCNSphere(radius: 0.05))
    sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
      //SCNVector3 : 물체(노드)의 위치를 가운데에 두겠다는 것
    sphere.position = SCNVector3(0, 0, 0)
      //현재 노드가 하나도 없기 때문에 루트 노드에 추가해야함
    sceneView.scene.rootNode.addChildNode(sphere)
  }
    
    func drawBox1200High() {
        let box = SCNNode(geometry: SCNBox(width: 0.2,
                                           height: 0.2,
                                           length: 0.2,
                                           chamferRadius: 0.0))
        
        box.position = SCNVector3(0, 0.2, -0.3)
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        box.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        sceneView.scene.rootNode.addChildNode(box)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
