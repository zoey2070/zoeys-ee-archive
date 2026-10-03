package 
{
    import flash.events.*;

    public class NavigationEvent extends Event
    {
        public var username:String;
        public var world_id:String;
        public var world_author:String;
        public static const SHOW_PROFILE:String = "show_profile";
        public static const JOIN_WORLD:String = "join_world";
        public static const INVITE_FRIEND:String = "invite_friend";
        public static const LOGOUT:String = "logout";

        public function NavigationEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
