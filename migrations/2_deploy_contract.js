const GenericNft = artifacts.require("./GenericNft");

module.exports = (deployer) => {
    // Has already been deployed, just need sales contract    
    return deployer.deploy(GenericNft, 2, "GenericNFT", "GENFT").then((instance) => {
        console.log(instance);
    });
}