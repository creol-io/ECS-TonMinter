/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() {
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>')
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

const HDWalletProvider = require("@truffle/hdwallet-provider");

const { projectId, mnemonic,mnemonicLedger, mnemonicGanache } = require('./secrets.json');


// Infura API key
const infura_apikey_dev = projectId;
const infura_apikey_prod = projectId;

// 12 mnemonic words that represents the account that will own the contract
const mnemonic_dev = mnemonic;
const mnemonic_prod = mnemonic;

module.exports = {
  compilers:{
		solc:{
			version: "0.8.0",
			settings:{
				optimizer:{
					enabled: true,
					runs: 200,
				},
			},
		},
  },
  networks: {
    local: {
      host: 'localhost',
      port: 7545,
      gas: 5000000,
      gasPrice: 5e9,
      network_id: '5777'
    },
    ropsten: {
        provider: function() {
            return new HDWalletProvider(mnemonic_dev, "https://ropsten.infura.io/v3/" + infura_apikey_dev);
        },
        network_id: "3",
        gas: 4612388,
        gasPrice: 10,
    },
    rinkeby: {
        provider: function() {
            return new HDWalletProvider(mnemonic_dev, "https://rinkeby.infura.io/v3/" + infura_apikey_dev);
        },
        network_id: "4",
        gas: 4612388
    },
    mainnet: {
        provider: function() {
            return new HDWalletProvider(mnemonic_prod, "https://mainnet.infura.io/v3/" + infura_apikey_prod);
        },
        network_id: "1",
        gas: 4612388,
        gasPrice: 7000000000
    }
  }
};
