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
    let sphere = SCNNode(geometry: SCNSphere(radius: 0.05))
    
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
        drawOrbitingShip()
//        drawBox1200High()
//        drawPyramid0600Low()
//        drawCatAt900()
//        drawTubeAt300()
//        drawTubeAt900()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func drawOrbitingShip() {
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        let ship = (scene?.rootNode.childNode(withName: "ship", recursively: false))!
        ship.position = SCNVector3(1, 0, 0)
        ship.scale = SCNVector3(0.3, 0.3, 0.3)
        ship.eulerAngles = SCNVector3(0, 100.floatToRadius(), 0)
        sphere.addChildNode(ship)
    }
    
    func drawSphereAtOrigin() {
        //SCNNode : 3d오브젝트
        
        //sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        sphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        sphere.geometry?.firstMaterial?.specular.contents = UIColor.yellow
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
    
    func drawPyramid0600Low() {
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1,
                                                   height: 0.1,
                                                   length: 0.1))
        pyramid.position = SCNVector3(0, -0.2, 0.3)
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.systemGreen
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.systemRed
        
        sceneView.scene.rootNode.addChildNode(pyramid)
    }
    
    func drawCatAt900() {
        let catPicture = SCNNode(geometry: SCNPlane(width: 0.1,
                                                    height: 0.1))
        catPicture.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "cat")
        catPicture.position = SCNVector3(-0.2, 0, 0)
        catPicture.geometry?.firstMaterial?.isDoubleSided = true
        sceneView.scene.rootNode.addChildNode(catPicture)
    }
    
    func drawTubeAt300() {
        let tube = SCNNode(geometry: SCNTorus(ringRadius: 0.05,
                                              pipeRadius: 0.03))
        tube.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        tube.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        
        tube.position = SCNVector3(0.2, 0, 0)
        
        // 45도 회전시키기 (z기준)
        tube.eulerAngles = SCNVector3(0, 0, 45.floatToRadius())
        sceneView.scene.rootNode.addChildNode(tube)
        
    }
    
    func drawTubeAt900() {
        let tube = SCNNode(geometry: SCNTorus(ringRadius: 0.05,
                                              pipeRadius: 0.03))
        tube.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        tube.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        tube.position = SCNVector3(0.0, 0.2, -0.2)
        tube.eulerAngles = SCNVector3(-45.floatToRadius(), 20.floatToRadius(), 45.floatToRadius())
        
        
        let tubeAction = SCNAction.rotate(by: 360.floatToRadius(),
                                          around: SCNVector3(x: 0, y: 1, z: 0),
                                          duration: 8)
        let indefinitelyRotate = SCNAction.repeatForever(tubeAction)
        
        tube.runAction(indefinitelyRotate) {
            print("회전이끝났습니다.")
        }
        
        sceneView.scene.rootNode.addChildNode(tube)
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

extension Int {
    func floatToRadius() -> CGFloat {
        return CGFloat(self) * CGFloat.pi / 100.0
    }
}

