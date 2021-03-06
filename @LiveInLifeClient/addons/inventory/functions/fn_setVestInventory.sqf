
params [
    ["_unit", objNull, [objNull]],
    ["_items", [], ["", []]]
];

try {
    if (isNull _unit) throw false;
    if ((count _items) != 3) throw false;

    private _vestContainer = (vestContainer _unit);
    if (isNull _vestContainer) throw false;

    {
        if !(isNull ([_unit, _x] call lilc_inventory_fnc_canAdd)) then {
            _vestContainer addItemCargoGlobal [_x, 1];
        } else {
            [(getPosASL player), [_x]] call lilc_inventory_fnc_groundItems;
        };
    } forEach (_items select 0);

    {
        if !(isNull ([_unit, (_x select 0)] call lilc_inventory_fnc_canAdd)) then {
            _vestContainer addMagazineAmmoCargo [(_x select 0), 1, (_x select 1)];
        } else {
            [(getPosASL player), [(_x select 0)]] call lilc_inventory_fnc_groundItems;
        };
    } forEach (_items select 1);
    
    {
        if !(isNull ([_unit, _x] call lilc_inventory_fnc_canAdd)) then {
            _vestContainer addWeaponCargoGlobal [_x, 1];
        } else {
            [(getPosASL player), [_x]] call lilc_inventory_fnc_groundItems;
        };
    } forEach (_items select 2);
    throw true;
} catch {
    _exception;
};
