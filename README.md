# 🚀 Upgradeable Smart Contract System

A professional-grade implementation of upgradeable smart contracts using the UUPS (Universal Upgradeable Proxy Standard) pattern. This project showcases advanced Solidity development practices, comprehensive testing, and secure upgrade mechanisms.

## 🌟 Key Features

- **UUPS Proxy Pattern Implementation**: Leverages OpenZeppelin's battle-tested contracts for secure upgradeability
- **Version Control**: Seamless contract versioning with BoxV1 → BoxV2 upgrade path
- **Comprehensive Testing**: Full test coverage using Foundry's robust testing framework
- **Professional Deployment Scripts**: Automated deployment and upgrade processes
- **Security-First Design**: Implements critical security patterns and access controls

## 🏗️ Technical Architecture

### Smart Contracts

- `BoxV1.sol` - Initial implementation with basic functionality
- `BoxV2.sol` - Enhanced implementation with additional features
- `ERC1967Proxy` - Industry-standard proxy contract from OpenZeppelin

### Infrastructure

- **Framework**: Built with Foundry for modern Solidity development
- **Testing**: Advanced test suite with state management and upgrade verification
- **Deployment**: Automated scripts for both initial deployment and upgrades

## 🔒 Security Features

- Initialization protection using OpenZeppelin's `Initializable`
- Ownership management with `OwnableUpgradeable`
- UUPS upgrade pattern with access controls
- Constructor safeguards for implementation contracts

## Quick Start

```bash
git clone https://github.com/SquilliamX/Foundry-Upgrades.git
cd foundry-upgrades-f23
forge build
```

## 🧪 Testing

```bash
forge test
```

The test suite includes:
- Proxy deployment verification
- Implementation upgrade validation
- State persistence checks
- Access control verification

## 📦 Deployment

The system uses a two-step deployment process:

1. Initial Deployment:
```bash
forge script script/DeployBox.s.sol
```

2. Upgrade Process:
```bash
forge script script/UpgradeBox.s.sol
```

## 🔍 Technical Deep Dive

### Upgrade Pattern
The system implements the UUPS pattern, which:
- Maintains a single proxy entry point
- Preserves contract state during upgrades
- Reduces gas costs compared to alternative patterns
- Provides enhanced security through implementation-side upgrade logic

### State Management
- Utilizes OpenZeppelin's upgradeable contracts
- Implements proper initialization patterns
- Maintains state consistency across upgrades

## 🛠️ Development Stack

- Solidity ^0.8.19
- OpenZeppelin Contracts (Upgradeable)
- Foundry Development Framework
- DevOps Tools for Deployment Management

## 🤝 Contributing

Contributions are welcome! Please check our contributing guidelines and submit PRs for any enhancements.

## 📄 License

MIT

---

*Built with ❤️ by Squilliam*