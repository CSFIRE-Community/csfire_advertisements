#include <sourcemod>
#include "files/stocks.sp"

#define TAG_CLR "[\x10csfire.gg\x01]"
#define TIMER_INTERVAL 45.0

#pragma newdecls required
#pragma semicolon 1

ConVar g_cvEnableAdvertisements;
char g_szAdvertisements[][] = 
{
    "\x09Discord",
    "\x08Steam", 
    "\x08Read rules!"

};

public Plugin myinfo =
{
	name = "csfire_advertisements",
	author = "DRANIX",
	description = "",
	version = "1.0",
	url = "https://github.com/dran1x/csfire_advertisements"
};

public void OnPluginStart()  {

	g_cvEnableAdvertisements = CreateConVar("sm_advertisements", "0", "Enable or disabled server advertisments", FCVAR_PROTECTED, true, 0.0, true, 1.0);
	CreateTimer(TIMER_INTERVAL, PrintAdvertisement, _, TIMER_REPEAT);

}

public Action PrintAdvertisement(Handle timer) {

    if(g_cvEnableAdvertisements.IntValue == 1)
        PrintToChatAll("%s %s", TAG_CLR, g_szAdvertisements[eGetRandomInt(0, sizeof(g_szAdvertisements)-1)]);

    return Plugin_Continue;

}
