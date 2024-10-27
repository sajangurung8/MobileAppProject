# Car Care Log App

Sajan Gurung

A Flutter project for an app for tracking vehicle maintenance. This project is implemented using informaion in README.md file on the root folder.

This project is currently in its prototype phase, with screens that have minimal, functional buttons to demonstrate navigation and interaction between pages. Both the Reminder and Report screens use placeholder values that will be updated in future versions. The app utilizes an SQLite database to store car information and follows the Model-View-ViewModel (MVVM) pattern to ensure clear separation of component responsibilities. In this prototype, users can add a car, create tasks, and add steps to each task to illustrate the expected functionality.

## Key Features for Minimum Viable Product (MVP)

1. **Task and Step Updates**
   - Users should be able to update tasks and individual steps.
     - Implement task update screen.
     - Add logic to update task steps on the task info screen.

2. **Enhanced Reminder Functionality**
   - The Reminder screen should include reminders for completed tasks.
     - Prompt users to set the next due date for tasks.
     - Sort reminders by upcoming due date on the Reminder screen.

3. **Mileage Update Prompts**
   - Users should be prompted to update car mileage.
     - Add a mileage update screen.
     - Implement logic to notify users if mileage hasn’t been updated for over a week.

4. **Comprehensive Task Reports**
   - The Report screen should display all tasks, with detailed reports accessible per task. Each report includes task descriptions, time taken, required tools and parts, and recommended maintenance frequency.
     - Update the Report screen to show a list of all tasks.
     - Create a screen to display detailed task reports.

5. **Car Status Indicators**
   - Each car should display a status indicator based on the completion of tasks and steps.
     - Add logic to update the car status color to reflect task statuses.

6. **Firebase Analytics for Telemetry**
   - Integrate telemetry using Firebase Analytics to collect data on app usage and user behavior.
     - Set up a Firebase Analytics instance.
     - Develop a service to log data and send it to Firebase Analytics.

---

## Feature-Value Mapping

1. **Improved Maintenance Tracking**
   - The Reminder screen will support push notifications for upcoming maintenance, ensuring users are timely informed.

2. **Mileage-Based Notifications**
   - Mileage updates will trigger reminders to help users maintain accurate maintenance schedules.

3. **Task Preparation Reports**
   - Task reports on the Report screen allow users to prepare effectively for upcoming maintenance.

4. **Visual Maintenance Indicators**
   - The home screen will show the maintenance status of each car, helping users quickly identify due tasks.

5. **Enhanced Insights via Telemetry**
   - Firebase Analytics will provide valuable insights into user interactions and app behavior, supporting continuous improvement.

---

## Prototype Screenshots

### Home Screen with no cars
<img src="https://github.com/user-attachments/assets/ca6e4a9f-20a8-47e2-b61b-9ef33c64f171" width="240" height="500"/>

### Home Screen with car
<img src="https://github.com/user-attachments/assets/b8260b8b-7c2f-4c54-ae30-fd951aafadf7" width="240" height="500"/>

### Add New Car Screen
<img src="https://github.com/user-attachments/assets/e7effdf0-f5a1-448e-9c9b-05dcdd99ef5e" width="240" height="500"/>

### Car info Screen
<img src="https://github.com/user-attachments/assets/9865b2ab-3005-47c8-9b81-0f31defae988" width="240" height="500"/>

### Add Task Screen
<img src="https://github.com/user-attachments/assets/f7e1ac5f-6ca9-4610-9e75-390e4df55955" width="240" height="500"/>

### Task info Screen
<img src="https://github.com/user-attachments/assets/33609605-c18b-4851-89b3-5ef7c7411ab8" width="240" height="500"/>
