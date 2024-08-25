import os

root_dir = "/home/mohammed/agri-ai/code/agriapp/lib/app/modules/"
prompt_dir = "prompt1/"

# Ensure the prompt directory exists
os.makedirs(prompt_dir, exist_ok=True)

# Walk through the directory structure
for subdir, dirs, files in os.walk(root_dir):
    # Process directories named 'views' and their subdirectories
    if os.path.basename(subdir) == 'views':
        # Walk through the subdirectories and files within 'views'
        for root, _, files in os.walk(subdir):
            for file_name in files:
                if file_name.endswith('.dart'):
                    dart_file_path = os.path.join(root, file_name)
                    
                    with open(dart_file_path, 'r') as file:
                        # Filter out lines that start with 'import'
                        view_content = ''.join(line for line in file if not line.strip().startswith('import'))


                # Prepare the content for the Markdown file
                frist = """
strings_enum.dart:
```dart

    static const String hello = 'hello';
    static const String loading = 'loading';

    static const String noInternetConnection = 'no internet connection';
    static const String serverNotResponding = 'server not responding';

```
en_us_translation.dart:
```dart

    Strings.hello : 'Hello!',
    Strings.loading : 'Loading',

    Strings.noInternetConnection : 'No internet connection!',
    Strings.serverNotResponding : 'Server is not responding!',

```
and use like Text(Strings.hello.tr)

now add translate for this code

```dart
"""

                answer = """
        i want answer like below formate. dont added any thing explain 
### Step 1: Update `Strings` Class

```dart
    // New keys for SplashPageView
    static const String agricultural = 'agricultural';
    static const String expert = 'expert';
    static const String companionText = 'companion_text';

```

### Step 2: Update `en_us_translation.dart`

```dart

    // Translations for SplashPageView
    Strings.agricultural : 'Agricultural',
    Strings.expert : 'Expert',
    Strings.companionText : 'Your companion for agricultural expertise',

```

### Step 3: write new code to Use Translations liks Strings.agricultural.tr

```dart

"""

                prompt_content = f"""
{frist}
{view_content}
```
{answer}

```
"""

                # Write to the corresponding file in the prompt directory
              # Determine relative path from 'views' directory
                relative_path = os.path.relpath(dart_file_path, subdir)
                
                # Construct the corresponding path in the 'prompt' directory
                markdown_dir = os.path.join(prompt_dir, os.path.dirname(relative_path))
                os.makedirs(markdown_dir, exist_ok=True)
                
                markdown_file_path = os.path.join(markdown_dir, f"{file_name.replace('.dart', '')}.md")
                
                # Write the markdown content to the file
                with open(markdown_file_path, 'w') as markdown_file:
                    markdown_file.write(prompt_content)
