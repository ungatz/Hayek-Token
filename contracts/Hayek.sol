pragma solidity >=0.4.21 <0.6.0;

import "./ERC20Mintable.sol";

contract Hayek is ERC20Mintable {
    string public name = "Hayek Token";
    string public symbol = "HYK";
    uint8 public decimal = 18; // Setting decimals to 18 to match with Wei distribution.
    address private owner;
    constructor (address _bAd) public {
        owner = _bAd;
    }
}
