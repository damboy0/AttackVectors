// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LowLevelCall {
    function Call(address target, bytes memory data) external returns (bytes memory) {
          require(isContract(target), "Target address is not a contract");
        (bool success, bytes memory response) = target.call(data);
        require(success, "Low-level call failed");
        return response;
    }

    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }
}
