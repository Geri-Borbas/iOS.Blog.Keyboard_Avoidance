# CHANGELOG

* Doing

    + Blog
        + Screencap from `WrappedScrollViewController` 
        + Hero video
        + Hero Twitter image
        + Excerpt

* 0.0.40

    + `UIView.safeAreaInsetsDidChange()` swizzling
        + Added `NSObject+Swizzle`
        + Added `UIView+OnSafeAreaInsetsDidChange`
        + Readjust `KeyboardLayoutGuide` when safe area insets changed

* 0.0.38

    + Added `UI.spacing`, `UI.padding`, and `UI.itemHeight`
    + Updated `HeaderView.withFixedHeight`

* 0.0.35

    + Added `SwiftUIView`

* 0.0.30 - 0.0.31

    + Added `UIApplication.firstWindow`
    + Added `HeaderView.fixedHeight`
    + Extracted extensions
    + Grouping

* 0.0.25

    + Added `WrappedScrollViewController` (added to `ViewController` as well)

* 0.0.23
    
    + Added `UIButton.withSignUpButtonStyle`
    + Added `KeyboardLayoutGuideViewController`
    + Updated `KeyboardNotificationsViewController`
    + Updated `ScrollToResponderViewController`

* 0.0.21

    + Added `UIView+Speed`

* 0.0.20

    + Added `Withable` Swift package (removed local sources)

* 0.0.10 - 0.0.12

    + Updated `ScrollToResponderViewController`
    + Extracted `UITextField` styles to `UI`
    + Added `UIButton` styles
    + Added color styles

* 0.0.8 - 0.0.9

    + Added `ScrollToResponderViewController`
    + Added Declarative UIKit extensions
    + Added composable `TextFieldDelegate`

* 0.0.5 - 0.0.6

    + Added `KeyboardNotificationsViewController`

* 0.0.4

    + Initial layout when `window` becomes key (safe area guides are set by that time)  

* 0.0.3

    + Added `OrientationListenerViewController`
    + Layout guide on every view transition as well (unless keyboard is present)
    + Use `layoutMarginsGuide` as bottom constraint

* 0.0.0 - 0.0.2

    + Prototype

