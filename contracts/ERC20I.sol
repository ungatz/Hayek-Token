pragma solidity >=0.4.21 <0.6.0;

interface ERC20I {

		// Returns total tokens that can exist.
		function totalSupply() external view returns (uint256);

		// Returns amount of Tokens owned by some wallet/account.
		function balanceOf(address account) external view returns (uint256);

		// Transfers "amount" of tokens from callers account to the
		// supplied recipients account and returns boolean for status
		// of the transfer.
		function transfer(address recipient, uint256 amount) external returns (bool);

		// Returns the allowed amount of the tokens that the spender can spend
		// on-behalf of the owner. As per standard it is 0  by default and
		// can be changed when {approve} or {transferFrom} functions are called.
		function allowance(address owner, address spender) external view returns (uint256);

		// This function sets the allowance of the spender over the callers
		// tokens and returns a boolean indicating the status of operation.
		function approve(address spender, uint256 amount) external returns (bool);

		// Transfers "amount" of tokens from sender to recipient as per the above
		// allowance mechanism. Also "amount" is deducted from the callers allowance.
		function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

		// Emmited when "value" tokens are moved from address "from" toaddress "to".
		event Transfer(address indexed from, address indexed to, uint256 value);

		// Emitted when allowance of "spender" for an "owner" is set by a call
		// to {approve} where "value" is the new allowance.
		event Approval (address indexed owner, address indexed spender, uint256 value);
}
