const CardIdentityVerification = artifacts.require("CardIdentityVerification");

module.exports = function(deployer) {
  deployer.deploy(CardIdentityVerification);
};
