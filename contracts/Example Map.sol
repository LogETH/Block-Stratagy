// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Map {

//// An example map

    // objects are stored in a special way, the corrdinate is stored in a single int (signed (like -+) integer) by using math
    // Imo people learn better from examples, so here are some
    // There's a nine in the front so it works, without it it would break.
    // 9001023 = (1,23)
    // 9043934 = (43,934)
    // 9004001 = (4,1)

//    How to make your own MAP!

//    To create a wall, simply put in the corrdinates and "true" next to it.
//    Corrdinates are stored in a 7 digit long number, 
//    the first 3 digits are the Y coordinate, the next 3 are the X coordinate, and the last digit is a dummy digit so it works.

    wall[9001001] = true; // There is a wall on (1,1)
    wall[9002002] = true; // There is a wall on (2,2)
    wall[9010007] = true; // There is a wall on (10,7)

//    Same with spawn points, except you have to indicate which spawn point it is, and the number is stored in a different way, but you get it.
//    The main game has 8 spawn points (4 for each player) the first 4 are player 1 and the second 4 are player 2.
    
    spawnlocation[1] = 9005005; // Player 1's spawn location is (5,5)
    spawnlocation[2] = 9005005; // Player 1's spawn location is (5,5)
    spawnlocation[3] = 9005005; // Player 1's spawn location is (5,5)
    spawnlocation[4] = 9005005; // Player 1's spawn location is (5,5)
    spawnlocation[5] = 9005005; // Player 2's spawn location is (5,5)
    spawnlocation[6] = 9005005; // Player 2's spawn location is (5,5)
    spawnlocation[7] = 9005005; // Player 2's spawn location is (5,5)
    spawnlocation[8] = 9005005; // Player 2's spawn location is (5,5)









    // This does make the max spaces 999x999 in a map, but I don't think you'd be going that big.
    
    mapping(int => bool) wall;
    mapping(int => int) spawnlocation;

    function getspawnlocation(int SpawnNumber) external view returns (int, int){

        (int X,int Y) = this.PullVariable(spawnlocation[SpawnNumber]);

        return(X,Y);
    }

    function checkwall(int X, int Y) external returns (bool){

        int corrdinate = this.WriteVariable(X, Y);

        if(wall[corrdinate] = true ){return true;}
        return false;
    }

    // The following function was taken and edited from https://ethresear.ch/t/micro-slots-researching-how-to-store-multiple-values-in-a-single-uint256-slot/5338

    function PullVariable(int corrdinate) public pure returns (int, int){

        int X = ((corrdinate % (10 ** 4)) - (corrdinate % (10 ** (6 - 3)))) / (10 ** (6 - 3));
        int Y = ((corrdinate % (10 ** 3)) - (corrdinate % (10 ** (3 - 3)))) / (10 ** (3 - 3));
        return (X,Y);
    }

    // This one was made by me however

    function WriteVariable(int X, int Y) external pure returns (int){

        int a = (9000000 + (X*1000) + Y);
        return a;
    }



}
