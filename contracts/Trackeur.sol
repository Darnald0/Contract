// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;
contract Trackeur {
    event UpdateTracking(address from, address to, string message);
    event OnDelivered(address from, address to, string message, bool giveTip);

    enum  State {
        pending,
        shipped,
        delivered
    }

    struct Product {
        string name;
        uint id;
    }

    State currentState;
    Product product;

    constructor(Product memory _product) public {
        currentState = State.pending;
        product = _product;

    }

    mapping  (address => Product) private AccountProduct;

    function track(address _receiver, address payable _emitter, bool _giveTipe) public {
        if (AccountProduct[_emitter].id != product.id && AccountProduct[_receiver].id != product.id )
        {
            currentState = State.shipped;
            emit UpdateTracking(_emitter, _receiver, "Product shipped");
        }

        if (AccountProduct[_emitter].id != product.id && AccountProduct[_receiver].id == product.id )
        {
            currentState = State.delivered;
            emit OnDelivered(_emitter, _receiver, "Product delivered, would you like to give a tip ?", _giveTipe);
            if (_giveTipe) 
            {

                sendTip(_emitter);
            }
        }
    }
    
    function sendTip(address payable _address) payable public 
    {
        _address.transfer(msg.value);
    }
}
