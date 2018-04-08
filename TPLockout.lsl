integer baseclock = 60;
integer locktime = 0;
integer lockedout = 0;
integer hardcore = 1;
float mult = 1;

integer CalcLockTime() {

   return (integer) (300 + (baseclock * mult * llFrand(1.0)));


}



normallock() {
    if(hardcore == 1) {
 llOwnerSay("@camdistmax:3=n,shownearby=n,shownametags=n,showworldmap=n,showminimap=n,tplocal:0.1=n");
    }
}


lockdown() {
    llOwnerSay("Entered new region, 5 min tp lockout engaged");
    lockedout = 1;
        llOwnerSay("@tploc=n,tplm=n,detach=n");
         locktime = CalcLockTime();
         llOwnerSay("Lock Time set at " + (string) locktime + " seconds");
    }
    
unlock() {
     
         lockedout = 0;
            llOwnerSay("@tploc=y,tplm=y,detach=y");
            llOwnerSay("TPLockout disengaged");
         

}
    





default
{
    on_rez(integer start_param)
    {
               normallock();
        if(lockedout == 1) {
         lockdown();
        }
    }
    
    
    state_entry()
    {
        normallock();
        if(lockedout == 1) {
         lockdown();
         
        }
    }


    link_message( integer sender_num, integer num, string str, key id )
    {   
        if(str == "touched" && id == llGetOwner() && lockedout == 1) {
                llOwnerSay("TPLockout in effect");
              
           }
   }

    changed(integer change)
    {
    if (change & CHANGED_REGION) //note that it's & and not &&... it's bitwise!
        { //llOwnerSay("sending LL");
          //llMessageLinked(-2,0,"tplockout","");
          lockdown();
        }
    } 


 
    
    timer()
    {
        if(lockedout == 1 ) 
        {
        mult +=1;
        locktime -= baseclock;
        } else if (mult > 1) 
        {
        mult -= 1;
        }
        
        if(locktime < 0) {
            unlock();
        }
      
       
        
        
    }
}
