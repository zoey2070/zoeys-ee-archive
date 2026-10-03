package gameanalytics
{
    import __AS3__.vec.*;
    import com.adobe.crypto.*;
    import com.adobe.serialization.json.*;
    import flash.events.*;
    import flash.net.*;

    public class GameAnalytics extends Object
    {
        private static const REQUIRED_FIELDS_USER:Array = ["user_id", "session_id", "build"];
        private static const REQUIRED_FIELDS_DESIGN:Array = ["user_id", "session_id", "build", "event_id"];
        private static const REQUIRED_FIELDS_BUSINESS:Array = ["user_id", "session_id", "build", "event_id", "amount", "currency"];
        private static const REQUIRED_FIELDS_QUALITY:Array = ["user_id", "session_id", "build", "event_id"];
        public static const URL:String = "http://api.gameanalytics.com";
        public static const PORT:int = 80;
        public static const API_VERSION:String = "1";
        public static var DEBUG_MODE:Boolean = false;
        public static var RUN_IN_EDITOR_PLAY_MODE:Boolean = false;
        private static var public_key:String;
        private static var private_key:String;
        private static var build:String;
        private static var user_id:String;
        private static var session_id:String;
        private static var initialized:Boolean = false;
        private static var event_que:Vector.<Array> = new Vector.<Array>;

        public function GameAnalytics()
        {
            return;
        }// end function

        public static function init(param1:String, param2:String, param3:String, param4:String, param5:String = null) : void
        {
            GameAnalytics.public_key = param1;
            GameAnalytics.private_key = param2;
            GameAnalytics.build = param3;
            GameAnalytics.user_id = param4;
            GameAnalytics.session_id = param5 != null ? (param5) : (new Date().getTime() + "x" + (Math.random() * 1000000 >> 0));
            if (GameAnalytics.public_key == null || GameAnalytics.public_key.length == 0)
            {
                throw new GameAnalyticsError("\'public key\' cannot be empty or null.");
            }
            if (GameAnalytics.private_key == null || GameAnalytics.private_key.length == 0)
            {
                throw new GameAnalyticsError("\'private key\' cannot be empty or null.");
            }
            if (GameAnalytics.build == null || GameAnalytics.build.length == 0)
            {
                throw new GameAnalyticsError("\'build\' cannot be empty or null.");
            }
            if (GameAnalytics.user_id == null || GameAnalytics.user_id.length == 0)
            {
                throw new GameAnalyticsError("\'user_id\' cannot be empty or null.");
            }
            if (GameAnalytics.session_id == null || GameAnalytics.session_id.length == 0)
            {
                throw new GameAnalyticsError("\'session_id\' cannot be empty or null.");
            }
            initialized = true;
            emptyEventQue();
            return;
        }// end function

        public static function newEvent(param1:String, ... args) : void
        {
            args = new activation;
            var event_json:String;
            var event:Object;
            var i:int;
            var category:* = param1;
            var events:* = args;
            if (!initialized)
            {
                addToEventQue([].concat());
                return;
            }
            if ( != EventCategory.USER &&  != EventCategory.DESIGN &&  != EventCategory.BUSINESS &&  != EventCategory.QUALITY)
            {
                throw new GameAnalyticsError("Event category type \'" +  + "\' not recognized. Valid types are: " + [EventCategory.USER, EventCategory.DESIGN, EventCategory.BUSINESS, EventCategory.QUALITY]);
            }
            if (length == 0)
            {
                events;
            }
            var req_fields:* = getRequiredFields();
            var h:int;
            while ( < length)
            {
                
                event = [];
                if (hasOwnProperty("build"))
                {
                    throw new GameAnalyticsError("Property \'build\' is found on the event, but the name is reserved for Build name, which is set at init.");
                }
                if (hasOwnProperty("session_id"))
                {
                    throw new GameAnalyticsError("Property \'session_id\' is found on the event, but the name is reserved for Session Id, which is set at init.");
                }
                if (hasOwnProperty("user_id"))
                {
                    throw new GameAnalyticsError("Property \'user_id\' is found on the event, but the name is reserved for User Id, which is set at init.");
                }
                build = build;
                session_id = session_id;
                user_id = user_id;
                i;
                while ( < length)
                {
                    
                    if (!hasOwnProperty([]))
                    {
                        throw new GameAnalyticsError("Property \'" + [] + "\' is required but not found on event with category type \'" +  + "\'.");
                    }
                    i = ( + 1);
                }
                h = ( + 1);
            }
            var request:* = new URLRequest(URL + "/" + API_VERSION + "/" + public_key + "/" + );
            try
            {
                event_json = JSON.encode();
            }
            catch (e:Error)
            {
                throw new GameAnalyticsError("There was an error encoding the event as a JSON object. Error: " + e.message);
            }
            data = ;
            method = URLRequestMethod.POST;
            requestHeaders.push(new URLRequestHeader("Authorization", MD5.hash( + private_key)));
            var requestor:* = new URLLoader();
            addEventListener(Event.COMPLETE, httpRequestComplete);
            addEventListener(IOErrorEvent.IO_ERROR, httpRequestIOError);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, httpRequestSecurityError);
            log("----");
            log("Sending Game Analytics event:" + (RUN_IN_EDITOR_PLAY_MODE ? (" (Running in EDITOR PLAY MODE. Not Sending event)") : ("")));
            log("\tUrl: " + url);
            log("\tHeader: " + MD5.hash( + private_key));
            log("\tData: " + data);
            log("----");
            if (!RUN_IN_EDITOR_PLAY_MODE)
            {
                load();
            }
            return;
        }// end function

        private static function httpRequestComplete(event:Event) : void
        {
            log("Game Analytics Request Complete: " + event.target.data);
            return;
        }// end function

        private static function httpRequestIOError(event:IOErrorEvent) : void
        {
            log("There was an error with the Game Analytics Server. " + event.text);
            return;
        }// end function

        private static function httpRequestSecurityError(event:SecurityErrorEvent) : void
        {
            log("There was an error with the Game Analytics Server. " + event.text);
            return;
        }// end function

        private static function addToEventQue(param1:Array) : void
        {
            event_que.push(param1);
            return;
        }// end function

        private static function emptyEventQue() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < event_que.length)
            {
                
                newEvent.apply(null, event_que[_loc_1]);
                _loc_1++;
            }
            return;
        }// end function

        private static function getRequiredFields(param1:String) : Array
        {
            switch(param1)
            {
                case EventCategory.USER:
                {
                    return REQUIRED_FIELDS_USER;
                }
                case EventCategory.DESIGN:
                {
                    return REQUIRED_FIELDS_DESIGN;
                }
                case EventCategory.BUSINESS:
                {
                    return REQUIRED_FIELDS_BUSINESS;
                }
                case EventCategory.QUALITY:
                {
                    return REQUIRED_FIELDS_QUALITY;
                }
                default:
                {
                    throw new GameAnalyticsError("No such category: " + param1);
                    break;
                }
            }
        }// end function

        public static function log(... args) : void
        {
            if (DEBUG_MODE)
            {
                trace(args);
            }
            return;
        }// end function

    }
}
