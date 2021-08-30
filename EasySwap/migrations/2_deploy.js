const Tetra = artifacts.require("Tetra");
const Couple = artifacts.require("Couple");
const EasySwap = artifacts.require("EasySwap");

module.exports = async function(deployer) {
	
	await deployer.deploy(Tetra);
	
	const tetra =  await Tetra.deployed();
	
	await deployer.deploy(Couple, tetra.address);
	
	const couple = await Couple.deployed();
	
	await deployer.deploy(EasySwap, tetra.address, couple.address, 1000);
	
	const easySwap = await EasySwap.deployed();
	
	await tetra.passMinter(easySwap.address);
	
	await easySwap.initialMinting();
	
};