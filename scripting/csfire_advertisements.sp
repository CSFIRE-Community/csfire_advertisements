#include <sourcemod>
#include <autoexecconfig>
#include "files/stocks.sp"

#define AD_COUNT sizeof(g_szAdvertisements)

#define TAG_CLR "[\x10csfire.gg\x01]"
#define TIME_INTERVAL 45.0

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

public void OnPluginStart() 
{
	//LoadTranslations("csfire_advertisements.phrases");

	AutoExecConfig_SetFile("csfire_advertisements");

	g_cvEnableAdvertisements = AutoExecConfig_CreateConVar("sm_advertisements", "0", "Enable or disabled server advertisments", FCVAR_PROTECTED, true, 0.0, true, 1.0);
	g_cvEnableAdvertisements.AddChangeHook(OnConVarChanged);

	AutoExecConfig_ExecuteFile();
	AutoExecConfig_CleanFile();

}

public void OnConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue) {

	if(StringToInt(newValue) == 1)	
	{
		PrepareAdvertisement();
	}

}

public void PrepareAdvertisement() {

	CreateTimer(TIME_INTERVAL, GetAdvertisement, _, TIMER_REPEAT);

}

public Action GetAdvertisement(Handle timer) {

	int AD_COUNT_REAL;
	AD_COUNT_REAL=AD_COUNT-1;

	int iRandom = eGetRandomInt(0, AD_COUNT_REAL);

	if(g_cvEnableAdvertisements.IntValue == 1)
	{
		PrintToChatAll("%s %s", TAG_CLR, g_szAdvertisements[iRandom]);
		return Plugin_Continue;
	} else {
		return Plugin_Stop;
	}

}
