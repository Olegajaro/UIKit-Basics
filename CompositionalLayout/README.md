# Compositional Layout

UICollectionView Compositional layout. Using a Diffable Data Source to retrieve data.

____

Uncomment the desired line of code in `AppDelegate` to run the desired example. 

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

![list](/CompositionalLayout/Images/List.png)

____

## Grid View

![grid](/CompositionalLayout/Images/Grid.png)

____

## Two-Column Grid View

![two-column](/CompositionalLayout/Images/Two-Column.png)

____

## Grid with Badges

![gridBadges](/CompositionalLayout/Images/GridBadges.png)
