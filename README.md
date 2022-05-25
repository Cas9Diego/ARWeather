# ARWeather

Consult the weather forecast of any city on the world, in a funny and entertaining way, using Augmented reality technology. 

Structure

    iOS/You will find the Xcode project containing all you need to run the App. 

Requirements

    To run the iOS project, you must use Xcode 13.3 or later.

Frameworks

    SwiftUI
    RealityKit
    ARKit
    Foundation
    
 IMPORTANT: BEFORE RUNNING THE APP, THE USER SHOULD GET AN API KEY, WHICH SHOULD BE PASTED IN THE "ApiKey" FILE IN THE PROJECT. You can get a Free API key here --> https://openweathermap.org/api

How it Works:
                
    Run the App. You will find an initial screen. Tan on the botton "Choose a 3D body" in order to pick between a cube and a sphere. A Cube is selected by default. 
    Afterwards, tap the "Go AR" button. This works only in an actual devide, not in the simulator. 
    Write the name of a city, press the retrun key, and tap on the screen in order to create de 3D body. You should look for a flat surface, since the program is designed to build the bodies only when there is a suitable, flat surface the build them on. You can create several bodies by tapping several times.
    Tap on the "eye" button in order to make the search bar appear and disappear. The downwards arrow will close the Aumented Reality view. The turning arrow will eliminate the last 3D body created. The "minus" key will eliminate all the 3D bodies. 
    
    This is how it should look: ![ARWeather](https://user-images.githubusercontent.com/99818957/170265155-c5a9a4e7-0cb0-4a3f-8d36-7cec21aed27a.jpeg)


 

