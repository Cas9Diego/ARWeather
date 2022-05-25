//
//  ARViewController.swift
//  ARWeather
//
//  Created by Diego Castro on 23/01/22.


import ARKit
import Foundation
import RealityKit
import SwiftUI


final class ARViewController : ObservableObject {
    static var shared = ARViewController()
    private var weatherModelAnchor: AnchorEntity?
    
    @Published var arView:ARView
    @Published var EliminateAllProperties = false
    @Published var EliminateProperties = false
    @Published var Taps = 0 //Number of Taps
    @Published var backTaps = 0 //Number of "eliminate recent"
    @Published var furtherTaps = 0 //Number of new taps after eliminate recent
    @Published var selectedModel = 0 //Chosen body
    @Published var selectedSize = 0.1 //Size of body
    
    init (){
        arView = ARView(frame: .zero)
        
    }
    public func startARSession (){
        startPlaneDetection()
        
        startTapDetection()
    }
    
    private func startPlaneDetection(){
        
        arView.automaticallyConfigureSession = true
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        //Start Plane detection
        arView.session.run(configuration)
    }
    
    private func  startTapDetection(){
        arView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(recognizer:))
        )
        )
    }
    private var weatherModelGenerator = WeatherARModelManager()
    private var isWeatherBallPlaced: Bool = false //Se usa para que el objeto solo se apuesto una sola vez
    var receivedWeatherData = WeatherModel(cityName: "Barcelona", temperature: 20, conditionID: 2) {
        didSet{
            updateModel(temperature: receivedWeatherData.temperature, condition: receivedWeatherData.conditionName)
            
        }
    }
    @objc
    private func handleTap(recognizer: UITapGestureRecognizer) {
        //Touch Location (get 2D location from the tap)
        let tapLocation = recognizer.location(in: arView)
        //Raycast (converts 2D location in 3D)
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        //If plane detected (get acess to first plane detected)
        if let firstResult = results.first {
            //get acess to 3D location of Tap point
            let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
            let weatherBall = weatherModelGenerator.generateWeatherARModel(condition: receivedWeatherData.conditionName, temperature: receivedWeatherData.temperature, cityName: receivedWeatherData.cityName)
            //place object
            placeObject(object: weatherBall, at: worldPosition)
            Taps=Taps+1
        }
    }
    
    func placeObject(object modelEntity: ModelEntity, at position: SIMD3<Float>){
        //   This function puts the modelEntity in a 3D location in the real world (SIMD3)
        //1- Create anchor at 3D position
        let weatherModelAnchor = AnchorEntity(world: position)
        //2- Tie model to anchor
        weatherModelAnchor.addChild(modelEntity)
        withAnimation {
            //3- Add anchor to scene
            arView.scene.addAnchor(weatherModelAnchor)
        }
        modelEntity.generateCollisionShapes(recursive: true)
        arView.installGestures( [.translation, .rotation, .scale], for: modelEntity)
    }
    
    private func updateModel (temperature: Double, condition: String) {
        
        guard let anchor0 = weatherModelAnchor else {
            let newWeatherBall = weatherModelGenerator.generateWeatherARModel(condition: condition, temperature: temperature, cityName: receivedWeatherData.cityName)
            let anchor = AnchorEntity(world: .zero)
            weatherModelAnchor?.addChild(newWeatherBall)
            return
        }
        
    }
    
    func oneElimination () {
        
        if EliminateProperties == true {
            
            if Taps > 0 {
                
                arView.scene.findEntity(named: "WeatherBall \(Taps)")?.removeFromParent()
                Taps = Taps-1
                EliminateProperties = false
            }
        }
    }
    func elimination () {
        
        if EliminateAllProperties == true {
            if Taps > 0 {
                for Tap in 1...Taps {
                    arView.scene.findEntity(named: "WeatherBall \(Tap)")?.removeFromParent()
                    
                    EliminateAllProperties = false
                    Taps = 0
                }
            }
        }
    }
}
