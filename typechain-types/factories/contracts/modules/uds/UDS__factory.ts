/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../../../common";
import type { UDS, UDSInterface } from "../../../../contracts/modules/uds/UDS";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "_owner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "chainId",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "owner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "rootNode",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "resolver",
        type: "address",
      },
    ],
    name: "setResolver",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b50336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550610326806100606000396000f3fe608060405234801561001057600080fd5b506004361061004c5760003560e01c806302571be3146100515780631896f70a146100815780639a8a05921461009d578063b2bdfa7b146100bb575b600080fd5b61006b600480360381019061006691906101c7565b6100d9565b6040516100789190610235565b60405180910390f35b61009b6004803603810190610096919061027c565b61010c565b005b6100a5610162565b6040516100b291906102d5565b60405180910390f35b6100c3610168565b6040516100d09190610235565b60405180910390f35b60036020528060005260406000206000915054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b806002600084815260200190815260200160002060006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505050565b60015481565b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600080fd5b6000819050919050565b6101a481610191565b81146101af57600080fd5b50565b6000813590506101c18161019b565b92915050565b6000602082840312156101dd576101dc61018c565b5b60006101eb848285016101b2565b91505092915050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b600061021f826101f4565b9050919050565b61022f81610214565b82525050565b600060208201905061024a6000830184610226565b92915050565b61025981610214565b811461026457600080fd5b50565b60008135905061027681610250565b92915050565b600080604083850312156102935761029261018c565b5b60006102a1858286016101b2565b92505060206102b285828601610267565b9150509250929050565b6000819050919050565b6102cf816102bc565b82525050565b60006020820190506102ea60008301846102c6565b9291505056fea2646970667358221220732a8d690966eb69031cb9a2ad80a573c433a8ac2fd5911b0ebaabfa7ec6cef664736f6c63430008110033";

type UDSConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: UDSConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class UDS__factory extends ContractFactory {
  constructor(...args: UDSConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<UDS> {
    return super.deploy(overrides || {}) as Promise<UDS>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): UDS {
    return super.attach(address) as UDS;
  }
  override connect(signer: Signer): UDS__factory {
    return super.connect(signer) as UDS__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): UDSInterface {
    return new utils.Interface(_abi) as UDSInterface;
  }
  static connect(address: string, signerOrProvider: Signer | Provider): UDS {
    return new Contract(address, _abi, signerOrProvider) as UDS;
  }
}
