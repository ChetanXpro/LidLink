# LidLink

LidLink is a lightweight utility for MacBooks that automatically disconnects Bluetooth devices when the laptop lid is closed.

## Features

- Monitors MacBook lid state in real-time
- Automatically disconnects all Bluetooth devices when the lid is closed
- Runs silently in the background with minimal resource usage

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/chetanXpro/LidLink.git
   cd LidLink
   ```

2. Run the installation script:
   ```
   chmod +x install.sh
   ./install.sh
   ```

## Usage

LidLink starts automatically at login. To stop it manually:

```
launchctl unload ~/Library/LaunchAgents/com.user.lidlink.plist
```

## License

[MIT License](https://opensource.org/licenses/MIT)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
