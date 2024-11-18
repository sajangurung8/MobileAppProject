# Car Care Log App
Sajan Gurung

Version 1

## Summary of Project
The Car Care Log app is a personal vehicle maintenance assistant designed to support DIY car owners. Recognizing that 70% of car owners prefer handling maintenance themselves, the app allows users to track their maintenance tasks, eliminating the hassle of searching for tutorials repeatedly. Key features include:
- Task Tracking: Users can log every maintenance step taken, creating a comprehensive history of their vehicle care.
- Reminders: Set reminders for upcoming maintenance tasks to stay proactive.
- Organization: The app helps users stay organized, ultimately enhancing their vehicle's lifespan.
- Confidence: By following their documented processes, users can drive with assurance, knowing they are adhering to their own proven maintenance methods.

Overall, the Car Care Log app streamlines vehicle maintenance, saving users time and money while promoting responsible car ownership.

## Project Analysis

### Value Proposition

Pain Points Addressed by the Car Care Log App
1.	Lack of Organization: Many DIY car owners struggle to keep track of their maintenance tasks and history, leading to disorganized records. This can result in missed maintenance and decreased vehicle lifespan. Supporting Fact: According to a survey by the American Automobile Association (AAA), 62% of car owners admit they forget to perform routine maintenance, which can lead to costly repairs.
2.	Difficulty in Finding Reliable Information even after completing the task once: Car owners often rely on YouTube and other online resources for maintenance tutorials, which can be overwhelming and inconsistent in quality. Supporting Fact: A study by the Pew Research Center found that 73% of adults have used YouTube for help with a DIY project, indicating a significant reliance on this platform. However, the variability in tutorial quality and availability can lead to confusion and mistakes.
3.	Time Management: Car maintenance can be time-consuming, especially when owners must search for information or remember past tasks. Supporting Fact: The AAA reports that many car owners spend an average of 15 hours per year on maintenance-related tasks, including searching for information.
4.	Increased Costs: Neglecting maintenance due to disorganization can lead to higher long-term costs in repairs and reduced vehicle efficiency.Supporting Fact: The Car Care Council states that regular maintenance can save car owners up to $1,200 annually by preventing major repairs.
5.	Confidence in Maintenance Tasks: Many DIYers lack confidence in their ability to perform maintenance correctly, which can deter them from attempting it.Supporting Fact: A survey by RepairPal found that 44% of drivers would prefer to pay for maintenance rather than attempt it themselves, primarily due to a lack of confidence in their skills.

### Primary Purpose

The primary purpose of the Car Care Log app is to empower DIY car owners to efficiently manage and track their vehicle maintenance. By allowing users to document detailed steps taken during maintenance tasks, the app helps them save time and effort when performing similar tasks in the future, ultimately enhancing their confidence and independence in vehicle care.

### Target Audience

The Car Care Log app is aimed at DIY car owners who seek to take charge of their vehicle maintenance. This group includes:
- Young Drivers: New car owners who may lack experience with vehicle maintenance.
- Budget-Conscious Owners: Individuals looking to save money by performing maintenance themselves rather than relying on professional services.
- Environmentally Conscious Consumers: Owners interested in extending the life of their vehicles to reduce waste and environmental impact.

By addressing these pain points, the Car Care Log app provides a valuable tool that enhances vehicle maintenance efficiency and confidence for its users.

### Success Criteria

To assess the success of the Car Care Log app, the following metrics will be utilized:
1.	Functionality of MVP: Ensure that the app includes all proposed functionalities outlined for the Minimum Viable Product (MVP). This will confirm that the core user needs are being met effectively.
2.	User Metrics: Track the number of downloads across both iOS and Android platforms. Monitor star ratings on application stores, aiming for an average rating of 4.5 stars or higher, which will reflect overall user satisfaction.
3.	Financial Metrics: Evaluate the financial performance by analyzing revenue generated from app sales.
4.	User Satisfaction: Conduct user satisfaction surveys to gather feedback on app usability, features, and overall experience. The goal is to achieve a satisfaction rate of 70% or higher, indicating that users find the app valuable and easy to use.
5.	Firebase Analytics Data: Utilize Firebase Analytics to monitor user behavior within the app, including which features are used most frequently, user engagement patterns, and app crash reports. This data will help identify popular features and areas needing improvement, informing future updates and enhancements.

### Competitor Analysis

#### Competitor Overview
Most mobile apps in the vehicle maintenance space primarily focus on recording completed tasks as proof of maintenance for potential buyers during vehicle sales. While these apps serve a purpose, they do not cater specifically to the needs of DIY car owners who perform their own maintenance.
Strengths of Competitors
1.	Comprehensive Record-Keeping: Many competitor apps effectively document completed maintenance tasks, providing a useful service for users who want to maintain a maintenance history for resale purposes.
2.	Manufacturer Support: Some car manufacturer apps offer reminders for upcoming maintenance tasks, which can be beneficial for users who prefer professional services.
3.	Established User Base: Competitors with a broader focus often have larger user bases and brand recognition, which can lead to greater trust and perceived reliability.
Weaknesses of Competitors
1.	Lack of Focus on DIY Users: Competitor apps are not designed with the DIY car owner in mind. They do not provide the detailed guidance and tracking needed for users who perform maintenance themselves, leaving a gap in the market.
2.	Limited Functionality: While some apps focus on task completion, they fail to offer features that support the DIY process, such as step-by-step documentation or personalized maintenance tracking, which are crucial for hands-on users.
3.	Generic Reminders: Manufacturer apps that remind users of upcoming maintenance tasks do not cater to the specifics of DIY maintenance, such as personalized logs or unique task lists, making them less useful for self-service car owners.

The Car Care Log app addresses a specific problem that has not been adequately solved by existing competitors. By focusing on the unique needs of DIY car owners, our app offers tailored features that facilitate detailed tracking and documentation of maintenance tasks, thus filling a significant gap in the market. This focused approach positions the Car Care Log app as a valuable resource for users looking to enhance their vehicle maintenance experience.


### Monetization Model

The monetization model for the app will initially be a one-time purchase fee for users. The MVP will focus on essential features, allowing users to record their maintenance steps in detail and set reminders. As the product matures and attracts a larger user base, we can introduce additional features, including in-app purchases for vehicle-specific guides, parts, tools, and premium content. This approach allows us to provide value upfront while creating opportunities for expanded revenue as user needs grow.

## Initial Design

### Minimum Viable Product (MVP) Definition
The MVP for the Car Care Log App focuses on delivering essential features that allow users to track vehicle maintenance effectively while keeping the app simple and user-friendly.
Scope
1.	User Management:
o	Single User Access: The app allows one user per installation to manage logs for up to five vehicles. Users are prompted to enter their name upon first use. No formal user registration process is required.
2.	Cross-Platform Compatibility:
o	The app will be available on both iOS and Android platforms, ensuring broad accessibility for users.
3.	Maintenance Log:
o	Users will manually enter maintenance data for each vehicle the first-time maintenance is performed. Each log entry will include details such as service type, date, tools used, mileage, and any relevant notes.
4.	Automatic Reminders:
o	The app will automatically set reminders based on the general lifespan of vehicle parts and the mileage reported by the user. Notifications will alert users when maintenance is due.
5.	Dashboard:
o	The dashboard will display a summary of maintenance activities, highlighting any incomplete records.
o	Users will receive reminders to update their logs if maintenance is overdue.
6.	Reporting Feature:
o	Users can create detailed reports for completed tasks, including all tools, parts used, and time taken to complete the maintenance. Reports will be stored locally within the app and can be shared using external mobile features (e.g., email, Bluetooth).

### Known Limitations
1.	Data Accuracy: Since maintenance records are user-entered, there is no mechanism to validate the accuracy of the logged steps or data.
2.	Report Sharing: There is no built-in functionality to share reports directly within the app. Users must rely on other mobile sharing options (e.g., email, Bluetooth) to distribute their reports.
3.	User Dependency: The app relies on users to provide accurate information regarding part lifespan and periodic mileage updates for their vehicles.
4.	Target Audience: The MVP is designed specifically for DIY car owners. Support for other vehicle types (e.g., motorcycles, boats, buses) will be considered for future updates.
5.	Data Storage: All data will be stored locally on the user’s device with no cloud backup available in the MVP version. This limits data accessibility if the app is uninstalled or if the device is lost.

This initial design outlines a focused approach to developing the Car Care Log App MVP, prioritizing essential functionality while acknowledging limitations that can be addressed in future iterations.

## UI/UX Design

### UI/UX Components:
- Dashboard: The dashboard provides an overview of all registered vehicles, displaying their general status (e.g. green for good, red for task in progress, amber for overdue task) for quick reference.
- Car Details: This section offers in-depth information about a selected car, including a history of completed tasks and an option to add new maintenance tasks.
- Report: Users can select specific tasks to view detailed reports, including summaries of costs and time spent, helping them manage their maintenance budget effectively and help them prepare for an upcoming task.
- Task: Each task includes detailed information such as required tools, replacement parts, associated costs, and the total time taken to complete the task.
- Step: This component breaks down each task into specific steps, detailing what is needed to complete the maintenance.
- Reminders: A list of upcoming reminders is organized by importance, based on time or mileage, ensuring users stay on top of their maintenance schedules.
- Navigation Bar: The navigation bar features three primary buttons—Dashboard, Report, and Reminders—allowing for seamless navigation between key app components.

### Initial UI/UX designs:

Dashboard view:
<img width="264" alt="image" src="https://github.com/user-attachments/assets/a7a97d84-242e-4d49-be38-431be9e0c9f7">

Car details view:
<img width="160" alt="image" src="https://github.com/user-attachments/assets/0a592cf8-37c5-423f-9682-14e4605a5bd7">

Task view:
<img width="170" alt="image" src="https://github.com/user-attachments/assets/f14cbede-936d-4089-a71d-cb383d3cbf45">

Step view:
<img width="200" alt="image" src="https://github.com/user-attachments/assets/b0d128d6-f46c-467f-8d76-56e6ced3202b">

### Technical Architecture

System architecture: Necessary components for MVP
<img width="258" alt="image" src="https://github.com/user-attachments/assets/032248a0-2794-4bda-9d30-d89e9b1ec1cc">

Necessary components to support MVP:
1.	Car Care Log App: Core application that encompasses the proposed UI/UX components, facilitating user interaction for vehicle maintenance tracking.
2.	Firebase Cloud Instance: A third-party service used to record event logs from the app. Firebase will be leveraged for analytics and potential future cloud storage needs.
3.	Device Calendar: Utilizes the on-device calendar application to set reminders for maintenance tasks, ensuring reminders are accessible even outside the app.
4.	Datastore: On-device database to store application data. Consideration between using SQLite and Hive for efficient data management.

Data storage considerations:
1.	SQLite vs. Hive:

SQLite: A relational database management system suitable for structured data. Ideal for complex queries but may require more boilerplate code.
Hive: A lightweight, NoSQL database that offers simple key-value storage, suitable for Flutter applications. Provides easier integration and faster read/write operations.

2.	Data Tracking: Store application state (e.g., user sessions) separately from user-saved data (e.g., maintenance logs) to enhance performance and data management.

Data structures:
1.	Vehicle
•	Attributes: id, make, year, model, color, maintenanceStatus (green for complete, red for ongoing maintenance), mileage.
2.	Task
•	Attributes: id, taskStatus (green for complete, amber for in progress), toolsNeeded (list of tools), steps (list of steps).
3.	Step
•	Attributes: id, stepStatus (green for complete, amber for in progress), tools (list of tools for the step), description, timeTaken (time taken to complete the task).
4.	Reminder
•	Attributes: id, targetDate, targetMileage.
5.	Report
•	Attributes: taskId, generatedDateTime.

Web/Cloud Interactions
- Firebase Analytics: Integrated to log events from user devices, helping to collect and analyze success metrics (e.g., user engagement, retention, task completion rates).

Dependencies on Third-Party Services/APIs
-	Firebase Analytics Library: For logging events and collecting success metrics from user interactions.
-	Storage Library: A Flutter-specific library (either for SQLite or Hive) for efficient local data management.
-	Notification Library: To schedule daily or weekly mileage update notifications, ensuring users are reminded of their vehicle maintenance tasks.
-	Device Calendar Library: For integrating with the device’s calendar to set reminders for maintenance tasks.

## Challenges and Open Questions

### Challenges
1.	Background Reminders
Challenge: Ensuring that reminders continue to work even if the app is not used for an extended period.
Solution: Use the device_calendar package to create calendar events that serve as reminders. This way, reminders are managed by the phone's native calendar app, which operates independently of your app's state.
2.	Tracking Multiple Components in a Task
Challenge: Managing tasks that involve multiple components and determining how many steps to allow in a task.
Solution: Allow users to break tasks into sub-tasks or components. Set a reasonable limit (e.g., 10 steps) based on user feedback and usability testing. Gather data on typical user behavior to identify common patterns and adjust the maximum step count accordingly.
3.	Storage Size for Maintenance Data
Challenge: Determining the maximum size of maintenance data stored on the device.
Solution: Conduct performance testing to assess the impact of data size on app responsiveness. Implement data pruning strategies to remove old logs after a certain period or when the storage limit is reached, ensuring that only the most relevant data is retained.
4.	Report Storage Location
Challenge: Deciding where to store reports on iOS and Android devices.
Solution: Store reports locally within the app’s internal storage for both platforms. For Android, use the app’s private storage, and for iOS, use the app’s document directory. Provide an option for users to export reports to their preferred file formats (e.g., PDF, CSV) for external access.
5.	Reminder Functionality When App is Not Running
  Challenge: Ensuring reminders(for e.g.: daily milage update notification) function properly when the app is not active.
  Solution: Use local notifications from the flutter_local_notifications package to schedule daily reminders, which can be set even if the app is not running. Ensure users grant the necessary permissions for notifications during the app onboarding process.

### Open Questions
1.	Task Step Limitations:
How many steps can realistically be recorded in a task without impacting performance? Are there hardware limitations that affect this?
2.	Notification Behavior:
How do we ensure that notifications work reliably when the app is not running? What are the best practices for managing this? Is using proposed packages and methods enough? What if reminder gets deleted on Calander?
3.	Data Write Frequency:
How often should the app write data directly to disk? What are the implications if the app crashes during a write operation?
4.	Using Firebase Analytics:
What specific events and metrics should we collect to measure user engagement and app performance? How can we effectively integrate Firebase Analytics into the app? Is authentication required for Firebase Analytics, and how should it be handled to ensure user data privacy?
5.	User Permissions:
What are the best strategies to effectively request user permissions for notifications and calendar access, ensuring users feel comfortable granting these permissions?
Addressing these challenges and questions will help in refining the app's functionality and enhancing user experience. Gathering feedback from peers and users can provide additional insights to navigate these issues effectively.

## References:
American Automobile Association (AAA). (2021). "AAA Survey Reveals Most Drivers Forget Routine Vehicle Maintenance." Retrieved from AAA Website.

Pew Research Center. (2021). "YouTube's Role in DIY Learning: A Study of Online Learning Trends." Retrieved from Pew Research Center.

American Automobile Association (AAA). (2021). "The Cost of Vehicle Maintenance: A Report on Time and Expenses." Retrieved from AAA Website.

Car Care Council. (2021). "The Importance of Regular Vehicle Maintenance." Retrieved from Car Care CouncilWebsite.

RepairPal. (2020). "Consumer Perceptions of Vehicle Maintenance: A Survey of Car Owners." Retrieved from RepairPal Website.



# Initial Mockup

<img width="958" alt="Screenshot 2024-10-15 at 6 10 28 PM" src="https://github.com/user-attachments/assets/04d74532-79bc-4a06-8fb5-6bf63a0b2173">

### Happy Path for Car Care Log App:
1.	Open the App: User opens the Car Care Log app on their mobile device (Android or iOS).
2.	View Dashboard: The dashboard displays an overview of all registered vehicles. User can see a list of cars, with a green, amber, or red status indicating the overall maintenance status (green: no pending tasks, amber: tasks in progress, red: overdue tasks).
3.	Select a Vehicle: User taps on a specific vehicle they want to manage, taking them to the Car Details view.
4.	View Maintenance Tasks: On the Car Details page, user sees a list of completed and pending tasks. User selects a task (e.g., "Change Oil") from the list of pending tasks.
5.	View Task Steps: User is taken to the Task View where they can see task details (e.g., tools needed, parts required). The task is broken down into multiple steps (e.g., "Drain oil", "Remove filter", etc.), and the user views all the steps listed under the task.
6.	Complete Steps: User begins performing the maintenance task step by step. After completing each step, user taps on the step, marks it as complete and next step.
7.	Mark Task as Complete: Once all steps are marked as complete, the "Mark Task as Complete" button becomes active. User taps on the "Mark Task as Complete" button. The app records the completion date, mileage, and any notes the user adds about the task.
8.	Set Automatic Reminders: The app prompts the user to set a reminder for the next instance of the maintenance task based on mileage or time (e.g., "Set reminder for next oil change in 5,000 miles or 6 months"). User accepts or customizes the reminder.
9.	Review Task in Report: After marking the task as complete, user returns to the Car Details view, where the task status changes to green. User can go to the Report section to see a summary of the task, including tools used, steps completed, and any notes added.
10.	Return to Dashboard: User returns to the Dashboard view, where the vehicle's status has now changed to green, indicating no pending maintenance tasks.
 
### Key Points of the Happy Path:
- Smooth onboarding: The user quickly selects their vehicle and logs maintenance tasks with minimal steps.
- Task tracking: The app helps the user keep a clear record of their vehicle maintenance Step by step.
- Proactive maintenance: Reminders keep the user ahead of vehicle issues by prompting future tasks based on mileage or time.
- Confidence: The user gains confidence through organized tracking and completed tasks.

### Success Criteria for initial mock up:
- Ease of use: Users can log tasks and set reminders intuitively.
- Task Completion Rate: 80% of users should regularly complete their maintenance tasks and updates.
- User Retention: At least 70% of users should continue using the app 3 months after downloading due to its simplicity and functionality. User leaves a 5-star review on app store.

# Logging/Telemetry

## Industry Trend and Need
With the increasing complexity of mobile applications and the absence of direct access to user devices, developers face unique challenges in monitoring app performance and identifying issues. To address this, the industry has shifted toward a model of collecting logs directly from the device and transmitting this data to cloud-based services such as Firebase Analytics. This trend allows developers to access real-time insights into app behavior without needing direct interaction with the device.

A case study on 107 projects that integrate Firebase Analytics revealed that mobile apps gather data across four primary categories(Logging Practices with Mobile Analytics: An Empirical Study on Firebase | IEEE Conference Publication | IEEE Xplore, n.d.). The largest portion, domain/business events (51.3%), includes transactions or other actions related to app features, such as repeat purchases or media downloads. These logs help businesses understand how users engage with the app's core functions and are invaluable for improving product features and user satisfaction. User interface events(38.7%) capture interactions with the app's user interface, such as button clicks or screen transitions, offering insights into how users navigate the app, which features they interact with most, and potential usability issues. Failures and unexpected situations (6.3%) cover errors that occur during the app's operation, like network failures or issues with file access, which help developers identify and resolve bugs quickly. A small percentage (2%) of logs fall under other categories, including app version, device region, or device-specific details that provide additional context to user activity.

What sets mobile app logging apart from traditional software logging is the intended use of the collected data. In mobile applications, logs are not just for debugging issues during development; they are primarily used to understand user behavior and feature usage. Developers and businesses use this information to optimize user experience, customize app features, and track overall performance. This shift to collecting behavioral data represents a key trend in mobile app development, where user engagement and experience are prioritized over simple error reporting. By leveraging these logs, businesses can make data-driven decisions to refine their apps, ensuring they meet user needs while maintaining reliability and performance.
## Current Solutions: Logging During Development and Production
Logging is a vital tool in both the development and production stages of mobile app development. Operating systems (OS) provide built-in logging mechanisms to help developers track events, diagnose issues, and troubleshoot applications. These OS-specific solutions, such as Logcat for Android and Unified Logs for iOS, are designed to operate at the device level, with logs typically remaining local to the device unless explicitly transmitted elsewhere. They are especially useful for debugging on individual devices during the development phase.

In contrast, cloud-based logging services like Firebase Analytics, AWS CloudWatch, and Google Cloud Logging offer more scalable solutions by storing logs remotely. These services provide APIs that enable mobile applications to send logs to cloud environments, where they can be aggregated, analyzed, and visualized for more effective monitoring and troubleshooting across multiple devices. However, one significant challenge with cloud logging services is handling sensitive data. While cloud platforms allow developers to define what information is logged, they do not offer built-in mechanisms to automatically detect or prevent the logging of sensitive data—such as personal user information, passwords, or financial details. Developers are responsible for ensuring that sensitive data is excluded from logs, and most platforms provide guidelines to assist in avoiding common pitfalls but not an automated mechanism to detect and filter sensitive data(Zhou et al., 2020). A study of 200 mobile applications found that poor logging practices often resulted in data leaks, including sensitive information such as user accounts, network details, and location data(Zhou et al., 2020).

While OS-provided logging solutions like Logcat and Unified Logs are excellent for debugging specific devices, cloud-based logging services offer broader capabilities for real-time monitoring and cross-device analysis. Both types of logging solutions have distinct advantages, but developers must remain vigilant when logging sensitive data—particularly in cloud environments—to mitigate security risks.

## Critical Analysis: Pros and Cons of Current Logging Solutions

### OS-Provided Logging
Pros:
-	Ease of Use in Development: OS-level logging tools like Logcat for Android and Unified Logs for iOS are invaluable during the development phase. They allow developers to easily log events and errors directly from the app without needing extensive configuration. Developers can debug specific devices, test features, and refine functionality efficiently.
-	No Extra Resources Needed: These logging solutions do not require additional services, such as daemon services or background processes, to collect logs. This simplicity ensures minimal impact on device resources, maintaining app performance during development.
-	No Setup Complexity: OS-provided logging requires little to no setup. Developers can start logging right away without the need for API configurations or infrastructure, making it very convenient for small-scale debugging.

Cons:
-	Logs Stored in Plain Text: A significant downside is that logs are typically stored in plain text, making them vulnerable to security risks if not handled properly. Sensitive information could be exposed, especially in cases where debugging logs accidentally contain personal user data or passwords.
-	Limited to Device-Level Data: OS-provided logs are typically device-specific, which limits their usefulness in production environments. Since these logs are collected on individual devices, they do not provide a centralized view of application performance or user behavior across multiple devices or users. This is a significant limitation for large-scale production monitoring.
-	Limited Analytics Capabilities: The analytical tools available with OS-level logging are generally basic. While they are sufficient for debugging during development, they lack the advanced capabilities found in cloud-based solutions, such as real-time data analysis, user behavior tracking, and cross-device reporting.
-	Text-Based with Limited Structure: OS logs tend to be text-based with minimal structure, making it harder to process and analyze large volumes of data. Structured logging, which allows for more precise querying and data analysis, is typically not a feature of these logs.

### Cloud-Based Logging Services
Pros:
-	Simplified Setup for Developers: Cloud services like Firebase Analytics, AWS CloudWatch, and Google Cloud Logging provide easy-to-follow documentation and APIs, enabling developers to quickly integrate logging into their applications without worrying about the technical complexities of implementing custom logging logic. This allows developers to focus more on business logic and app functionality.
-	Automatic Data Collection: Cloud services automatically collect a set of default events and data, with the option to define custom events. This automated approach reduces the workload for developers, especially in terms of tracking user interactions and app performance metrics.
-	Data Management in Cloud: Since cloud services store logs off-device, there are no concerns about running out of storage space on the mobile device. The data is retained in the cloud, which reduces the strain on local device storage and performance, addressing physical limitations of data collection.

Cons:
-	Potential Performance Overhead: Cloud-based logging can introduce overhead into the application. Collecting and transmitting logs to a remote server adds network and processing overhead, potentially slowing down the application. Furthermore, background daemon services that run to manage log collection can also consume device resources, degrading the overall app performance.
-	Lack of Built-In Sensitive Data Detection: Most cloud services do not automatically detect or prevent the logging of sensitive information (such as Personally Identifiable Information, or PII). This places the onus on developers to ensure that no sensitive data is inadvertently logged, which can lead to potential data leakage or privacy violations if not handled properly.
-	Security Risks with Third-Party Tools: Using third-party logging services may open security vulnerabilities or backdoors. Since cloud logging services are external to the app, there is a risk that the service could be compromised, exposing user data or other sensitive information.
-	Cost and Scalability Issues: While cloud services are convenient, they can become expensive as the app scales. As the user base grows, the volume of logged data increases, potentially leading to higher costs. Additionally, the infrastructure of third-party services may not always scale to meet the growing demands of large applications, potentially limiting performance or causing bottlenecks.

## Proposed Solution: Integrating Machine Learning for Sensitive Data Detection in Logging
While current logging solutions offer valuable capabilities for app development and production monitoring, they have inherent limitations, particularly in terms of handling sensitive user data. To address these limitations, an improved solution could integrate lightweight machine learning models at the device level to identify and mask sensitive data in logs as they are generated.

### Device-Level Machine Learning for Sensitive Data Filtering
Recent advancements in mobile hardware, such as Apple’s Neural Engine and Google’s Tensor Processing Unit (TPU), have made it possible to run machine learning models directly on mobile devices. These dedicated hardware accelerators are designed to efficiently process machine learning tasks, even on devices with limited computing resources. By leveraging these specialized hardware units, lightweight machine learning models can be used to analyze logs as they are generated, detecting sensitive information in real-time.
The machine learning models could be trained to recognize patterns associated with sensitive data, such as personally identifiable information (PII), financial details, or authentication tokens. Once identified, the sensitive data could be masked or filtered out before it is logged, ensuring that only non-sensitive data is transmitted or stored. This approach minimizes the risks associated with logging sensitive data, especially in development and production environments where inadvertent exposure could have severe privacy implications.

### Cloud-Based Solution for Older Devices
For older devices with limited capabilities that may not support running complex machine learning models locally, the same sensitive data detection and masking process can be handled in the cloud. However, to protect data during transmission, encryption should be implemented. This ensures that data leaving the device is encrypted, preventing interception or unauthorized access during transfer. Once in the cloud, the data can be further processed, and any remaining sensitive information can be identified and masked.
This hybrid approach — running machine learning models on-device for newer hardware and offloading to the cloud for older devices — ensures that all devices can benefit from sensitive data detection and protection. Additionally, using encryption for cloud-based processing further strengthens data security, ensuring that sensitive information remains protected throughout the process.

## References

Logging Practices with Mobile Analytics: An Empirical Study on Firebase | IEEE Conference Publication | IEEE Xplore. (n.d.). Retrieved November 16, 2024, from https://ieeexplore-ieee-org.offcampus.lib.washington.edu/document/9460930


Zhou, R., Hamdaqa, M., Cai, H., & Hamou-Lhadj, A. (2020). MobiLogLeak: A Preliminary Study on Data Leakage Caused by Poor Logging Practices. 2020 IEEE 27th International Conference on Software Analysis, Evolution and Reengineering (SANER), 577–581. https://doi.org/10.1109/SANER48275.2020.9054831


