# Qt Test Project

A Qt-based desktop application with automated CI/CD pipeline using GitHub Actions.

## 🚀 Features

- Modern Qt6-based GUI application
- Automated build pipeline with GitHub Actions
- Cross-platform support (Windows focus)
- NSIS-based installer for easy deployment

## 📋 Prerequisites

- Qt 6.8.1 or later
- CMake 3.27.7 or later
- Visual Studio 2022 (for Windows)
- NSIS (for creating installers)

## 🛠️ Build Instructions

### Local Build

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/test-project.git
   cd test-project
   ```

2. Create a build directory:
   ```bash
   mkdir build && cd build
   ```

3. Configure with CMake:
   ```bash
   cmake .. -G "Visual Studio 17 2022" -A x64
   ```

4. Build the project:
   ```bash
   cmake --build . --config Release
   ```

### CI/CD Pipeline

The project includes a GitHub Actions workflow that automatically:
- Builds the application
- Creates an installer
- Uploads the installer as an artifact

## 📦 Project Structure

```
test-project/
├── .github/workflows/    # GitHub Actions workflow
├── deploy/              # Deployment and installer scripts
│   └── nsis/           # NSIS installer configuration
├── src/                # Source files
├── CMakeLists.txt      # CMake configuration
└── README.md           # This file
```

## 🔧 Configuration

### CMake Options
- `CMAKE_BUILD_TYPE`: Set build type (Debug/Release)
- `CMAKE_PREFIX_PATH`: Path to Qt installation

### GitHub Actions
The workflow is configured in `.github/workflows/build.yml` and includes:
- Qt installation and setup
- Build configuration
- Installer creation
- Artifact upload

## 📄 License

[Your License Here]

## 👥 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## ✨ Acknowledgments

- Qt Framework
- GitHub Actions
- NSIS Installer