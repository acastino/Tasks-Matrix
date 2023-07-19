# Tasks Matrix

This is another Reminder/ToDo app with two important additions: the Urgent/Important matrix, and a bulit-in Kanban flow. It also has custom TextField views, and custom Swipe gesture controls, all done to offer a new experience to iOS than the default SwiftUI behavior.

![](/assets//images/summary.png)

## Technologies & Features
- Swift & SwiftUI
- Core Data & extensions, to automate initializing, saving, updating and filtering of NSManagedObject
- Has special computed properties, for translating Core Data's generated classes which tend to have Optional fields, to concrete ones
- Added a special callback to help update SwiftUI views when Core Data fields are updated, which Core Data doesn't seem to report back the change at times
- Created a custom View for use as a row in a List{}, which manages tap actions slightly differently, as well as, managing swipe gestures, integrated well with the system's own scrolling and other gesture controls
- Added a Protocol for ensuring that only one row in the list is partially swiped (pausing to show an icon), and gets cancelled automatically when scrolling starts, or when the user taps or swipes another row, etc
- Support for swiping a row to one side partially, and then swiping straight to the other side if icon exists
- Continues the animation when icon is tapped or when full swipe is triggered, unlike the default behavior
- Allows a normal View to be the content behind the row swipe gestures, unlike the default behavior
- Dynamic View content is behind the row, depending on Kanban location
- Created a custom TextField and a custom TextEditor
- Placeholder is animated above the field & back
- Same Sheet for Add/Edit functionalities
- Custom Picker managing Core Data
- Soft-delete feature
- ScreenSize helper
- etc.

## Screencasts

| **Quick Tour of the App** | |
| :--- | --- |
| <img src="/assets/images/tour.gif" width="300px"> | Shows the main features of the app. |

| **Editing and Custom Gesture Controls** | |
| :--- | --- |
| Shows the slightly different tap behavior when the row is partially swiped, as well as, the custom-made behavior that ensures only one row is partially swiped, and the integration with the system's scrolling behavior, etc. | <img src="/assets/images/edit_swipe.gif" width="300px"> |

| **Moving an Item across the Matrix** | |
| :--- | --- |
| <img src="/assets/images/across_matrix.gif" width="300px"> | This is an easy thing to do, but an item about creating a unicorn company should really be there. 🦄 |
| continuation... 🎉 | <img src="/assets/images/across_continuation.gif" width="300px"> |

<sub>All Rights Reserved ©️ 2023</sub>
