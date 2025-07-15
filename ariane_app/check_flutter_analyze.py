import subprocess
import sys
import re

def check_flutter_analyze(threshold=50):
    print(f"Running flutter analyze with issue threshold: {threshold}")
    try:
        result = subprocess.run(
            "flutter analyze",
            capture_output=True,
            text=True,
            check=False,
            shell=True,
            cwd="."  # Run in the current directory (ariane_app)
        )
    except FileNotFoundError:
        print("Error: 'flutter' command not found. Make sure Flutter is installed and in your PATH.")
        sys.exit(1)

    output = result.stdout
    
    # Count issues (info, warning, error)
    issue_count = 0
    print("\n--- Flutter Analyze Issues ---")
    for line in output.splitlines():
        if re.match(r"^\s*(info|warning|error) -", line):
            issue_count += 1
            print(line) # Log the issue
    print("----------------------------\n")

    print(f"Flutter analyze reported {issue_count} issues.")

    if issue_count > threshold:
        print(f"Error: Too many issues ({issue_count}) found. Threshold is {threshold}.")
        sys.exit(1)
    else:
        print(f"Flutter analyze passed with {issue_count} issues (threshold: {threshold}).")
        sys.exit(0)

if __name__ == "__main__":
    check_flutter_analyze()
