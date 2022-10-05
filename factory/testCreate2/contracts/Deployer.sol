pragma solidity ^0.5.12;
import "./Test.sol";

contract Deployer {
    bytes contractBytecode = hex"608060405234801561001057600080fd5b50336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550610427806100606000396000f3fe608060405234801561001057600080fd5b50600436106100575760003560e01c806306fdde031461005c5780638da5cb5b146100df578063a6f9dae114610129578063f446c1d01461016d578063fa1dda021461018b575b600080fd5b6100646101b9565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a4578082015181840152602081019050610089565b50505050905090810190601f1680156100d15780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6100e76101f6565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b61016b6004803603602081101561013f57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919050505061021b565b005b610175610320565b6040518082815260200191505060405180910390f35b6101b7600480360360208110156101a157600080fd5b8101908080359060200190929190505050610326565b005b60606040518060400160405280600d81526020017f5445535420434f4e545241435400000000000000000000000000000000000000815250905090565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146102dd576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260088152602001807f464f52424944454e00000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b806000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050565b60015481565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146103e8576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260088152602001807f464f52424944454e00000000000000000000000000000000000000000000000081525060200191505060405180910390fd5b806001819055505056fea265627a7a723158201efcec2c524eb043a0507b85327f756627943740356a5423e83f13c382b3cb6564736f6c63430005100032";
    address public result;
    address public owner;

    modifier onlyDeployerOwner() {
        require(owner == msg.sender, "FORBIDEN");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function deploy(bytes32 salt) public onlyDeployerOwner {
        bytes memory bytecode = contractBytecode;
        address addr;

        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }

        result = addr;
    }

    function changeTestOwner(address _newOwner) public onlyDeployerOwner {
        Test(result).changeOwner(_newOwner);
    }
}