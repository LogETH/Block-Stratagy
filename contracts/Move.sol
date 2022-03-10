// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Move {

    //This contract stores movement logic, nothing else. The Map and obsticles (I can't spell) are in another contract connected to this one

    StatStorage getstats;
    Map GameMap;
    Game GameContract;


    function MovePiece(uint GameID, address player, uint256 PieceID, int256 MovementY, int256 MovementX, Map MapAddress) external returns(int, int) {

        int256 TotalMovement;

        TotalMovement = this.AbsoluteValue(int(MovementY)) + this.AbsoluteValue(int(MovementX));
        require(int(getstats.movelimit(PieceID)) <= TotalMovement);

        int CurrentLocationX;
        int CurrentLocationY;

        (CurrentLocationX, CurrentLocationY) = GameContract.getlocation(GameID, player, PieceID);
        CurrentLocationY = MovementY + CurrentLocationY;
        CurrentLocationX = MovementX + CurrentLocationX;

        GameMap.checkwall(MapAddress, CurrentLocationX, CurrentLocationY);

        return(CurrentLocationX,CurrentLocationY);


    }

    function getdistance(int Location1, int Location2, int Location3, int Location4) external view returns(uint){

        int distance1;
        int distance2;
        int TotalDistance;

        distance1 = this.AbsoluteValue(int(Location1) - int(Location3));
        distance2 = this.AbsoluteValue(int(Location2) - int(Location4));

        TotalDistance = distance1 - distance2;

        TotalDistance = this.AbsoluteValue(TotalDistance);

        return uint(TotalDistance);


    }

    function AbsoluteValue(int Value) external pure returns (int){

        if(Value < 0){
            Value = 0-Value;
        }

        return Value;
    }
}

interface Game{

    function getlocation(uint GameID, address Player, uint PieceID) external view returns (int, int);
}

interface Map{

    function checkwall(Map, int, int) external returns (bool);

}

interface StatStorage{
    function movelimit(uint256 PieceID) external returns(uint256);
}
