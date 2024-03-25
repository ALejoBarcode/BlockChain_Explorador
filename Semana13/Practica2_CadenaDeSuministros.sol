// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CadenaSuministro {
    // Estructura para representar un producto
    struct Producto {
        string nombreProducto;
        address propietario;
        uint estado; // 0: en tránsito, 1: entregado
    }

    // Arreglo de productos
    Producto[] public productos;

    // Mapeo para almacenar la cantidad de productos por producto
    mapping(uint => uint) public cantidadProductos;

    // Dirección del propietario del contrato
    address public propietario;

    // Evento para registrar la entrega de un producto
    event ProductoEntregado(uint indexed productId, address indexed propietario);

    // Constructor que inicializa el propietario del contrato
    constructor() {
        propietario = msg.sender;
    }

    // Función para marcar un producto como entregado
    function entregarProducto(uint _productId) public {
        require(msg.sender == propietario, "Solo el propietario puede llamar a esta funcion");
        require(_productId <= productos.length, "ID de producto no valido");

        Producto storage producto = productos[_productId - 1];
        require(producto.estado == 0, "El producto ya ha sido entregado");

        producto.propietario = propietario;
        producto.estado = 1;

        emit ProductoEntregado(_productId, propietario);
    }

    // Funcion para agregar mas cantidad a un producto existente
    function agregarProductoExistente(uint _productId, uint _cantidad) public {
        require(msg.sender == propietario, "Solo el propietario puede llamar a esta funcion");
        require(_productId <= productos.length && _cantidad > 0, "ID de producto o cantidad no validos");

        cantidadProductos[_productId] += _cantidad;
    }


    // Función para agregar un nuevo producto con un nuevo ID
    function agregarNuevoProducto(string memory _nombreProducto, uint _cantidad) public {
        require(msg.sender == propietario, "Solo el propietario puede llamar a esta funcion");
        require(_cantidad > 0, "Cantidad no valida");

        productos.push(Producto(_nombreProducto, address(0), 0));
        cantidadProductos[productos.length] = _cantidad;
    }

    // Función para obtener la cantidad de productos por producto
    function verProductos() public view returns (uint[] memory, string[] memory, uint[] memory) {
        uint[] memory ids = new uint[](productos.length);
        string[] memory nombres = new string[](productos.length);
        uint[] memory cantidades = new uint[](productos.length);

        for (uint i = 0; i < productos.length; i++) {
            ids[i] = i + 1;
            nombres[i] = productos[i].nombreProducto;
            cantidades[i] = cantidadProductos[i + 1];
        }

        return (ids, nombres, cantidades);
    }
}
