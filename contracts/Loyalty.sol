pragma solidity >=0.4.21 <0.6.0;

import "./Hayek.sol";

// Main contract for the loyalty program.
// A business with loyalty program will mint the HYK tokens.
// Consumers can join such loyalty programs.
// And businesses can partner up with other businesses.
// Then Consumers can redeem tokens earned at one business at another
// business provided they are partnered.

contract  Loyalty {
    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    struct Customer {
        address cusAddress;
        bool isReg;
        mapping(address => bool) partOfBusiness;
    }

    struct Business {
        address busAddress;
        bool isReg;
        Hayek tokenIns;
        mapping(address => bool) participants;
        mapping(address => bool) otherBusiness;
    }

    mapping(address => Customer) public customers;
    mapping(address => Business) public businesses;

    function registerBusiness(address _bAd) public {
        // require(msg.sender == owner);
        require(!businesses[_bAd].isReg, "Already Registered");
        Hayek tokenInstance = new Hayek(_bAd);
        businesses[_bAd] = Business(_bAd, true, tokenInstance);
        businesses[_bAd].tokenIns.mint(_bAd, 10000);
    }

    function registerCustomer(address _cAd) public {
        // require(msg.sender = owner);
        require(!customers[_cAd].isReg, "Customer Registered");
        customers[_cAd] = Customer(_cAd, true);
    }

    function joinBusiness(address _bAd) public {
        require(customers[msg.sender].isReg, "This is not a valid customer account");//customer only can call this function
		require(businesses[_bAd].isReg, "This is not a valid business account");
		businesses[_bAd].participants[msg.sender] = true;
		customers[msg.sender].partOfBusiness[_bAd] = true;
    }

    function connectBusiness(address _bAd) public{
		require(businesses[_bAd].isReg, "This is not a valid business account");
		require(businesses[msg.sender].isReg, "This is not a valid business account");
		businesses[msg.sender].otherBusiness[_bAd] = true;
    }

    function spend(address from_bus, address to_bus, uint256 _amount) public {
		require(customers[msg.sender].isReg, "This is not a valid customer account");
		require(businesses[from_bus].isReg, "This is not a valid business account");
		require(businesses[to_bus].isReg, "This is not a valid business account");
		if(from_bus==to_bus){
			businesses[to_bus].tokenIns.transferFrom(msg.sender, to_bus, _amount);
		}else{
			require(businesses[from_bus].otherBusiness[to_bus], "This is not a valid linked business account");
			require(businesses[to_bus].otherBusiness[from_bus], "This is not a valid linked business account");
			businesses[from_bus].tokenIns.burnFrom(msg.sender, _amount);
			businesses[to_bus].tokenIns.mint(to_bus, _amount);
		}
	}

}
