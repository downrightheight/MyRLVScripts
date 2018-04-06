float time;
integer tInt; 
float stime = 16.33;
float etime = 16.5;
integer eth;
integer sth;
float timeleft;
integer curfew = 0;
vector home;
integer Prelock = 0;
key homeparcel;
string RLVStringOn = "@tploc=n,tplm=n,tplure_sec=n,detach=force,attachallover:.Hidden/Home Slave=force,detachthis:.Hidden/Home Slave=n,edit=n,rez=n,showinv=n";
string RLVStringOff = "@tploc=y,tplm=y,tplure_sec=y,edit=y,rez=y,detachthis:.Hidden/Home Slave=y,showinv=y";

restate() {
    if(Prelock == 1 || curfew = 1) {
        llOwnerSay("@detach=n");
    }
    if(curfew = 1 && llList2Key(llGetParcelDetails(llGetPos(),[PARCEL_DETAILS_ID]),0) == homeparcel ) {
        llOwnerSay(RLVStringOn);
    }
}

release() {
    curfew = 0;
    llOwnerSay("Curfew Ended");
        llOwnerSay(RLVStringOff);
        llOwnerSay("@detach=y");
}



enforce () {
   if(curfew == 0) {   
    curfew = 1;
    llOwnerSay("Curfew started");
    llSleep(5);
    llSay(0,llGetDisplayName(llGetOwner()) + " is out after curfew, curfew will now be enforced");
    llOwnerSay("@detach=n");
    llSleep(5);
    llOwnerSay(RLVStringOn);
    llSleep(60);
    llSay(0, "Transporting "+ llGetDisplayName(llGetOwner()) + " to the confinement zone");
    llSleep(5);
    llOwnerSay("@tpto:" +(string) home.x + "/" +(string) home.y + "/" +(string) home.z +"=force");
    
    
    
    
    
    }
}

computetime(float currtime) 
{
    if (currtime > sth) { 
    timeleft = (86400 - currtime + sth) ;
    }
     else { 
     timeleft = (sth - currtime) ;
     }
     
     if(timeleft < 3600 && Prelock == 0) {
         Prelock = 1;
         llOwnerSay("@detach=n");
         }
    else if (timeleft > 3600 && Prelock == 1 && curfew == 0) {
        Prelock = 0;
        llOwnerSay("@detach=y");
        }
          
     
     
     
  //  llOwnerSay("Timeleft" + (string)timeleft);
    
  if (llList2Key(llGetParcelDetails(llGetPos(),[PARCEL_DETAILS_ID]),0) != homeparcel && curfew == 1) {
        llSay(0,llGetDisplayName(llGetOwner()) + " has breached curfew, enforcing curfew");
        enforce();
  }
  else if(eth > sth && currtime<eth && currtime >sth ) {
       enforce();
       }    
   else if(eth < sth && (currtime<eth || currtime>sth) ) {
       enforce();
    }
  else if(curfew == 1) {
      release();
    }
   if((timeleft < 360 || (integer) timeleft & 3600 <60) && curfew == 0) {
        llOwnerSay((string)((integer)(timeleft / 60)) + " minutes to curfew");
     }
}
 
     
    
    








default
{
    state_entry()
    {
        llSetTimerEvent(60);
        eth = (integer) (etime * 3600);
        sth = (integer) (stime * 3600);
        home = llGetRegionCorner() + llGetPos();
        homeparcel = llList2Key(llGetParcelDetails(llGetPos(),[PARCEL_DETAILS_ID]),0);

    }

    touch_start(integer total_number)
    {
       
       llOwnerSay((string) llGetGMTclock());
    }
    
    timer() {
       computetime(llGetGMTclock());
           
       
           }
    on_rez(integer i) {
        if (curfew == 1) {
            restate();
            }
        }
       
        

    
}
