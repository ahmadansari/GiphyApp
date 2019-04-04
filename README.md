# GiphyApp
A Sample Giphy App

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and debugging purposes.

### Prerequisites

Application is using CocoaPods for dependency management. In order to install CocoaPods run following command on Terminal:

```
$ sudo gem install cocoapods
```
See [Getting Started on CocoaPods](https://guides.cocoapods.org/using/getting-started.html) for more informaiton.


### Installing
- Open Terminal and run following command to install pods:
```
$ pod install
```
- Navigate to project directory and open project using *GiphyApp.xcworkspace*
- Build and run the application on simulator or actual device running iOS 11.0 or later using Xcode 10.2

## User Guidelines
- Upon launciing, app automatically starts fetching first 20 pages with 25 images per page limit, and once downloaded, images are displayed in grid view, with fixed 3 column size. 
- GIF images are downloaded lazily, using Kingfisher api.
- Tapping on More button will fetch next page with 25 images. Incremental behavior can be observed after scrolling to the bottom and then tapping on More button.
- Tapping on any image will open detail page with large preview of the GiF.

## Technical Notes

### Architecture
- For Architecture purpose MVVM is used along with Builder and Coordinator.
- Builder surves the modules construction prupose.
- Coordinator is used for navigation.
- RxSwift is used for binding mechanism. 
- CoreData is used for persistence mechanism.

### Code Structure
Code has been strucutred into three main categories, Sources, Resources and Supporting Files:
- Sources contain all code files, views, extensions, business logic, etc.
- Resources contains Assets.
- Supporting Files contain plist, and main file.

### Code Coverage
- Test cases for each module, logic and services are provided.
- Code Coverage is upto 64%.

### Code Styling
- SwiftLint is configured and run script is added on build time, so Swift code is automatically indented upon each build.

### Third Party
- RxSwift (For MVVM binding plus handling  `NSFetchedResultsController` callbacks)
- Alamofire (For network calls, Service wrapper layer developed) 
- SwiftyBeaver (For console logging)
- SwiftLint (For autmatic code indentation)
- Kingfisher (For downloading and caching images)
- KRProgressHUD (For displaying progress)

### Improvements & Known Issues
- Pagination is manual using More button. Normally its done automatically upon scrolling to bottom of the view (e.g. `willDisplayForItemAtIndexPath`). Auto paging code is commented to block extra network calls to giphy api. In case of frequent calls, api responds with limit exceed error, which is the reason why More button is provided to fetch futher pages.
- Some GIFs are not properly rendered in large sizes, stills are shown instead. Possibly issue with GIF size or corrupt GIF.

## Sample Screens
![Trending](Screenshots/trending.gif)

See Application Video here:  [appPreview.mp4](Screenshots/appPreview.mp4)

## Built With

* [CocoaPods](https://cocoapods.org/) - Dependency Management

## Versioning

Version 1.0
For more information on versioning, see [Semantic Versioning](http://semver.org/).

## Authors

* **Ahmad Ansari** - (https://github.com/ahmadansari)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

