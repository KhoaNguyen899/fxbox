// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./ICard.sol";

contract FxBox is Ownable(msg.sender), ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public currencyToken;
    uint256 public price;
    address public recipient;
    ICard public fxCard;
    uint256 public supply;

    constructor(
        address _fxCard,
        address _currencyToken,
        uint256 _price,
        uint256 _supply,
        address _recipient
    ) {
        currencyToken = IERC20(_currencyToken);
        price = _price;
        fxCard = ICard(_fxCard);
        recipient = _recipient;
        supply = _supply;
    }

    function setPrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    function setRecipient(address _recipient) external onlyOwner {
        recipient = _recipient;
    }

    function setCurrencyToken(address _currencyToken) external onlyOwner {
        currencyToken = IERC20(_currencyToken);
    }

    function setSupply(uint256 _supply) external onlyOwner {
        supply = _supply;
    }

    function buyBox(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Amount should be greater than 0");
        require(supply >= _amount, "Insufficient supply");
        require(msg.sender == tx.origin, "Contracts are not allowed");

        currencyToken.safeTransferFrom(msg.sender, recipient, _amount * price);

        for (uint256 i = 0; i < _amount; i++) {
            fxCard.safeMint(msg.sender);
        }

        supply -= _amount;

        emit BuyedBox(msg.sender, _amount, _amount * price);
    }

    /// @notice event emitted when a user has Deposited a LP
    event BuyedBox(address owner, uint256 amount, uint256 totalPrice);
}
