//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ICard {
    /**
     * @dev Upgrades the card level
     * @param tokenId The token ID to upgrade
     * @param level The new level
     */
    function upgradeCardLevel(uint256 tokenId, uint256 level) external;

    /**
     * @dev Mints a new token
     * @param to The address to mint the token to
     */
    function safeMint(address to) external;

    /**
     * @dev Upgrades the card opened status
     * @param nftId The token ID to upgrade
     * @param nftOwner The nft owner
     */
    function stakeNFT(address nftOwner, uint256 nftId) external;

    /**
     * @dev Upgrades the card opened status
     * @param owner The token ID to upgrade
     * @param tokenID The nft owner
     */
    function mintCard(
        address owner,
        uint256 tokenID
    ) external returns (uint256);
}
