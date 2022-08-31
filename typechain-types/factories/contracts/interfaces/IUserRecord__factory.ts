/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type {
  IUserRecord,
  IUserRecordInterface,
} from "../../../contracts/interfaces/IUserRecord";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "resolver",
        type: "address",
      },
      {
        indexed: false,
        internalType: "bytes32",
        name: "id",
        type: "bytes32",
      },
    ],
    name: "NewUserRecordAdded",
    type: "event",
  },
  {
    inputs: [],
    name: "addRecord",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "count",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "recordId",
        type: "bytes32",
      },
    ],
    name: "getRecord",
    outputs: [
      {
        components: [
          {
            internalType: "bytes32",
            name: "recordId",
            type: "bytes32",
          },
          {
            internalType: "address",
            name: "owner",
            type: "address",
          },
          {
            internalType: "address",
            name: "resolver",
            type: "address",
          },
        ],
        internalType: "struct IUserRecord.Record",
        name: "",
        type: "tuple",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
    ],
    name: "setOwner",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
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

export class IUserRecord__factory {
  static readonly abi = _abi;
  static createInterface(): IUserRecordInterface {
    return new utils.Interface(_abi) as IUserRecordInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): IUserRecord {
    return new Contract(address, _abi, signerOrProvider) as IUserRecord;
  }
}
