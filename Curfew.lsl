float time;
integer tInt; 
float stime = 0.85;
float etime = 1;
integer eth;
integer sth;
float timeleft;
integer curfew = 0;
vector home;
integer Prelock =0;

release() {
    curfew = 0;
    llOwnerSay("Curfew Ended");
        llOwnerSay("@tploc=y,tplm=y,tplure_sec=y,edit=y,rez=y,detachthis:.Hidden/Home Slave=y,showinv=y");
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
    llOwnerSay("@tploc=n,tplm=n,tplure_sec=n,detach=force,attachallover:.Hidden/Home Slave=force,detachthis:.Hidden/Home Slave=n,edit=n,rez=n,showinv=n");
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
    
  if(eth > sth && currtime<eth && currtime >sth ) {
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

    }

    touch_start(integer total_number)
    {
       
       llOwnerSay((string) llGetGMTclock());
    }
    
    timer() {
       computetime(llGetGMTclock());
       
           }
    
   
    
    
    
    
}
