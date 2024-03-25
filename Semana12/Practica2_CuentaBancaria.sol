// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CuentaBancaria {
    // Dirección del titular de la cuenta
    address public titular;
    // Saldo inicial en la cuenta
    uint public saldoInicial;
    // Saldo actual en la cuenta
    uint public saldoActual;

    // Evento emitido al realizar un depósito
    event DepositoRealizado(address indexed cuenta, uint monto);
    // Evento emitido al realizar un retiro
    event RetiroRealizado(address indexed cuenta, uint monto);

    // Constructor del contrato que inicializa el titular y el saldo
    constructor(address _titular, uint _saldoInicial) {
        // Asigna el titular de la cuenta
        titular = _titular;
        // Asigna el saldo inicial y actual de la cuenta
        saldoInicial = _saldoInicial;
        saldoActual = _saldoInicial;
    }

    // Función para realizar un depósito en la cuenta
    function depositar(uint _monto) public {
        require(msg.sender == titular, "Solo el titular puede realizar un deposito");
        saldoActual += _monto;
        emit DepositoRealizado(msg.sender, _monto);
    }

    // Función para realizar un retiro de la cuenta
    function retirar(uint _monto) public {
        require(msg.sender == titular, "Solo el titular puede realizar un retiro");
        require(_monto <= saldoActual, "Saldo insuficiente");
        saldoActual -= _monto;
        emit RetiroRealizado(msg.sender, _monto);
    }

    // Función de vista para obtener el saldo actual de la cuenta
    function obtenerSaldoActual() public view returns (uint) {
        return saldoActual;
    }
}
