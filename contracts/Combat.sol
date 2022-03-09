// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract combat {

    //This contract stores combat logic, nothing else. It is called whenever there is combat.

    Stat getstats;
    Game getdata;

    function fight(uint GameID, address initiator, address defender, uint Piece1, uint Piece2) external returns (uint, uint){

        
        uint HP1 = getdata.hp(GameID, initiator, Piece1);
        uint HP2 = getdata.hp(GameID, defender, Piece2);

//        this.EnablePreCombatSkills();
        
        this.Attack(Piece1, Piece2);
        if(HP2 <= 0){return (HP1, 0);}
        this.Attack(Piece2, Piece1);
        if(HP1 <= 0){return (0, HP2);}

        if((getstats.spd(Piece1) + 10) > getstats.spd(Piece2)){
 
            this.Attack(Piece1, Piece2);
            if(HP2 <= 0){return (HP1, 0);}
        }
        if((getstats.spd(Piece2) + 10) > getstats.spd(Piece1)){
 
            this.Attack(Piece2, Piece1);
            if(HP1 <= 0){return (0, HP2);}
        }

        return (HP1, HP2); 

    }

    function Attack(uint Initiator, uint Defender) external {

        uint Damage;
        uint LocalHP;

        Damage = getstats.atk(Initiator) - getstats.def(Defender);

//        this.EnableInCombatSkills();

        if(Damage <= 0){Damage = 0;}

        LocalHP -= Damage;


    }

    function skills() external{


    }
}



interface Stat{
    function mov(uint256 PieceID) external returns(uint256);
    function atk(uint256 PieceID) external returns(uint256);
    function def(uint256 PieceID) external returns(uint256);
    function spd(uint256 PieceID) external returns(uint256);
    function maj(uint256 PieceID) external returns(uint256);
    function mhp(uint256 PieceID) external returns(uint256);
}

interface Game{
    function hp(uint GameID, address Who, uint PieceID) external returns(uint256);
}
