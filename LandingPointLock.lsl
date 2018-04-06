vector exitpoint;
vector pos;
integer restricted = 0;
string xdist;
string ydist;
key currentregion;

UpdateExit () {
 currentregion = llGetRegionName();
 exitpoint = llGetPos();   
    
}




GetDist (){
    
            if(exitpoint){
        pos = llGetPos();
        xdist = (string) (pos.x - exitpoint.x) ;
        ydist = (string) (pos.y - exitpoint.y) ;
        
        
        llOwnerSay("Xdistance to exit: " + xdist + " Ydistance to exit: " + ydist);
        } else {
          llOwnerSay("No exitpoint defined");   
        }
}



default
{
    state_entry()
    {
        llSetTimerEvent(10);
    }

 //   touch_start(integer total_number)
 //   {
 //       llOwnerSay("Touch felt");
 //       if(llDetectedKey(0) == llGetOwner()) { 
 //               GetDist();
 //           }
 //   }
    
    
    changed(integer change) {
        if (change & CHANGED_REGION) 
        {
            UpdateExit();
            
        }
    }
        
     timer() {
         pos = llGetPos();
         if (exitpoint) {
         if((pos.x - exitpoint.x)*(pos.x - exitpoint.x) < 25 && (pos.y - exitpoint.y)*(pos.y - exitpoint.y) < 25){ 
                if(restricted == 1) {
                 llOwnerSay("@tploc=y,tplure=y,tplm=y,detach=y,tplocal:0.1=y");
                 restricted = 0;
                } 
            } else if(restricted == 0) {
                    llOwnerSay("@tploc=n,tplure=n,tplm=n,detach=n,tplocal:0.1=y");
                    restricted = 1;
                }
            }
        }
         
         
      link_message(integer sender_num, integer num, string msg, key id) {
            
         // llOwnerSay("Running LL");
           if(id == llGetOwner()) { 
              GetDist();
          }
           
         }

    on_rez(integer num) {
            if(llGetRegionName() != currentregion) {
                    UpdateExit();
                }
        } 
    
}
