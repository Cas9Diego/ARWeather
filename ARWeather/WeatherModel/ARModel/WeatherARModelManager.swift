//
//  WeatherARModelManager.swift
//  ARWeather
//
//  Created by Diego Castro on 24/01/22.
//

import Foundation
import RealityKit
import ARKit

public class WeatherARModelManager {
    public func generateWeatherARModel(condition: String, temperature: Double, cityName: String) -> ModelEntity {
        //Ball and text
        let conditionModel = weatherConditionModel(condition: condition)
        let temperatureText = createWeatherText(with: temperature, cityName: cityName, condition: condition)
        //Place text on top
        conditionModel.addChild(temperatureText)
        temperatureText.setPosition(SIMD3<Float>(x:-0.2, y:Float(ARViewController.shared.selectedSize+0.02), z:0), relativeTo: conditionModel)
        
        //Name
        
        conditionModel.name = "WeatherBall \(ARViewController.shared.Taps+1)"
        
        return conditionModel

        }
    //Create Ball and text
    // First create de ball
    private func weatherConditionModel (condition: String) -> ModelEntity{
        
        //Mesh
        var ballMesh = MeshResource.generateBox(size: Float(ARViewController.shared.selectedSize))
        
        if ARViewController.shared.selectedModel == 0 {
            ballMesh = MeshResource.generateSphere(radius: Float(ARViewController.shared.selectedSize))
        }
        
        //VideoMaterial
        let videoItem = createVideoItem (with: condition)
        let videoMaterial = createVideoMaterial (with: videoItem!)
        //ModelEntity
        let ballModel = ModelEntity(mesh: ballMesh, materials: [videoMaterial])
        
        return ballModel
        
    }
    
    private func createVideoItem (with fileName: String) -> AVPlayerItem?{
  
        //URL
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp4") else { return nil }
        
        //Video Item
        let asset = AVURLAsset(url:url)
        let videoItem = AVPlayerItem(asset: asset)
        
        return videoItem //This has the reference for the video we want to play
        
    }
    
    private func createVideoMaterial (with videoItem: AVPlayerItem) -> VideoMaterial{
        
        //VideoPlayer
        let player = AVPlayer()
        
        //Video Material
        let videoMaterial = VideoMaterial (avPlayer: player)
        
        //Play video
        player.replaceCurrentItem(with: videoItem)
        player.play()
        
        return videoMaterial
        
    }
    //Create text with temperature
    private func createWeatherText (with temperature: Double, cityName: String, condition: String) -> ModelEntity {
        let mesh = MeshResource.generateText("         \(cityName) \n Temperature: \(temperature) ªC. \n Forecast: \(condition)", extrusionDepth: 0.1, font: .systemFont(ofSize: 1), containerFrame: .zero, alignment: .left, lineBreakMode: .byTruncatingTail)
        
        let material = SimpleMaterial(color: .white, isMetallic: false)
        
        let textEntity = ModelEntity (mesh: mesh, materials: [material])
        
        if  ARViewController.shared.selectedSize <= 0.5 {
        textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
        } else {
            textEntity.scale = SIMD3<Float>(x: 0.06, y: 0.06, z: 0.2)
        }
        
        return textEntity
    }
    
    
    
}
