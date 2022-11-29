//
//  SceneDelegate.swift
//  ImageSearcher
//
//  Created by Kyzu on 28.11.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
               let navController = UINavigationController()
               coordinator = AppCoordinator(navigationController: navController)
               window = UIWindow(windowScene: windowScene)
               
               
               if ImageFileManager.shared.retrieveImage(forKey: "profileImage") != nil {
                   let storyboard = UIStoryboard(name: "ProfileMenuTabBarController", bundle: .main)
                   let viewController = storyboard.instantiateInitialViewController() as! ProfileMenuTabBarController
                   window?.rootViewController = viewController
               } else {
                   coordinator?.toRegistrationScreen()
                   window?.rootViewController = navController
               }
 
               window?.makeKeyAndVisible()
    }
    
}

