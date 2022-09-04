import * as config from './config';
import {ethers} from "ethers";
import {P as Provider, Wallet} from "./config";
import fs from "fs";

const UDServiceResolverABI = require("../artifacts/contracts/modules/uds/UserDataServiceResolver.sol/UserDataServiceResolver.json");
const UDSABI = require("../artifacts/contracts/modules/uds/UDS.sol/UDS.json").abi;
const BaseUserRegistryABI = require("../artifacts/contracts/registry/BaseUserRegistry.sol/BaseUserRegistry.json");
const DidRegistryABI = require("../artifacts/contracts/modules/DidRegistry.sol/DidRegistry.json").abi;

export const RegisterService = async () => {

    const BURContract = new ethers.Contract(config.BaseUserRegistry,BaseUserRegistryABI.abi);
    // @ts-ignore
    Wallet.connect(Provider);



    const filter:ethers.EventFilter = {
        address: config.BaseUserRegistry,
        topics: [ethers.utils.id("Transfer(address,address,uint256)"), ethers.utils.hexZeroPad(Wallet.address, 32)]
    }

    console.log(filter.topics)


    Provider.on(filter, (event) => {
        console.log(event.x);
    });



   const txfunc= ethers.utils.defaultAbiCoder.encode(['string'],[`register(15,'${Wallet.address}')`])


   const tx = {
       chainId: 906,
       from: Wallet.address,
        to: config.BaseUserRegistry,
        data: txfunc, value: 0,  gasLimit: 53000}
    let tx2 = await Wallet.signTransaction(tx)
// @ts-ignore
    const stx = BURContract.callStatic.register(Wallet.address)









};