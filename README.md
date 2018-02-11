# About the project

This application is pretended to be used as a tool which permits manage all your loans, giving you the opportunity to don't 
worry about memorizing who is in debt with you, how much money did you lend and how much money would you win after the loan finishes.

In order to make the best of this project, we have searched about different software design patterns like _MVC_, _VIPER_, _MVVM_ and we've chosen the combining between _MVP_ and _Clean architecture_. If you'd like to contribute us, please read [CONTRIBUTING](https://github.com/opelty/blacklist-ios/blob/master/CONTRIBUTING.md)

# About us

We are fascinated iOS and software developers, enjoy converting a cup of ☕️ in hundred lines of code. We met in our actual job and decided to start developing open source applications wishing someday the community can contribute in our projects and help us making a "common" application into a big one with the best coding practices and using a clean architecture.

- **Jose Lopez**.

  ![Jose Lopez](https://avatars1.githubusercontent.com/u/10122028?s=150&v=4)

  > Add an small bio here...

- **Santiago Carmona.**

  ![Santiago Carmona](https://avatars2.githubusercontent.com/u/5218843?s=150&v=4)

  > Add an small bio here 

- **Mateo Olaya.**

  ![Mateo Olaya](https://avatars1.githubusercontent.com/u/1709983?s=150&v=4)

  > Mateo loves software development and he started with Objective-C as his first programming language 7 years ago. He knows Swift, Objective-C, C/C++ and Ruby.
  >
  > Last updated: Feb/2018

# Dependencies


### CocoaPods 

We are using CocoaPods as the dependencies manager, please before running the project execute the pod install command in order to build and install the dependencies listed below.

- SwiftLint: https://github.com/realm/SwiftLint
- SwiftRealm: https://realm.io/docs/swift/latest/

```ruby
# Podfile
# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'blacklist' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for blacklist
  pod 'RealmSwift'
  pod 'SwiftLint'

  target 'blacklistTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```



If you need to build those dependencies, please run:

```bash
$ pod install
```

> Please avoid use ```pod update``` until we request dependency update.