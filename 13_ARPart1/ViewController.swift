//
//  ViewController.swift
//  13_ARPart1
//
//  Created by shota ito on 07/11/2018.
//  Copyright © 2018 shota ito. All rights reserved.
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

        // --------- setting an object (before it is shown on a display)--------------
        // creating a sphere and assigning the texture(image)
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
        sphere.materials = [material]
        
        // creating a node object
        let node = SCNNode()
        node.position = SCNVector3(0, 1.5, -0.5)
        
        // placing the moon
        node.geometry = sphere
        // --------- setting an object (before it is shown on a display)--------------
        
        //adding the moon on the scene
        sceneView.scene.rootNode.addChildNode(node)
        
        //project light on the moon and make it look like a 3D object
        sceneView.autoenablesDefaultLighting = true
        
        
        
        
        
        
        
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    // just added codes here -------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        let hitTransform = SCNMatrix4(hitResult.worldTransform)
        let hitVector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        createBall(position: hitVector)
        
    }
    
    func createBall(position: SCNVector3 ){
        
        var ballShape = SCNSphere(radius: 0.01)
        var ballNode = SCNNode(geometry:  ballShape)
        ballNode.position = position
        sceneView.scene.rootNode.addChildNode(ballNode)
        
    }
///------------------------------------------------------------------------------------------------
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
