// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Prestamo {
    // Direccion del prestamista (quien despliega el contrato)
    address public prestamista;
    // Monto del prestamo en criptomonedas
    uint public montoPrestamo;
    // Tasa de interes del prestamo (porcentaje anual)
    uint public tasaInteres;
    // Plazo del prestamo en meses
    uint public plazo;

    // Constructor del contrato que se ejecuta al desplegar el contrato
    constructor(uint _monto, uint _tasa, uint _plazo) {
        // El prestamista es la direccion del que despliega el contrato
        prestamista = msg.sender;
        // Asigna los valores proporcionados al monto, tasa de interes y plazo del prestamo
        montoPrestamo = _monto;
        tasaInteres = _tasa;
        plazo = _plazo;
    }

    // Funcion de vista para calcular el interes total del prestamo
    function calcularInteres() public view returns (uint) {
        // Calcula el interes total del prestamo (monto * tasa de interes / 100 / 12 * plazo)
        return montoPrestamo * tasaInteres / 100 / 12 * plazo;
    }

    // Funcion de vista para calcular el pago mensual necesario para pagar el prestamo
    function calcularPagoMensual() public view returns (uint) {
        // Calcula el pago mensual (monto del prestamo + interes total / plazo)
        uint interes = calcularInteres();
        return (montoPrestamo + interes) / plazo;
    }

    // Funcion de vista para visualizar el prestamo total mas el interes
    function visualizarPrestamoConInteres() public view returns (uint) {
        // Devuelve el monto total del prestamo mas el interes total
        return montoPrestamo + calcularInteres();
    }

    // Funcion de vista para visualizar el pago mensual necesario para pagar el prestamo
    function visualizarPagoMensual() public view returns (uint) {
        // Devuelve el pago mensual requerido para pagar el prestamo
        return calcularPagoMensual();
    }
}
