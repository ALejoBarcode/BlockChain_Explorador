// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MiToken {
    // Nombre del token
    string public constant nombre = "MiToken";
    // Símbolo del token
    string public constant simbolo = "MTK";
    // Total de tokens en circulación
    uint256 public totalSupply;

    // Mapeo para almacenar el balance de cada cuenta
    mapping(address => uint256) public balances;

    // Evento para registrar transferencias de tokens
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Constructor del contrato
    constructor() {
        // Se asigna el suministro inicial de tokens al creador del contrato
        totalSupply = 1000000;
        balances[msg.sender] = totalSupply;
    }

    // Función para transferir tokens de una cuenta a otra
    function transferir(address _to, uint256 _value) public {
        require(balances[msg.sender] >= _value, "Saldo insuficiente");

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
    }

    // Función para consultar el balance de una cuenta
    function consultarBalance(address _cuenta) public view returns (uint256) {
        return balances[_cuenta];
    }
}
