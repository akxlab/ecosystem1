/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type {
  BaseResolver,
  BaseResolverInterface,
} from "../../../contracts/resolvers/BaseResolver";

const _abi = [
  {
    inputs: [
      {
        internalType: "bytes4",
        name: "interfaceID",
        type: "bytes4",
      },
    ],
    name: "supportsInterface",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "pure",
    type: "function",
  },
];

export class BaseResolver__factory {
  static readonly abi = _abi;
  static createInterface(): BaseResolverInterface {
    return new utils.Interface(_abi) as BaseResolverInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): BaseResolver {
    return new Contract(address, _abi, signerOrProvider) as BaseResolver;
  }
}
