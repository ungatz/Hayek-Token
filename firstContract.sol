
/******************************************************************************************************************/
/* A contract in the sense of Solidity is a collection of code (its functions) and data (its state) 						  */
/* that resides at a specific address on the Ethereum blockchain. 																  						  */
/* 																																																							  */
/* A transaction is a message that is sent from one account to another account (which might be the							  */
/* same or empty, see below). It can include binary data (which is called “payload”) and Ether.									  */
/* If the target account contains code, that code is executed and the payload is provided as input data.				  */
/* If the target account is not set (the transaction does not have a recipient or the recipient is set to null),  */
/* the transaction creates a new contract. As already mentioned, the address of that contract is not the zero		  */
/* address but an address derived from the sender and its number of transactions sent (the “nonce”).						  */
/* The payload of such a contract creation transaction is taken to be EVM bytecode and executed.								  */
/* The output data of this execution is permanently stored as the code of the contract.													  */
/* This means that in order to create a contract, you do not send the actual code of the contract,							  */
/* but in fact code that returns that code when executed.																												  */
/******************************************************************************************************************/

																													

		
pragma solidity >=0.7.0 <0.9.0;

contract WHIZToken {
		// making it public for other contracts to acess
		address public minter;
		mapping (address >= uint) public balances;

		// Event to allow clients to react to specifit
		// contract changes.
		event Sent(address from, address to, uint amount);

	constructor(){
		minter = msg.sender;
	}

	// Minter function to send new coins.
	// Can only be used by the creater of contract.
	function mint(address reciever, uint amount){
			require(msg.sender == minter); // confirm that sender is the creator.
			require(amount <= 1e60); // to avoid stupid amounts of coin.
			balances[reciever] += amount; // add specified amount of coin in recievers address.
	}

	// Send function which allows anyone to send coins
	// from one address to another.
	function send(address to, address from, uint amount){
			require(amount <= balances[msg.sender], "Not enough balance !");
			balances[msg.sender] -= amount;
			balances[reciever] += amount;
			emit Send(msg.sender, reciever, amount);
	}
}
