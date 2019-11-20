# TimeCrumbs
A time tracking app that encourages users to track tasks under 30 minutes.

## Core Data

The persistent container is created in the App Delegate.
Access it by getting a reference to the App Delegate.

```swift
let appDelegate = UIApplication.shared.delegate as? AppDelegate
appDelegate?.persistentContainer
```

Instead of using a singleton, we use dependency injection to set the managed object context for the view controllers.

e.g. In `SceneDelegate.swift`
```swift
if let rootVC = window?.rootViewController as? ViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    rootVC.moc = appDelegate?.persistentContainer.viewContext
}
```

## Git

#### Feature branch workflow

```bash
# switch to develop
git checkout develop
# fetch the latest changes
git pull origin develop
# create feature branch
git checkout -b feature/add-some-feature
# make changes, add, and commit
git add .
git commit -m "Commit message"
# push feature branch to remote repo
git push -u origin feature/add-some-feature
# switch to develop
git checkout develop
# pull changes to develop
git pull
# pull changes from (remote) feature to (local) develop
git pull origin feature/add-some-feature
# push merged local develop branch to remote
git push
# delete remote feature branch if finished
git push origin --delete feature/add-some-feature
# delete local feature branch
git branch -d feature/add-some-feature
```
