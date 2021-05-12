#include <sourcemod>
#include <autoexecconfig>

#define TAG_CLR "[\x10csfire.gg\x01]"

#pragma newdecls required
#pragma semicolon 1

ConVar g_cvEnableAdvertisements;
float TIME_INTERVAL;
char g_szAdvertisements[][] = 
{
    "\x09Discord",
    "\x08Steam", 
    "\x08Read rules!",

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

	TIME_INTERVAL=45.0;

}

public void OnConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue) {

	if(convar == g_cvEnableAdvertisements)
    {
        g_cvEnableAdvertisements.SetBool(view_as<bool>(StringToInt(newValue)));
    }
	if(StringToInt(newValue) == 1)	
	{
		PrepareAdvertisement();
	}

}

public void PrepareAdvertisement() {

	CreateTimer(TIME_INTERVAL, GetAdvertisement, _, TIMER_REPEAT);

}

public Action GetAdvertisement(Handle timer) {

	int iRandom = eGetRandomInt(0, 6);

	if(g_cvEnableAdvertisements.IntValue == 1)
	{
		PrintToChatAll("%s %s", TAG_CLR, g_szAdvertisements[iRandom]);
		return Plugin_Continue;
	} else {
		return Plugin_Stop;
	}

}

//thanks Entity
stock int eGetRandomInt(int min = 0, int max = 2147483647) {

    int random = GetURandomInt();

    if(random == 0)
        random++;

    return RoundToCeil(float(random) / (float(2147483647) / float(max - min + 1))) + min - 1;

}
