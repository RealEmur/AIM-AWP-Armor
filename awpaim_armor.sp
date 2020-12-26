#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "Aim ve Awp Haritalarında Armor",
	author = "Emur",
	description = "Aim ve Awp haritalarında oyunculara otomatik olarak armor ve kask verir",
	version = "1.0",
	url = "www.pluginmerkezi.com"
};

ConVar aimarmor_helmet = null, aimarmor_awp = null, aimarmor_aim = null;

public void OnPluginStart()
{
	aimarmor_helmet = CreateConVar("sm_aimawparmor_zirh", "0", "Zırhın yanında kaskta verilsin mi?. 1 = Evet 0 = Hayır");
	aimarmor_awp = CreateConVar("sm_aimawparmor_awp", "1", "Eklenti AWP Modunda aktif olsun mu? 1= Aktif 0= Pasif");
	aimarmor_aim = CreateConVar("sm_aimawparmor_aim", "1", "Eklenti AIM Modunda aktif olsun mu? 1= Aktif 0= Pasif");
	AutoExecConfig(true, "aimarmor");
	HookEvent("player_spawn", event_spawn);
}

public void OnMapStart()
{
	char map[32];
	GetCurrentMap(map, sizeof(map));
	if(!(StrContains(map, "aim_",false) != -1 && aimarmor_aim.BoolValue) && !(StrContains(map, "awp_",false) != -1 && aimarmor_awp.BoolValue))
		SetFailState("[SM] Bu eklenti sadece aim veya awp modunda çalışabilir.");
}

public Action event_spawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	SetEntProp(client, Prop_Data, "m_ArmorValue", 100);
	if(aimarmor_helmet.IntValue == 1)
		SetEntProp(client, Prop_Send, "m_bHasHelmet", 1);
}
