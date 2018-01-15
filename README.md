# SSEventListener

[README中文入口](README_cn.md)

`SSEventListener` is an iOS library which gives you the simplest way to detect **device shake motion, application lifecycle events, view gestures and button tap event** using **blocks**! All of the staff behind the library are from iOS system. However, using the library will make your code more beautiful and readable and your development more efficient.

## Features

* **Shake Event Listener**: Your view controller doesn't need to override `motionEnded:withEvent:` any more! With `SSEventListener`, you can listener for shake event as simple as this: `[viewController ss_setShakeEventListener:^{ ... }];`
* **Application Event Listener**: No more NSNotification staff you will need to use. `SSEventListener` endows every object with the power to listen for application lifecycle events like `UIApplicationDidEnterBackgroundNotification`, `UIApplicationWillEnterForegroundNotification` and so on. And the coding part will never rely on separated methods instead of writing something like `[obj ss_setApplicationEventListener:^(NSNotificationName notificationName, UIApplication *application) { ... }];` only.
* **View Gesture Event Listener**: Currently, `SSEventListener` supports setting listener blocks on a view to listener for single tap gesture, double tap gesture and N-tap gesture if you like, and long press gesture. Setting a single tap gesture listener becomes this way: `[view ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) { ... } numberOfTapsRequired:1];`.
* **Button Tap Event Listener**: The library also provides a specific tap event listener for button. You can replace your `addTarget...` code with `[button ss_setTapButtonEventListener:^{ ... }];`.

## Demo App

Like to try a demo app? Please download or git clone the repository. Open the `SSEventListener.xcworkspace` with your favorite IDE and run the `SSEventListenerDemo` target. Don't forget to change the signing team with yours in the `SSEventListenerDemo` project settings.

## Installation

### CocoaPods

CocoaPods support will be available soon. Please install `SSEventListener` manually instead.

### Manual

Copy source files under `SSEventListener` folder into your project. These source files are:

* `SSEventListener.h`
* `UIViewController+SSShakeEventListener.h/.m`
* `NSObject+SSApplicationEventListener.h/.m`
* `UIView+SSGestureEventListener.h/.m`
* `UIButton+SSTapEventListener.h/.m`

Import the main header file with:

```objectivec
#import "SSEventListener.h"
```

And the installation is done! Now please refer to the `Usage` section or the demo app project to see how to use the library.

**Note**: If you only want to use part of the library for example, the `SSShakeEventListener`. You can only copy  `UIViewController+SSShakeEventListener.h/.m` files into your project and import the `.h` file. It's better if you want to minimize the binary size of your application or framework.

## Usage

### Shake Event Listener

We always listen for device shake event in the view controller. You can set the shake event listener in the `viewDidLoad` method or other methods with the following code:

```objectivec
[self ss_setShakeEventListener:^{
  // do some staff
  NSLog(@"Shake event detected!");
}];
```

If you want to remove the listener for the view controller:

```objectivec
[self ss_removeShakeEventListener];
```

### Application Event Listener

You can set application event listener on any object like this:

```objectivec
[obj ss_setApplicationEventListener:^(NSNotificationName notificationName, UIApplication *application) {
  // do some staff

  NSLog(@"Detected application event: %@", notificationName);

  // check notificationName to see what application event happened
  if ([notificationName isEqualToString:UIApplicationDidBecomeActiveNotification]) {
    NSLog(@"Application become active!");
  } else if ([notificationName isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
    NSLog(@"Application received memory warning!");
  }
}];
```

**Note**: In the listener block, you will need to check for the `notificationName` to see what application event happened. The `notificationName`s are same as UIApplication event notification names.

### View Gesture Event Listener

Add a single tap gesture listener to a view:

```objectivec
[view ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
  // do some staff

  NSLog(@"Single tapped!");
} numberOfTapsRequired:1];
```

Add a double tap gesture listener to a view is similar except the numberOfTapsRequired is 2:

```objectivec
[view ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
  // do some staff

  NSLog(@"Double tapped!");
} numberOfTapsRequired:2];
```

You don't need to worry if the single tap gesture listener would intercept the double tap gesture listener. It won't. That means you can set both single tap and double tap gesture listeners on the same view.

If you want to add a long press gesture listener to the view:

```objectivec
[view ss_addLongPressViewEventListener:^(UILongPressGestureRecognizer *recognizer) {
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    // do some staff
    NSLog(@"Long pressed!");
  }
} minimumPressDuration:2];  // 2 seconds
```

Since long press gesture is continuous, you need to check the gesture state. The `minimumPressDuration` parameter defines the minimum long press duration in seconds.

**Note**: Those methods return the associated gesture recognizer. If you want to remove any listener from the view. You should save the gesture recognizer and using `[UIView removeGestureRecognizer:]` to remove it. Don't worry about the listener, it's gone with the gesture recognizer.

 ### Button Tap Event Listener

You can set single tap gesture listener for a button with `ss_addTapViewEventListener:numberOfTapsRequired:` since UIButton is a subclass of UIView. But it's better to use button tap event listener since it remains the animation effects and other benefits which system offers.

To set a button tap event listener to a button, use:

```objectivec
[button ss_setTapButtonEventListener:^{
  // do some staff
  NSLog("Button tapped!");
}];
```

To remove the listener:

```objectivec
[button ss_removeTapButtonEventListener];
```

## Summary

`SSShakeEventListener` is written for those iOS developers who pursuit agile-development of their applications or frameworks. I appreciate it if the library would help you with writing Objective-C code. If you find any bug or you have any advice you'd like to propose, feel free to open issues on the Github repository. Pull requests are highly welcome!
