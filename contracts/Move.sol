// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Move {

    //This contract stores movement logic, nothing else. The Map and obsticles (I can't spell) are in another contract connected to this one

    StatStorage getstats;
    Game GameContract;

    function EditGameContract(Game Contract) external {

        GameContract = Contract;
    }


    function MovePiece(uint GameID, address player, uint256 PieceID, int256 MovementY, int256 MovementX, Map MapAddress) external returns(int, int) {

        require(MovementX != 69, "DEV ERROR");

        int TotalMovement;

        TotalMovement = this.AbsoluteValue(MovementY) + this.AbsoluteValue(MovementX);

        int CurrentLocationX;
        int CurrentLocationY;

        (CurrentLocationX, CurrentLocationY) = GameContract.getlocation(GameID, player, PieceID);
        CurrentLocationY = MovementY + CurrentLocationY;
        CurrentLocationX = MovementX + CurrentLocationX;

        require(MapAddress.getBarrier() >= CurrentLocationX && MapAddress.getBarrier() >= CurrentLocationX, "You can't go out of bounds!");

        require(MapAddress.checkwall(CurrentLocationX, CurrentLocationY) == true, "You're trying to move where a wall is, that's not possible bro");

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
            Value = -1 * Value;
        }

        return Value;
    }
}

interface Game{

    function getlocation(uint GameID, address Player, uint PieceID) external view returns (int, int);
    
}

interface Map{

    function checkwall(int, int) external returns (bool);
    function getBarrier() external view returns (int);

}

interface StatStorage{
    function mov(uint256 PieceID) external view returns(uint256);
}
