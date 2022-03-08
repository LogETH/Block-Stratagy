// SPDX-License-Identifier: None

pragma solidity >=0.7.0 <0.9.0;

contract MoveLogic {

    //This contract stores movement logic, nothing else. The Map and obsticles (I can't spell) are in another contract connected to this one

    StatStorage getstats;

    function MovePiece(uint256 PieceID, uint256 DestinationX, uint256 DestinationY) internal {

        uint256 TotalMovement;
        uint MovementY;
        uint MovementX;
        uint256 Current_LocationX;
        uint256 Current_LocationY;

        Current_LocationX = X[tx.origin][PieceID];
        Current_LocationY = Y[tx.origin][PieceID];

        //Absolute Value thingies because solidity doesn't have any built in

        if(DestinationX < 0){
            DestinationX = 0-DestinationX;
        }

        if(DestinationY < 0){
            DestinationY = 0-DestinationX;
        }

        MovementY = Current_LocationY-DestinationY;

        if(MovementY < 0){
            MovementY = 0-MovementY;
        }

        MovementX = Current_LocationX-DestinationX;

        if(MovementX < 0){
            MovementX = 0-MovementX;
        }

        TotalMovement = MovementY + MovementX;

        uint Movelimit;
        Movelimit = getstats.movelimit(PieceID);

        require(Movelimit <= TotalMovement);

        X[tx.origin][PieceID] = DestinationX;
        Y[tx.origin][PieceID] = DestinationY;

    }

    string text = "This contract stores movement logic for this game, there are no other buttons because all of them are internal and can only be called by the main contract";

    function WhatisThisContract() public view returns(string memory){

        return text;
    }

}

interface StatStorage{
    function movelimit(uint256 PieceID) external returns(uint256);
}
interface GameControls{

    

}
