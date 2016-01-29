# History

1. Come up with an idea for the app
1. Mock up a few screen to get a picture
1. Write the backlog stories
1. Create a single-view Swift application
1. Set up Carthage and test frameworks
    
    - `$ carthage update --platform iOS`
    - drag the frameworks to the project
    
    For *every relevant target* go to the **Build Phases** tab:
        
      - Check if the framework is present in the **Link Binary with Libraries** list. If not, drag it into that list
      - Check whether a **Copy Files** phase for **Frameworks** is present. If not, create one.
      - Drag the framework into the list for the above phase
      
    The relevant target above could be either the application target, or one or more testing targets.

1. Use quick and nimble for unit tests and UI tests
1. Use UI tests for testing framework-driven classes (UIViewController/UITableViewController/custom Cell classes)
1. Capturing values for use within a `describe` block:

        describe("Something") {
            var allLabels:XCUIElementQuery!
            
            beforeEach {
                allLabels = XCUIApplication().labels
            }
            
            it("uses myValue") {
               expect(allLabels.count).to(equal(5))
            }
        }

1. Note: `XCUIElementQuery` is not compatible with the `haveCount` Nimble matcher, have to call `count`.
1. XCode vs AppCode:
    XCode:
        - v UI Tests
        - v Storyboards
        - v Core Data modelling
        - x Code editing has it's own flavour
        - x Can't run individual tests with Quick
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
1. Prefer Carthage over cocoapods because - CI; swift packages are not production ready (Swift 3.0)
1. use `@testable` import of the application module in the tests
1. Due to the way UI tests are organized, the HTTP stubbing must be performed from production code. Sadly, that 
code should also be included into the production target.
http://stackoverflow.com/questions/32827592/is-it-possible-to-stub-http-requests-in-xcode-7-automated-ui-tests
An approach to stubbing HTTP for UI tests is to substitute the service providers with mock ones.
Service factories can be used to do that. To isolate the factory logic from production code,
it can be surrounded by `#if DEBUG` `#else` `#endif` directives. To enable that, the flag `-DDEBUG`
should be set in the "Debug" case of the "Other Swift flags" section of "Swift Compiler - Other flags" in
 Build settings of the application target.