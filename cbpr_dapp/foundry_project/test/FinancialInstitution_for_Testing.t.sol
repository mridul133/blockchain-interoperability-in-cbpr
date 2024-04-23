// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FinancialInstitution_for_Testing.sol";

contract FinancialInstitutionTest is Test {
    FinancialInstitution_for_Testing financialInstitution;

    address testAddress = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    address nextAgent = address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
    string constant testAcctNo = "TEST123";
    string constant emptyAcctNo = "";
    string constant isoMsg = string(abi.encodePacked(
            '<?xml version="1.0" encoding="UTF-8"?>',
            '<Document>',
            '   <FIToFICstmrCdtTrf>',
            '      <GrpHdr>',
            '         <MsgId>to-be-generated</MsgId>',
            '         <CreDtTm>2012-12-13T12:12:12</CreDtTm>',
            '         <NbOfTxs>1</NbOfTxs>',
            '         <CtrlSum>450</CtrlSum>',
            '         <TtlIntrBkSttlmAmt Ccy="ETH">150</TtlIntrBkSttlmAmt>',
            '         <IntrBkSttlmDt>2012-12-13</IntrBkSttlmDt>',
            '         <SttlmInf>',
            '            <SttlmMtd>CLRG</SttlmMtd>',
            '         </SttlmInf>',
            '         <InstgAgt>',
            '            <FinInstnId>',
            '               <BICFI>0x70997970C51812dc3A010C7d01b50e0d17dc79C8</BICFI>',
            '               <Nm>Bank ALPHA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-AXB</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </InstgAgt>',
            '         <InstdAgt>',
            '            <FinInstnId>',
            '               <BICFI>0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC</BICFI>',
            '               <Nm>BANK BETA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-AXB</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </InstdAgt>',
            '      </GrpHdr>',
            '      <CdtTrfTxInf>',
            '         <PmtId>',
            '            <UETR>to-be-generated</UETR>',
            '         </PmtId>',
            '         <IntrBkSttlmAmt Ccy="ETH">150</IntrBkSttlmAmt>',
            '         <IntrBkSttlmDt>2012-12-13</IntrBkSttlmDt>',
            '         <InstdAmt Ccy="ETH">150</InstdAmt>',
            '         <XchgRate>1</XchgRate>',
            '         <InstgAgt>',
            '            <FinInstnId>',
            '               <BICFI>0x70997970C51812dc3A010C7d01b50e0d17dc79C8</BICFI>',
            '               <Nm>Bank ALPHA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-AXB</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </InstgAgt>',
            '         <InstdAgt>',
            '            <FinInstnId>',
            '               <BICFI>0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC</BICFI>',
            '               <Nm>BANK BETA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-AXB</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </InstdAgt>',
            '         <IntrmyAgt1>',
            '            <FinInstnId>',
            '               <BICFI>0x90F79bf6EB2c4f870365E785982E1f101E93b906</BICFI>',
            '               <Nm>BANK THETA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-DJK</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </IntrmyAgt1>',
            '         <Dbtr>',
            '            <Nm>BINA Corp</Nm>',
            '            <PstlAdr>',
            '               <Ctry>USA</Ctry>',
            '            </PstlAdr>',
            '         </Dbtr>',
            '         <DbtrAcct>',
            '            <Id>',
            '               <Othr>',
            '                  <Id>A37856</Id>',
            '               </Othr>',
            '            </Id>',
            '         </DbtrAcct>',
            '         <DbtrAgt>',
            '            <FinInstnId>',
            '               <BICFI>0x70997970C51812dc3A010C7d01b50e0d17dc79C8</BICFI>',
            '               <Nm>Bank ALPHA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-AXB</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </DbtrAgt>',
            '         <CdtrAgt>',
            '            <FinInstnId>',
            '               <BICFI>0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65</BICFI>',
            '               <Nm>BANK GAMMA</Nm>',
            '               <PstlAdr>',
            '                  <Ctry>CTRY-DJK</Ctry>',
            '               </PstlAdr>',
            '            </FinInstnId>',
            '         </CdtrAgt>',
            '         <Cdtr>',
            '            <Nm>PETROX Corp</Nm>',
            '            <PstlAdr>',
            '               <Ctry>UK</Ctry>',
            '            </PstlAdr>',
            '         </Cdtr>',
            '         <CdtrAcct>',
            '            <Id>',
            '               <IBAN>BG65893</IBAN>',
            '            </Id>',
            '         </CdtrAcct>',
            '      </CdtTrfTxInf>',
            '   </FIToFICstmrCdtTrf>',
            '</Document>'
        ));
    

    function setUp() public {
        financialInstitution = new FinancialInstitution_for_Testing();
    }

    function testAccountCreation() public {
        vm.startPrank(testAddress);
        financialInstitution.create_account("general", testAcctNo);
        vm.stopPrank();
        assertTrue(financialInstitution.checkGeneralAccountExists(testAcctNo, testAddress), "Account should exist after creation.");
    }

    function testDepositIntoGeneralAccount() public {
        vm.startPrank(testAddress);
        financialInstitution.create_account("general", testAcctNo);
        vm.deal(testAddress, 20);  // Ensuring the test account has enough ether to deposit
        financialInstitution.deposit{value: 20}(testAcctNo); // Depositing 1 wei
        assertEq(financialInstitution.get_balance(testAcctNo), 20, "Balance should be 20 wei after deposit.");
        vm.stopPrank();
    }


    function testDepositIntoNostroAccount() public {
        vm.startPrank(testAddress);
        financialInstitution.create_account("nostro", emptyAcctNo);
        vm.deal(testAddress, 30);
        financialInstitution.deposit{value: 30}(emptyAcctNo);
        string memory acctNo = financialInstitution.nostroAccountNo(testAddress);
        // assertEq(financialInstitution.get_balance(acctNo), 30, "Nostro account balance should be 30 after deposit.");
        vm.stopPrank();
    }

    function testInitiateTransfer() public {
        FinancialInstitution_for_Testing.DbtrInstruction memory dbtrInstruction = FinancialInstitution_for_Testing.DbtrInstruction({
            IntrBkSttlmAmt: FinancialInstitution_for_Testing.Amount({
                Ccy: "USD",
                Amt: 70
            }),
            DbtrAgt: testAddress,
            DbtrAcct: testAcctNo,
            DbtrAgtIsoMsg: isoMsg,
            NxtAgt: nextAgent
        });

        vm.startPrank(testAddress);
        financialInstitution.create_account("general", testAcctNo);
        vm.deal(testAddress, 100);
        financialInstitution.deposit{value: 100}(testAcctNo);  // Ensure there is enough balance
        financialInstitution.initiate_transfer(dbtrInstruction);
        // assertEq(financialInstitution.get_balance(testAcctNo), 30, "Balance should be 30 after transfer of 70.");
        vm.stopPrank();
    }



    function testMakeTransfer() public {
        FinancialInstitution_for_Testing.MsgInfo memory msgDetails = FinancialInstitution_for_Testing.MsgInfo({
            
            CtrlSum: 210,
            TtlIntrBkSttlmAmt: FinancialInstitution_for_Testing.Amount({
                Ccy: "USD",
                Amt: 70
            }),
            InstgAgt: testAddress,
            InstdAgt: nextAgent,
            IntrBkSttlmAmt: FinancialInstitution_for_Testing.Amount({
                Ccy: "USD",
                Amt: 70
            }),
            InstdAmt: FinancialInstitution_for_Testing.Amount({
                Ccy: "USD",
                Amt: 70
            }),
            XchgRate: 1,
            DbtrAgt: testAddress,
            DbtrAcct: testAcctNo,
            CdtrAgt: nextAgent,
            CdtrAcct: "TEST456",
            SttlmMtd: "INGA", 
            SttlmAcct: "AX0000",
            UpdtdMsg: isoMsg,
            NxtAgt: nextAgent
        });


        vm.startPrank(nextAgent);
        financialInstitution.create_account("nostro", emptyAcctNo);
        vm.stopPrank();

        vm.startPrank(testAddress);
        financialInstitution.create_account("nostro", emptyAcctNo);
        vm.deal(testAddress, 100);
        financialInstitution.deposit{value: 100}(emptyAcctNo);
        
        financialInstitution.make_transfer(msgDetails);
        string memory acctNo = financialInstitution.nostroAccountNo(testAddress);
        // assertEq(financialInstitution.get_balance(acctNo), 110, "Balance should be 30 after transfer of 70.");
        // assertEq(financialInstitution.get_balance("TEST456"), 70, "Balance should be 70 after receiving 70.");
        vm.stopPrank();
    }

    function testFunctions() public
    {
        testDepositIntoGeneralAccount();
        testDepositIntoNostroAccount();
        testInitiateTransfer();
        testInitiateTransfer();
        testInitiateTransfer();
        testMakeTransfer();
        testMakeTransfer();
        testMakeTransfer();

    }
}
