# History

1. Come up with an idea for the app
1. Mock up a few screen to get a picture
1. Write the backlog stories
1. Create a single-view Swift application
1. Set up cocoapods and test frameworks
1. Use quick and nimble for unit tests and UI tests
1. Use UI tests for testing framework-driven classes (UIViewController/UITableViewController/custom Cell classes)
1. Capturing values for use within a `describe` block:

```swift

    describe("Something") {
        var allLabels:XCUIElementQuery!
        
        beforeEach {
            allLabels = XCUIApplication().labels
        }
        
        it("uses myValue") {
           expect(allLabels.count).to(equal(5))
        }
    }
```

1. Note: `XCUIElementQuery` is not compatible with the `haveCount` Nimble matcher, have to call `count`.
1. XCode vs AppCode:
    XCode:
        - v UI Tests
        - v Storyboards
        - v Core Data modelling
        - x Code editing has it's own flavour
    AppCode:
        - x Errors are not always shown
        - x Code completion is far from perfect
        - x Most refactoring tools do not work (yet)
        - x Run test shortcuts incompatible with Quick
        - v List of methods to override (methods to implement are also in the same list)
        - v Text editing features and plugins
        - v Core Data Debugging
        - v Non-language specific features (VCS, Local History, Live Templates)
        
1. Testing with Mac OS X Server
1. Prefer Carthage over cocoapods because - CI; swift packages?