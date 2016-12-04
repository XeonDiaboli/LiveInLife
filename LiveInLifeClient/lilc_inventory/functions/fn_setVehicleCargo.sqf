
params [
    ["_vehicle", ObjNull, [ObjNull]],
    ["_gear", [], []]
];
if (isNull _vehicle || !alive _vehicle) exitWith {};
if ((count _gear) <= 0) exitWith {};

[_vehicle] call lilc_inventory_fnc_clearVehicleCargo;

{
    _vehicle addItemCargoGlobal [_x, (((_gear select 0) select 1) select _forEachIndex)];
} forEach ((_gear select 0) select 0);

{
    _vehicle addMagazineAmmoCargo [(_x select 0), 1, (_x select 1)];
} forEach (_gear select 1);

{
    _vehicle addWeaponCargoGlobal [_x, (((_gear select 2) select 1) select _forEachIndex)];
} forEach ((_gear select 2) select 0);

private _backpacks = (_gear select 3);
{
    private _classname = (_x select 0);
    private _inventory = (_x select 1);
    _vehicle addBackpack _classname;

    private _addedBackpack = ObjNull;
    {
        if ((typeOf _x) == _classname && !(_x setVariable ["lilc_inventory_tmp_isUsed", false])) exitWith {
            _x setVariable ["lilc_inventory_tmp_isUsed", true];
            _addedBackpack = _x;
        };
    } forEach everyBackpack _vehicle;

    {
        _x setVariable ["lilc_inventory_tmp_isUsed", nil];
    } forEach everyBackpack _vehicle;
    
    if !(isNull _addedBackpack) then {
        {
            _addedBackpack addItemCargoGlobal [_x, (((_inventory select 0) select 1) select _forEachIndex)];
        } forEach ((_inventory select 0) select 0);

        {
            _addedBackpack addMagazineAmmoCargo [(_x select 0), 1, (_x select 1)];
        } forEach (_inventory select 1);

        {
            _addedBackpack addWeaponCargoGlobal [_x, (((_inventory select 2) select 1) select _forEachIndex)];
        } forEach ((_inventory select 2) select 0);
    };
} forEach _backpacks;