// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

pragma solidity ^0.8.0;

contract CardIdentityVerification {
    struct CardData {
        uint256 userID;
        string cardNumber;
        string secretKey;
    }
    
    mapping(bytes32 => CardData) private cardDataByBlock;
    
    event CardIdentityVerified(uint256 userID, string cardNumber);
    
    function verifyCardIdentity(uint256 userID, string memory cardNumber) public {
        bytes32 blockHash = blockhash(block.number - 1); // Hash of the previous block
        
        require(blockHash != bytes32(0), "Block hash not available"); // Ensure previous block hash is available
        
        CardData storage cardData = cardDataByBlock[blockHash];
        
        require(cardData.userID == 0, "Card identity already verified for this block");
        
        cardData.userID = userID;
        cardData.cardNumber = cardNumber;
        
        emit CardIdentityVerified(userID, cardNumber);
    }
    
    function getCardDataByBlock(bytes32 blockHash) public view returns (uint256, string memory) {
        CardData memory cardData = cardDataByBlock[blockHash];
        
        require(cardData.userID != 0, "No card identity verified for this block");
        
        return (cardData.userID, cardData.cardNumber);
    }
}
