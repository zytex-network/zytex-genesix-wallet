# Genesix

Genesix is a multiplatform mobile wallet for the ZYTEX network. Built using the Flutter framework, it provides a convenient and secure way to manage your ZYTEX cryptocurrency assets.

This wallet harnesses the power of Rust by incorporating a native Rust library from the ZYTEX blockchain, ensuring the same level of security as the ZYTEX Wallet CLI.

## Features

- Securely store and manage your ZYTEX tokens
- View your account balance and transaction history
- Send and receive ZYTEX tokens easily
- Support for multiple platforms, including:
  - Windows
  - macOS
  

 - [Use Release](https://gitlab.com/zytex/wallet-beta/-/releases)

## Installation

Follow the steps below to install and run Genesix on your desired platform.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Rust tool chain](https://www.rust-lang.org/tools/install)
- [Just command runner](https://just.systems/)

### Clone the Repository

```
git clone https://gitlab.com/zytex/wallet-beta.git
```

### Build and Run

1. Install the required dependencies and generate glue code:

```
just init
```

3. Run the app for the current device:

```
flutter run --release
```

4. Or, build the application for your platform (e.g. ``windows``, etc.):

```
flutter build <platform>
```

For platform-specific instructions and additional configuration steps, please refer to the documentation available by following the links provided.
