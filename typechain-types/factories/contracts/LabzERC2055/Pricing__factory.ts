/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type {
  Pricing,
  PricingInterface,
} from "../../../contracts/LabzERC2055/Pricing";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "priceForOne",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "chainId",
        type: "uint256",
      },
    ],
    name: "PriceSet",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "lastPrice",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "priceForOne",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "chainId",
        type: "uint256",
      },
    ],
    name: "PriceUpdated",
    type: "event",
  },
];

export class Pricing__factory {
  static readonly abi = _abi;
  static createInterface(): PricingInterface {
    return new utils.Interface(_abi) as PricingInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): Pricing {
    return new Contract(address, _abi, signerOrProvider) as Pricing;
  }
}