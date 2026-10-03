package 
{
    import analytics.*;
    import data.*;
    import flash.display.*;
    import flash.external.*;
    import flash.net.*;
    import playerio.*;

    public class Global extends Object
    {
        public static var player_is_guest:Boolean = false;
        public static var player_is_beta_member:Boolean = false;
        public static var play_sounds:Boolean = true;
        public static var playing_on_armorgames:Boolean = false;
        public static var playing_on_faceboook:Boolean = false;
        public static var playing_on_playedonline:Boolean = false;
        public static var playing_on_kongregate:Boolean = false;
        public static var client:Client;
        public static var default_label_text:String = "Benjaminsen is god!";
        public static var fullWidth:int = 640;
        public static var fullHeight:int = 500;
        public static var stage:Stage;
        public static var tracker:Tracker;
        public static var testing:Testing;
        public static var cookie:SharedObject;
        public static var sharedCookie:SharedObject;
        public static var playerObject:SimplePlayerObject;
        public static var chatIsVisible:Boolean = false;
        public static var affiliate:String = "";
        public static var base:EverybodyEdits;
        public static var pianoOffset:int = 0;
        public static var drumOffset:int = 0;
        public static var hasOwner:Boolean = false;
        public static var currentLevelname:String = "";
        public static var canchat:Boolean = false;
        public static var roomid:String = "";

        public function Global()
        {
            return;
        }// end function

        public static function get width() : int
        {
            if (!stage)
            {
                return fullWidth;
            }
            if (stage.displayState == StageDisplayState.NORMAL)
            {
                return Math.min(Math.max(Config.minwidth, stage.stageWidth), Config.maxwidth);
            }
            return fullWidth;
        }// end function

        public static function get height() : int
        {
            if (!stage)
            {
                return fullHeight;
            }
            if (stage.displayState == StageDisplayState.NORMAL)
            {
                return stage.stageHeight;
            }
            return fullHeight;
        }// end function

        public static function setPath(param1:String, param2:String = "")
        {
            if (ExternalInterface.available)
            {
                try
                {
                    ExternalInterface.call("setPath", param1, param2 || "/games/" + roomid.split(" ").join("-"));
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

    }
}
