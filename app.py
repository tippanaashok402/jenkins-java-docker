import platform


def greeting():
    return "Hello from Jenkins Docker Python app"


def main():
    print(greeting())
    print("Python version: " + platform.python_version())
    print("Runtime: CPython")
    print("Status: READY")


if __name__ == "__main__":
    main()
