require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

const mnemonic = process.env.MNEMONIC;

module.exports = {
  networks: {
    alfajores: {
      provider: () => new HDWalletProvider(mnemonic, 'wss://alfajores-forno.celo-testnet.org/ws'),
      network_id: 44787,             // Correct Alfajores network ID
      gas: 25000000,                 // Keep the gas limit at 25,000,000
      gasPrice: 500000000,           // Gas price set to 0.5 gwei
      confirmations: 2,              // Number of confirmations to wait between deployments
      timeoutBlocks: 200,            // Timeout in blocks before deployment times out
      skipDryRun: true,              // Skip dry run before migrations
      networkCheckTimeout: 200000,   // Extended timeout to 200 seconds
    },
  },
  compilers: {
    solc: {
      version: "0.8.21",             // Solidity compiler version
    },
  },
};
