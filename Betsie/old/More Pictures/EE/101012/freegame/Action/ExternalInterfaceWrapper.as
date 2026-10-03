package 
{
    import flash.events.*;
    import flash.external.*;
    import flash.system.*;

    public class ExternalInterfaceWrapper extends EventDispatcher
    {

        public function ExternalInterfaceWrapper()
        {
            Security.allowDomain("*");
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.addCallback("showUserProfile", this.showUserProfile);
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function showUserProfile(param1:String) : void
        {
            var _loc_2:* = new NavigationEvent(NavigationEvent.SHOW_PROFILE);
            _loc_2.username = param1;
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
