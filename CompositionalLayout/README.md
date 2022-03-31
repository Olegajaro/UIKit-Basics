# Compositional Layout

____

Uncomment the desired line of code to run the desired example.

```swift
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        let navController = UINavigationController(
//            rootViewController: ListViewController()
//        )
        
//        let navController = UINavigationController(
//            rootViewController: GridViewController()
//        )
        
//        let navController = UINavigationController(
//            rootViewController: TwoColumnGridViewController()
//        )
        
        let navController = UINavigationController(
            rootViewController: GridWithBadgesViewController()
        )
        
        window?.rootViewController = navController
        
        return true
    }
```

____

## List View

![list]()

____

## Grid View

![grid]()

____

## Two-Column Grid View

![two-column]()

____

## Grid with Badges

![gridBadges]()
