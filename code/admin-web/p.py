import os
from pathlib import Path

def get_language_identifier(extension):
    """
    Returns the language identifier for Markdown code blocks based on file extension.
    
    Args:
        extension (str): The file extension.
        
    Returns:
        str: The language identifier for Markdown.
    """
    language_map = {
        '.vue': 'vue',
        '.ts': 'typescript',
        '.js': 'javascript',
        '.html': 'html',
        '.css': 'css',
        '.json': 'json',
        '.scss': 'scss',
        '.less': 'less'
    }
    return language_map.get(extension, 'text')  # Default to 'text' if not found

def read_files_from_directories(directories, extensions):
    """
    Reads all files with given extensions from the specified directories and returns their contents.
    
    Args:
        directories (list): A list of directories to search for files.
        extensions (tuple): A tuple of file extensions to include (e.g., ('.vue', '.ts')).
        
    Returns:
        dict: A dictionary where keys are filenames and values are file contents.
    """
    file_contents = {}
    for directory in directories:
        for file_path in Path(directory).rglob('*'):
            if file_path.suffix in extensions:
                with open(file_path, 'r', encoding='utf-8') as file:
                    file_contents[file_path] = file.read()
    return file_contents

def write_to_markdown(file_contents, output_md_file):
    """
    Writes the contents of files into a Markdown file with headers for each file.
    
    Args:
        file_contents (dict): A dictionary where keys are filenames and values are file contents.
        output_md_file (str): The path to the Markdown file to be written.
    """
    with open(output_md_file, 'w', encoding='utf-8') as md_file:
        for file_path, content in file_contents.items():
            # Get the language identifier based on file extension
            language = get_language_identifier(file_path.suffix)
            # Write the header with the filename
            md_file.write(f'# {file_path}\n\n')
            # Write the file content with the language identifier for syntax highlighting
            md_file.write(f'```{language}\n{content}\n```\n\n')

def main(directories, output_md_file, extensions):
    """
    Main function to process files from multiple directories and write their contents to a Markdown file.
    
    Args:
        directories (list): A list of directories to search for files.
        output_md_file (str): The path to the Markdown file to be written.
        extensions (tuple): A tuple of file extensions to include (e.g., ('.vue', '.ts')).
    """
    file_contents = read_files_from_directories(directories, extensions)
    write_to_markdown(file_contents, output_md_file)


if __name__ == '__main__':
    # Define the list of directories to search
    directories = ['/home/mohammed/agri-ai/code/admin-web/src/views/admin/companyai', '/home/mohammed/agri-ai/code/admin-web/src/store/modules/companyai']  # Update these paths
    
    # Define the Markdown output file
    output_md_file = 'output.md'  # Update this path
    
    # File extensions to include (e.g., .vue, .ts)
    extensions = ('.vue', '.ts')
    
    # Run the main function
    main(directories, output_md_file, extensions)
