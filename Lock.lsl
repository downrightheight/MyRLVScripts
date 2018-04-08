key owner;
integer locked;
integer channel_dialog;
integer listen_id;
key toucher;

DoLock(key NewOwner) {
    llOwnerSay("Your clit ring has been locked by "+ llKey2Name(NewOwner));
    locked = 1;
    owner = NewOwner;
    llOwnerSay("@detach=n");
}

DoUnlock () {
    llOwnerSay("Your clit ring has been unlocked");
    locked = 0;
    owner = "";
    llOwnerSay("@detach=y");    

}


default
{
    state_entry()
    {
        channel_dialog = -1 - (integer)("0x" + llGetSubString( (string) llGetKey(), -7, -1) );
    }

    touch_start(integer total_number)
    {
        toucher = llDetectedKey(0);
        llMessageLinked(-2,0,"touched",toucher);
        if(locked == 0 ) {
            llDialog(toucher, "Would you like to lock the clit ring", ["lock"],channel_dialog);
            listen_id = llListen(channel_dialog, "", toucher, "lock");
        } else if(locked == 1 && toucher == owner) {
            llDialog(toucher, "Would you like to unlock the clit ring", ["Unlock"],channel_dialog);
            listen_id = llListen(channel_dialog, "", owner, "Unlock");
        }  else if(locked == 1 && toucher == llGetOwner()) { 
            llOwnerSay("Your clit ring is locked by " + llKey2Name(owner));
         } 
        
        
        
        
        } 
       
    listen(integer channel, string name, key id, string message) {
        if(message == "lock") {
            DoLock(id);
        } else if (message == "Unlock") {
            DoUnlock();
            }
        llListenRemove(listen_id);   
    }
    on_rez (integer num) {
        if(locked == 1) {
            llOwnerSay("@detach=n");
        }
        
    }
    
       
}

