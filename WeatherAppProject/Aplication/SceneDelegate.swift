//
//  SceneDelegate.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 12.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray4
        
        let weatherViewController = WeatherViewController()
        
        weatherViewController.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun.fill"), tag: 0)
                                                        
        let citiesViewController = CitiesWeatherListViewController()
        citiesViewController.tabBarItem = UITabBarItem(title: "Cities", image: UIImage(systemName: "globe.central.south.asia.fill"), tag: 1)
        
        
        
        let controllers = [weatherViewController, citiesViewController]
        
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

