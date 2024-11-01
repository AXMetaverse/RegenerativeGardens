const GardenContract = artifacts.require("GardenContract");

module.exports = async function(deployer) {
  await deployer.deploy(GardenContract);
  const instance = await GardenContract.deployed();
  console.log("GardenContract deployed at address:", instance.address);
};

