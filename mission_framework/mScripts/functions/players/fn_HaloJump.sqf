params ["_caller"];

_altitude = 1000;

openMap true;
titleText ["Click on the map where you would like to HALO Jump.","PLAIN",0.2];

mapclick = false;

onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

waituntil {mapclick or !(visiblemap)};
if (!visibleMap) exitwith {
	titleText ["Jump aborted.","PLAIN",0.2]
	};

_pos = clickpos;

[0,"BLACK",1] spawn BIS_fnc_fadeEffect;
sleep 1;
openMap false;
_caller setpos [_pos select 0, _pos select 1, _altitude];
[1,"BLACK",1] spawn BIS_fnc_fadeEffect;
_backpack = backpack _caller;
_backpackcontents = [];

if ( _backpack isNotEqualTo "" && _backpack != "B_Parachute" ) then {
	_backpackcontents = backpackItems _caller;
	removeBackpack _caller;
	sleep 0.1;
};

_caller addBackpack "B_Parachute";

waitUntil { !alive _caller || isTouchingGround _caller };
if ( _backpack isNotEqualTo "" && _backpack != "B_Parachute" ) then {
	sleep 2;
	_caller addBackpack _backpack;
	clearAllItemsFromBackpack _caller;
	{ _caller addItemToBackpack _x } foreach _backpackcontents;
};


