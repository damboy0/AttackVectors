// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractSizeChecker {
     bool public tricked;

    // Function that checks if the caller is a contract
    function isContract(address _addr) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }

    // Function that should only be callable by an EOA
    function supposedToBeProtected()  public {
        require(!isContract(msg.sender), "Caller is not an EOA");
        tricked = true;
    }

    // Attacker function that can be called to exploit the vulnerability
    function attack() external {
        // Call the supposedToBeProtected function from here
         supposedToBeProtected() ;
    }
}