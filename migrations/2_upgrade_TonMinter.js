const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const TonMinter_v2 = artifacts.require('TonMinter_v2');
const TonMinter = artifacts.require('TonMiner');
module.exports = async function (deployer, network, accounts) {

    const existingTonMinter = await TonMinter.deployed();

    await upgradeProxy(existingTonMinter.address, TonMinter_v2, { deployer });

    console.log("Upgraded");

};
