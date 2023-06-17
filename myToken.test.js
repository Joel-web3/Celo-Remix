const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyToken", function () {
    it("Owner is developer address", async function () {
        const account = await ethers.getSigners();
        const MyToken = await ethers.getContractFactory("MyToken");
        const token = await MyToken.deploy();
        await token.deployed();
        expect((await token.owner())).to.be.equal(account[0].address);
    });

    it("Owner transfer ownership", async function () {
        const account = await ethers.getSigners();
        const MyToken = await ethers.getContractFactory("MyToken");
        const token = await MyToken.deploy();
        await token.deployed();

        await token.transferOwnership(account[1].address);
           expect(
               (await token.owner())
        ).to.be.equal(account[1].address)
    });

    it("Buy token", async function(){
        const account = await ethers.getSigners();
        const MyToken = await ethers.getContractFactory("MyToken");
        const token = await MyToken.deploy();
        await token.deployed();
        await token.connect(account[1]).buy({value:ethers.utils.parseEther("0.5")});
        expect((await token.balanceOf(account[1].address)).toString()).to.be.equal("50000000000000000000");
    });

    it("Owner withdraw fee", async function(){
        const account = await ethers.getSigners();
        const MyToken = await ethers.getContractFactory("MyToken");
        const token = await MyToken.deploy();
        await token.deployed();

        let amount = ethers.utils.parseEther("0.5")

        // Buy token
        await token.connect(account[1]).buy({value:amount});

        // Dev claim fee
        await token.withdraw();

        // Get contract balance
        let contractBalance = await ethers.provider.getBalance(token.address)
        expect(contractBalance.toString()).to.be.equal("0");
    })
});