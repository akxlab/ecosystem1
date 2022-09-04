import dotenv from "dotenv";
dotenv.config();
import {RegisterService} from "./register";
import * as config from "./config";
import {P} from "./config";
import {ethers} from "ethers";


async function main() {
    await RegisterService();
}

main().then((s) => {

console.log(s)

}).catch(err => console.log(err));