import {ethers} from "ethers";
import {Provider} from "@ethersproject/providers";

export const UDSAddress = "0xd527B81D810ffF9493ca96FDbE594B4E10eC826c";
export const DataService = "0x8eC57F94F48b4B744A112dAe1154584208d594C3";
export const DidRegistry = "0x7A0597CcBfDbC707cf9558986989A3F768f9ba73";
export const BaseUserRegistry = "0xA7477197E8248FcF7D777d1DE07087C07664Ff4c";
// @ts-ignore
export const P:Provider = new ethers.providers.WebSocketProvider("ws://localhost:8545", {name: "akx3", chainId: 906, accounts: [process.env.PRIVATE_KEY_LOCAL || ""]})
export const Wallet = new ethers.Wallet(process.env.PRIVATE_KEY_LOCAL || "", P);
