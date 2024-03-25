// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentidadDigital {
    // Estructura para representar una identidad digital
    struct Identidad {
        string nombre;
        string documento;
        string claveUnica;
        bool verificada;
    }

    // Mapeo para almacenar las identidades digitales
    mapping(uint => Identidad) public identidades;

    // Dirección del propietario del contrato
    address public propietario;

    // Evento para registrar una nueva identidad digital
    event IdentidadRegistrada(uint indexed cedula, string nombre, string documento, string claveUnica);

    // Constructor que inicializa el propietario del contrato
    constructor() {
        propietario = msg.sender;
    }

    // Modificador para restringir el acceso a ciertas funciones solo al propietario del contrato
    modifier soloPropietario() {
        require(msg.sender == propietario, "Solo el propietario puede llamar a esta funcion");
        _;
    }

    // Función para registrar una nueva identidad digital
    function registrarIdentidad(uint _cedula, string memory _nombre, string memory _documento, string memory _claveUnica) public {
        identidades[_cedula] = Identidad({
            nombre: _nombre,
            documento: _documento,
            claveUnica: _claveUnica,
            verificada: false
        });

        emit IdentidadRegistrada(_cedula, _nombre, _documento, _claveUnica);
    }

    // Función para verificar una identidad digital utilizando el número de cédula
    function verificarIdentidad(uint _cedula) public view returns (string memory, string memory) {
        require(identidades[_cedula].verificada == true, "Identidad no verificada");

        return (identidades[_cedula].nombre, identidades[_cedula].claveUnica);
    }

    // Función para verificar una identidad digital y ver la clave única (solo para el propietario)
    function verificarIdentidadConClave(uint _cedula) public view soloPropietario returns (string memory, string memory, string memory) {
        return (identidades[_cedula].nombre, identidades[_cedula].documento, identidades[_cedula].claveUnica);
    }
}
