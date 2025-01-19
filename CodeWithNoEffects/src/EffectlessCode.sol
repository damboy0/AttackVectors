// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EffectlessCode {
    function sendEther(address payable recipient) external payable {

        recipient.call{value: msg.value};  //paretheses (""); missing so it wont work
    }
}