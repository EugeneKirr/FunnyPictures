//
//  SceneDelegate.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 02/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let menuNavController = prepareVCForTabBar(storyboardName: "Menu", vcIdentifier: "menuVC", withNavController: true, tabBarTitle: nil, tabBarImageName: "house.fill", tabBarTag: 0)
        
        let myCollectionNavCotroller = prepareVCForTabBar(storyboardName: "MyCollection", vcIdentifier: "myCollectionVC", withNavController: true, tabBarTitle: nil, tabBarImageName: "star.fill", tabBarTag: 1)
        
        let customizerNavController = prepareVCForTabBar(storyboardName: "Customizer", vcIdentifier: "customizerVC", withNavController: true, tabBarTitle: nil, tabBarImageName: "gear", tabBarTag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = UIColor.lightGray
        tabBarController.setViewControllers([menuNavController, myCollectionNavCotroller, customizerNavController], animated: true)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func prepareVCForTabBar(storyboardName: String, vcIdentifier: String, withNavController: Bool, tabBarTitle: String?, tabBarImageName: String, tabBarTag: Int) -> UIViewController {
        let customTabBarItem = UITabBarItem(title: tabBarTitle, image: UIImage(systemName: tabBarImageName), tag: tabBarTag)
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: vcIdentifier)
        guard withNavController else {
            viewController.tabBarItem = customTabBarItem
            return viewController
        }
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = customTabBarItem
        return navController
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

