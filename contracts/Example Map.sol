// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Map {

//// An example map

    // objects are stored in a special way, the corrdinate is stored in a single uint (unsigned integer) by using math
    // Imo people learn better from examples, so here are some
    // There's a nine in the front so it works, without it it would break.
    // 9001023 = (1,23)
    // 9043934 = (43,934)
    // 9004001 = (4,1)

    // This does make the max spaces 999x999 in a map, but I don't think you'd be going that big.
    
    mapping(int => bool) wall;

    function checkwall(int X, int Y) external returns (bool){

        int corrdinate = this.WriteVariable(X, Y);

        if(wall[corrdinate] = true ){return true;}
        return false;
    }

    // The following function was taken and edited from https://ethresear.ch/t/micro-slots-researching-how-to-store-multiple-values-in-a-single-uint256-slot/5338

    function PullVariable(uint corrdinate) public pure returns (uint, uint){

        uint X = ((corrdinate % (10 ** 4)) - (corrdinate % (10 ** (6 - 3)))) / (10 ** (6 - 3));
        uint Y = ((corrdinate % (10 ** 3)) - (corrdinate % (10 ** (3 - 3)))) / (10 ** (3 - 3));
        return (X,Y);
    }

    // This one was made by me however

    function WriteVariable(int X, int Y) external pure returns (int){

        int a = (9000000 + (X*1000) + Y);
        return a;
    }



}
