import { ethers } from "hardhat";

async function main() {
  
  const token = await ethers.getContractAt("AKX3", "0x1d959ed34e64f157ea9d662fd8d195c8b57aef00");

 
  const akx = await ethers.getContractAt("AKXTokenLogic", "0x92b21674ae818a7169bb65c8aaac5c14a276250f");
  //const tx1 = await token.transferOwnership("0x92b21674ae818a7169bb65c8aaac5c14a276250f");
  //await tx1.wait();
  await (await akx.setFeeWallet("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266")).wait();
  await (await akx.setTreasury("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266")).wait();

  const tx = await akx.buyPresale({from:'0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266', value:ethers.utils.parseEther("2000")});
  await tx.wait();

  const bal = await token.balanceOf("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266");
  const b = ethers.utils.formatEther(bal).toString()
  console.log(b + "AKX");
  console.log(bal)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
