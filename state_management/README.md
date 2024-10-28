# App Lifecycle States in Flutter

Flutter apps can enter several key states during their lifecycle on both Android and iOS platforms. Understanding and managing these states is crucial for creating a responsive, user-friendly application. The primary states include:

1. **Inactive**: The app is not yet receiving user input. This state occurs when the app is temporarily inactive, such as when the user receives a call.
2. **Paused**: The app is still visible but no longer responsive to user input because it's in the background. The system may suspend the app in this state, which is important for conserving resources.
3. **Resumed**: The app is in the foreground and fully interactive. This is the primary state where the app handles user input and displays content.
4. **Detached**: This is specific to Android, where the app is still running in the background but is detached from the view hierarchy.
5. **Suspended**: This state generally applies to platforms where the app is kept in memory but does not execute code. Apps in this state may be terminated if the system requires resources.

---

# States to Consider for the Car Care Log App

For the Car Care Log app, it’s essential to manage app states to ensure data consistency, smooth user experience, and efficient resource usage.

### 1. Resumed State (Active)
- **Consideration**: This is the primary state where users interact with the app, view car details, log maintenance records, and add or edit information.
- **Actions**:
  - Ensure all necessary data (e.g., car list, maintenance logs) is loaded and displayed correctly.
  - Fetch any updates from the database or API if the data might have changed since the app last loaded.
  - Resume any processes paused in the background, like checking for scheduled maintenance reminders.
  - Maintain a responsive UI to allow users to quickly navigate through the app.

### 2. Paused State (Background)
- **Consideration**: When users switch to another app, the Car Care Log app will pause but remain in memory. Since the user may come back shortly, it’s essential to preserve their current activity.
- **Actions**:
  - Save transient data to local storage or cache (e.g., any partially filled car information or maintenance log entries).
  - Pause background processes like database writes or syncing to avoid consuming resources.
  - Ensure any edits in progress are saved so the user can pick up exactly where they left off.
  - Prepare to refresh the UI when resuming in case of data changes.

### 3. Inactive State (Interruption)
- **Consideration**: The app becomes inactive briefly during interruptions like incoming calls. While this state is usually short-lived, it’s essential to avoid losing data and ensure no operations are interrupted improperly.
- **Actions**:
  - Temporarily pause any non-essential operations, like syncing with a server or showing pop-up notifications.
  - Avoid making changes to essential data that could get interrupted mid-update, which may lead to incomplete records.
  - Save any immediate state information, such as which page or form the user is viewing, for an easy return when the app resumes.

### 4. Suspended State (Memory Purge)
- **Consideration**: The app may be removed from memory if the system needs resources for other applications. Since the app may get terminated, it’s essential to save all critical data and the user’s session.
- **Actions**:
  - Persist critical data, such as any user-entered information or current page state, to local storage (e.g., SQLite or shared preferences).
  - For items like unsaved entries or edits, consider auto-saving these details to avoid data loss.
  - On resuming, check if any unsaved information exists and prompt the user to confirm or discard changes.
  - Restore the last known state (like the current car log entry or list view) so the user can pick up right where they left off.

### 5. Detached State (App Termination)
- **Consideration**: This state is generally specific to Android when the app is detached from the view hierarchy. It’s an opportunity to clean up resources the app may not need if it’s no longer visible.
- **Actions**:
  - Release unnecessary resources (e.g., connections to databases or streams) to free up memory.
  - If any tasks like background syncing or updating data are in progress, stop or defer them as appropriate.
  - Prepare the app for potential termination by ensuring essential data has been stored to avoid needing a reload.

---

By handling these states effectively in the Car Care Log app, we ensure the app remains responsive, data is preserved accurately, and users can seamlessly return to their activities even after interruptions. This approach supports both a smooth user experience and optimal performance.


## Screenshot of State Management

### App screen when it launches
This screen shows the app upon launch, with the default background color.  
<img src="https://github.com/user-attachments/assets/49253f0a-3e8d-4ab9-b964-be1aae532f94" alt="App Launch" width="200" />

### App screen when user clicks on the purple button
Upon selecting the purple button, the background color updates to purple, as shown below.  
<img src="https://github.com/user-attachments/assets/2c7f847a-c498-4466-8214-b41b167fef8f" alt="Purple Background" width="200" />

### App screen after user returns to the app after using other apps
After switching back to the app, the background color remains purple, demonstrating the app’s suspend/resume state preservation.  
<img src="https://github.com/user-attachments/assets/b5e0a886-fb51-46ab-9caa-b53f8e4708b1" alt="Resumed to Purple Background" width="200" />
