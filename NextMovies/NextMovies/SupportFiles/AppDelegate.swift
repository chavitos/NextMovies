//
//  AppDelegate.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CoreDataManager.sharedInstance.applicationDocumentsDirectory()
        
        let fetch:NSFetchRequest<Category> = Category.fetchRequest()
        do{
            
            let categories = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(fetch)
            if categories.count <= 0 {
                let worker = MockCategoryWorker()
                CotegoryWorker(worker:worker).getCategories { (_, error) in
                    
                    if error == nil {
                        print("Categorias recuperadas com sucesso")
                    }
                }
            }else{
                print("Categorias já carregadas")
            }
        }catch{
            print("Erro ao tentar recuperar categorias: \(error.localizedDescription)")
        }
        
        center.delegate = self
        center.getNotificationSettings { (settings) in
            
        }
        
        //destructive título vermelho e authorization pede para deslockar para exibir
        let confirmAction = UNNotificationAction(identifier: "Confirm", title: "Ok, vou ver!", options: .foreground)
        let category = UNNotificationCategory(identifier: "lembrete", actions: [confirmAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [.customDismissAction])
        
        self.center.setNotificationCategories(Set([category]))
        
        center.requestAuthorization(options: [.alert,.badge]) { (success, error) in
            
            print(success)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.sharedInstance.saveContext()
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "confirm" {
            
            print("confirm")
        }else if response.actionIdentifier == "cancel" {
            
            print("cancel")
        }else if response.actionIdentifier == UNNotificationDefaultActionIdentifier { // quando ele tocou na notif
            
            print("tocou")
        }else if response.actionIdentifier == UNNotificationDismissActionIdentifier {
            
            print("dismiss")
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert,.badge])
    }
}
