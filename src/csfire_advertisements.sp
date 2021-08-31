#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define TIMER_INTERVAL 40.0
#define TAG_CLR "[csfire.gg]"

char g_szAdvertisements[][] = {
    
    " \x0FDiscord!",
    " \x06Steam Group!",
    " \x08Website!"
};

bool bRecentlyConnected[MAXPLAYERS + 1];
Handle PlayerTimer[MAXPLAYERS + 1];
ConVar g_cvEnableAdvertisements;

public Plugin myinfo = {

	name = "[CSFIRE.GG] Advertisements",
	author = "CSFIRE.GG - DEV TEAM",
	description = "Prints advertisements in chat.",
	version = "3.0",
	url = "https://csfire.gg/discord"
}

public void OnPluginStart() {

    g_cvEnableAdvertisements = CreateConVar("sm_advertisements", "0", "Enable or disabled server advertisments", FCVAR_NOTIFY, true, 0.0, true, 1.0);

    CreateTimer(TIMER_INTERVAL, PrintAdvertisement, _, TIMER_REPEAT);

    HookEvent("player_activate", Event_OnPlayerActivate, EventHookMode_Post);
}

public Action Event_OnPlayerActivate(Event hEvent, const char[]UserID, bool bdontBroadcast) {

    int iClient = GetClientOfUserId(hEvent.GetInt("userid"));

    bRecentlyConnected[iClient] = true;

    PlayerTimer[iClient] = CreateTimer(25.0, PlayerTimeManager, iClient);
}

public void OnClientDisconnect(int iClient) {

    if(PlayerTimer[iClient] != null) {

        delete PlayerTimer[iClient];
    }
}

public Action PlayerTimeManager(Handle Timer, int iClient) {

    bRecentlyConnected[iClient] = false;
    return Plugin_Continue;
}

public Action PrintAdvertisement(Handle Timer, int iClient) {

    if(g_cvEnableAdvertisements) {

        for(int i = 0; i <= MaxClients; i++) {

            if(IsClientValid(i) && !bRecentlyConnected[i]) {

        	    PrintToChat(i, "%s%s", TAG_CLR, g_szAdvertisements[GetRandomIntEx(0, sizeof(g_szAdvertisements)-1)]);
            }
        }
	}
    return Plugin_Continue;
}

stock int GetRandomIntEx(int min = 1, int max = 2147483647)
{
    SetRandomSeed(RoundToCeil(GetEngineTime()));
    static int lastrand = 1;
    int random = GetRandomInt(min, max);

    while(random == lastrand)
    {
        SetRandomSeed(RoundToCeil(GetEngineTime()));
        random = GetRandomInt(min, max);
    }

    lastrand = random;

    return random;
}

stock bool IsClientValid(int iClient) {

    return (1 <= iClient <= MaxClients && IsClientInGame(iClient) && !IsFakeClient(iClient) && !IsClientSourceTV(iClient));
}
