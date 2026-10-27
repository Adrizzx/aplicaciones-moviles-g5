# RecargaFácil (Flutter)

App sencilla que simula la venta de recargas electrónicas. Solo usa widgets de Flutter, sin paquetes extra. Los íconos e ilustraciones están en `assets/images/` y las fuentes (Lora y Poppins) en `assets/fonts/`.

## Cómo ejecutarla
```
flutter pub get
flutter run
```
Usuario de prueba: **admin** — Contraseña: **1234** (también aparece al tocar "¿Olvidaste tu contraseña?").

## Estructura
```
lib/
├── main.dart                  -> arranque, tema y rutas
├── rutas/rutas_app.dart       -> NAVEGACIÓN por rutas con nombre
├── tema/                      -> TEMA PROPIO (colores, imágenes, tipografía, botones, campos)
├── utilidades/formato.dart    -> formato de dinero, %, fecha y teléfono
├── modelos/                   -> MVC: MODELO (usuario, operadora, recarga + cálculos)
├── controladores/             -> MVC: CONTROLADOR (validaciones y lógica)
└── vistas/                    -> MVC: VISTA (Atomic Design)
    ├── atomos/       botón, campo de texto, título, imagen, logo, logo de operadora
    ├── moleculas/    encabezado, banner, título de sección, tarjeta operadora, chip de valor,
    │                 opción de pago, fila de detalle, fila de comprobante
    ├── organismos/   formulario login, formulario recarga, resumen, comprobante
    └── pantallas/    login, nueva recarga, comprobante
```

## Cálculos
- Comisión = Valor × % comisión
- Total = Valor + Comisión
- Ganancia = Valor × % ganancia

| Operadora | % Comisión | % Ganancia |
|-----------|-----------|-----------|
| Claro     | 3 %       | 2 %       |
| Movistar  | 2,5 %     | 2 %       |
| Tuenti    | 3,5 %     | 2,5 %     |
| Cnt       | 2 %       | 1,5 %     |

Recargas de $20 o más pagan 0,5 % menos de comisión.

## Validaciones
- Usuario y contraseña: obligatorios, mínimo 4 caracteres.
- Número: 10 dígitos, empieza con 09 (solo acepta números).
- Operadora y forma de pago: obligatorias.
- Valor: elegir uno de los botones o escribir otro valor entre $1 y $100.
