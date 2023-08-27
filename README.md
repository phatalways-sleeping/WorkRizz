# task_managing_application

A new Flutter project.

## Project Folder Structure

### Assets

- `fonts` - Contains all the fonts used in the project
- `icons` - Contains all the icons used in the project
- `images` - Contains all the images used in the project

### lib

- 'apis': Contains all the apis used in the project
  - 'authentication' - Contains all the apis related to authentication
  - 'storage' - Contains all the apis related to storage
  - Note: The apis.dart file in the apis folder is used to import all the apis in the project

- 'repositories': Contains all the repositories used in the project
  - 'authentication' - Contains all the repositories related to authentication
  - 'storage' - Contains all the repositories related to storage
  - Note: The repositories.dart file in the repositories folder is used to import all the repositories in the project

- 'assets': Contains all the assets used in the project including customised text themes, color themes...
  - Note: The assets.dart file in the assets folder is used to import all the assets in the project

- 'states': Contains all the folders related to state management, such as blocs, cubits...
  - Note: The states.dart file in the states folder is used to import all the states in the project

- 'screens': Contains all the screens for the application, such as: login_screen.dart, home_screen.dart, profile_screen.dart... (Please suffix the screen name with `_screen` and name the class with `PascalCase` naming convention)
  - Note: There is a base folder in the screens folder, which contains the base screen for the application. All the screens in the application will use this base screen as the parent screen.
  - Note: The screens.dart file in the screens folder is used to import all the screens in the project

- 'widgets'
  - A screen can contain multiple widgets, so please create a folder with the same name as the screen and put all the widgets related to that screen in that folder. Remember to suffix the widget name with `_widget`.
  - If a widget is used in multiple screens, please put it in the `widgets` folder.
  - Name the class with `PascalCase` naming convention.
  - Note: The widgets.dart file in the widgets folder is used to import all the widgets in the project

- 'models': Contains all folders of classé for storing data, such as: user, task, project... (Please suffix the model name with `_model` and name the class with `PascalCase` naming convention)
  - In the future, we will put the json serialization file in each model folder.
  - Note: Some models such as user_model will conflict with the user_model in the existing firebase_auth package, so please name the model with a different name, such as: user_info_model, user_data_model...
  - Note: The models.dart file in the models folder is used to import all the models in the project
