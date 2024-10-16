## Various Basic Storage Management in Flutter: Approaches, Pros, and Cons
1. Shared Preferences

Overview:
Shared Preferences is a lightweight key-value store for simple data such as user settings. It is ideal for storing small amounts of primitive data like strings, integers, or booleans.

Pros:

- Simple and Easy to Use: Shared Preferences offers a straightforward API to store and retrieve basic data types.
- No External Dependencies: Works out-of-the-box without requiring extensive configuration.
- Persistent Storage: Data is retained even when the app is closed or restarted.

Cons:

- Limited Storage: It is not suitable for storing complex or large data, like media files.
- Data Format Restrictions: Only supports primitive data types (String, int, bool, etc.), which makes it unsuitable for complex structures like lists or objects.

2. SQLite

Overview:
SQLite is a powerful relational database management system supported by Flutter. It’s used for managing complex structured data, supporting SQL queries.

Pros:

- Efficient for Complex Data: It allows for advanced queries and supports multiple tables, making it suitable for complex structured data.
- Persistent Storage: Data is retained between app sessions.
- Transactional Support: Ensures that your data operations can be rolled back in case of failures.

Cons:

- Setup and Complexity: Requires more setup compared to Shared Preferences, and managing SQL databases can be more challenging.
- Overkill for Simple Data: It might be excessive for small or simple data like user settings.

3. File Storage

Overview:
File storage allows you to save raw data, such as images, videos, or large text files, directly on the device's file system.

Pros:

- Suitable for Large Data: Perfect for storing large files like media (images, audio, video).
- Custom Data Structure: You have full control over the format of the data stored (e.g., JSON, binary, etc.).

Cons:

- No Built-in Search or Query Capabilities: File storage doesn’t support advanced queries or searches, unlike SQLite.
- Data Security: Managing encryption for sensitive data can be complex since files are stored in the device’s file system.

4. Hive

Overview:
Hive is a lightweight, NoSQL database designed for Flutter applications. It is fast and suitable for both small and large data.

Pros:

- Fast and Efficient: Hive offers better performance for reading and writing data compared to SQLite.
- NoSQL Support: Flexible schema-less data storage which is great for storing complex or nested data structures.
- Simple Setup: Easier to set up compared to SQLite, and no need for boilerplate code.

Cons:

- Limited Querying Features: Lacks advanced querying capabilities, making it less suitable for highly relational data.
- Suitability for Simple Use Cases: May not be necessary if only storing basic key-value pairs (where Shared Preferences would suffice).

## App screenshot

This project contains a basic flutter app that lets you to load an image from the phone galary and store in the app and also store dark mode user setting.

When you first launch the app, no image is loaded, and the default setting is light mode. You can easily switch to dark mode by toggling the switch at the top, and the app will save your preference automatically. By clicking the button, you can choose an image from your gallery, which will then be stored locally within the app. On future visits, both your dark mode preference and the stored image will automatically load, ensuring a seamless experience tailored to your settings.

Image of the app on first time load:

![Simulator Screenshot - iPhone 16 Pro Max - 2024-10-16 at 15 22 50](https://github.com/user-attachments/assets/afb94e1b-f829-4284-883a-29fb3b8f4035)

Here’s how the app looks after an image has been loaded and dark mode has been enabled. To confirm, the app was closed and reopened, and both the image and dark mode settings were successfully retained, verifying that the preferences and stored image persist seamlessly across sessions:

![Simulator Screenshot - iPhone 16 Pro Max - 2024-10-16 at 15 23 21](https://github.com/user-attachments/assets/5fd65d04-29da-465a-b779-9225a2e84186)

