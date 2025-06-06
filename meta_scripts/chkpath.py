import os
import argparse

def read_numbers_from_file(filename):
    with open(filename, 'r') as file:
        numbers = [line.strip() for line in file.readlines()]
    return numbers

def find_subfolders_with_numbers(root_path, filename):
    numbers = read_numbers_from_file(filename)
    print(f"Total numbers to be matched: {len(numbers)}")  # Print total numbers

    matching_subfolders = set()  # Use a set to avoid duplicates
    for root, dirs, _ in os.walk(root_path, topdown=True):
        for dir in dirs:
            if any(number in dir for number in numbers):
                matching_subfolder_path = os.path.join(root, dir)
                matching_subfolders.add(matching_subfolder_path)
                # Stop searching in this directory to ensure top-most level only
                dirs[:] = []  # Clear the list of dirs
                print(f"Matching subfolder: {matching_subfolder_path}")
                break  # Assuming only one match per directory level is needed

    print(f"Total matched paths: {len(matching_subfolders)}")
    return matching_subfolders

def main():
    parser = argparse.ArgumentParser(description="Find subfolders with names matching numbers from a file.")
    parser.add_argument("root_path", type=str, help="The root directory path to start searching from.")
    parser.add_argument("filename", type=str, help="The filename containing the list of numbers.")
    
    args = parser.parse_args()
    
    find_subfolders_with_numbers(args.root_path, args.filename)

if __name__ == "__main__":
    main()
