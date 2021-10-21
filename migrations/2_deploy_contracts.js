const Trackeur = artifacts.require("Trackeur");

module.exports = function (deployer) {
  deployer.deploy(Trackeur);
};
