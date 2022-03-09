// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Move {

    //This contract stores movement logic, nothing else. The Map and obsticles (I can't spell) are in another contract connected to this one

    StatStorage getstats;

    function MovePiece(uint256 PieceID, uint256 DestinationX, uint256 DestinationY) internal {

        uint256 TotalMovement;
        uint MovementY;
        uint MovementX;
        uint256 Current_LocationX;
        uint256 Current_LocationY;


        TotalMovement = MovementY + MovementX;

        uint Movelimit;
        Movelimit = getstats.movelimit(PieceID);

        require(Movelimit <= TotalMovement);


    }

    function getdistance(int Location1, int Location2, int Location3, int Location4) external returns(uint){

        uint distance1;
        uint distance2;
        uint TotalDistance;

        distance1 = this.AbsoluteValue(int(Location1) - int(Location3));
        distance2 = this.AbsoluteValue(int(Location2) - int(Location4));

        TotalDistance = distance1 - distance2;

        return TotalDistance;


    }

    function AbsoluteValue(int Value) external view returns (uint){

        if(Value < 0){
            Value = 0-Value;
        }

        return uint(Value);
    }

    string text = "This contract stores movement logic for Block Stratagy, there are no other buttons because all of them are internal and can only be called by the main contract";

    function WhatisThisContract() public view returns(string memory){

        return text;
    }

}

interface StatStorage{
    function movelimit(uint256 PieceID) external returns(uint256);
}
