// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract GenericNft is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    Counters.Counter private _issuedSupply;
    uint256 private _maxSupply;

    constructor(uint256 maxSupply, string memory name, string memory tokenId) ERC721(name, tokenId) {
        _maxSupply = maxSupply;
        _issuedSupply.increment();
    }

    function mintNFT(address recipient, string calldata tokenURI, uint256 assetId)
        external onlyOwner
        returns (uint256)
    {
        require(_maxSupply >= _issuedSupply.current(), "The template's max supply has already been reached");

        _issuedSupply.increment();

        _mint(recipient, assetId);
        _setTokenURI(assetId, tokenURI);

        return assetId;
    }

    function setTokenURI(uint256 assetId, string calldata tokenURI) external onlyOwner {
        require(_exists(assetId), "ERC721URIStorage: URI set of nonexistent token");
        _setTokenURI(assetId, tokenURI);
    }

}
