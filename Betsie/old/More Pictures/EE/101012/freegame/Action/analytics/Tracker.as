package analytics
{
    import com.google.analytics.*;
    import flash.display.*;
    import flash.external.*;
    import gameanalytics.*;
    import playerio.*;

    public class Tracker extends Object
    {
        private var stage:Stage;
        private var ga_tracker:GATracker;
        private var prefix:String = "";
        private var tracking_connection:Connection;
        private var que:Array;
        private var connectUserId:String;
        private var _isFirstVisit:Boolean = false;

        public function Tracker(param1:Stage)
        {
            this.que = [];
            this.stage = param1;
            this.ga_tracker = new GATracker(param1, "UA-475693-28", "AS3", false);
            this.connectToService();
            return;
        }// end function

        public function reConnectToService() : void
        {
            if (this.isConnected())
            {
                this.tracking_connection.disconnect();
            }
            this.connectUserId = null;
            this.connectToService();
            return;
        }// end function

        public function connectToService() : void
        {
            if (!Config.disable_tracking)
            {
                PlayerIO.quickConnect.simpleConnect(this.stage, Config.playerio_game_id, "guest", "guest", this.handleConnectedToService);
            }
            return;
        }// end function

        private function handleConnectedToService(param1:Client) : void
        {
            var client:* = param1;
            if (Config.use_debug_server)
            {
                client.multiplayer.developmentServer = Config.developer_server;
            }
            client.multiplayer.createJoinRoom(null, Config.server_type_trackingroom, true, {}, {}, function (param1:Connection) : void
            {
                tracking_connection = param1;
                emptyQue();
                if (connectUserId != null)
                {
                    onPlayerInit(connectUserId);
                }
                if (isFirstVisit())
                {
                    if (Global.sharedCookie != null)
                    {
                        Global.sharedCookie.data["pageloaded"] = true;
                        Global.sharedCookie.flush();
                        tracking_connection.send("firstpageload");
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function isFirstVisit() : Boolean
        {
            this._isFirstVisit = this._isFirstVisit || (Global.sharedCookie == null || !(Global.sharedCookie.data.guestvisit != null || Global.sharedCookie.data.pageloaded != null || Global.sharedCookie.data.toturial != null));
            return this._isFirstVisit;
        }// end function

        public function onPlayerInit(param1:String) : void
        {
            this.connectUserId = param1;
            if (!this.isConnected())
            {
                return;
            }
            if (Global.sharedCookie != null && Global.sharedCookie.data["guesttracker"] != null)
            {
                this.tracking_connection.send("activateUser", "guest_return", Global.sharedCookie.data["guesttracker"]);
                if (!Global.player_is_guest)
                {
                    this.deleteGuestTracker();
                }
                return;
            }
            if (Global.player_is_guest)
            {
                this.tracking_connection.addMessageHandler("statskey", this.onStatsKeyRecieved);
                this.tracking_connection.send("activateUser", "guest");
                return;
            }
            this.tracking_connection.send("activateUser", "registered", param1);
            GameAnalytics.init("187f66b1127cd98e68e483955df24f2a", "bf00bd06f9fbdb60de4b359e4bda1502fe8b6add", Config.server_type_version.toString(), param1);
            GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"Url:" + this.getSWFUrl()}, {event_id:"Browser:" + this.getUserAgent()});
            return;
        }// end function

        public function deleteGuestTracker() : void
        {
            delete Global.sharedCookie.data["guesttracker"];
            return;
        }// end function

        private function onStatsKeyRecieved(param1:Message, param2:String) : void
        {
            if (Global.sharedCookie != null)
            {
                Global.sharedCookie.data["guesttracker"] = param2;
            }
            return;
        }// end function

        public function isConnected() : Boolean
        {
            return this.tracking_connection != null && this.tracking_connection.connected;
        }// end function

        public function disconnect() : void
        {
            if (this.tracking_connection != null && this.tracking_connection.connected)
            {
                this.tracking_connection.disconnect();
            }
            return;
        }// end function

        private function addToQue(param1:Array) : void
        {
            this.que.push(param1);
            return;
        }// end function

        private function emptyQue() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.que.length)
            {
                
                this.trackUserEvent.apply(this, this.que[_loc_1]);
                _loc_1++;
            }
            this.que = [];
            return;
        }// end function

        public function trackUserEvent(... args) : void
        {
            if (this.isConnected())
            {
                this.tracking_connection.send.apply(this, ["playerStats"].concat(args));
            }
            else
            {
                this.addToQue(args);
            }
            return;
        }// end function

        public function trackPageview(param1:String) : void
        {
            this.ga_tracker.trackPageview(this.prefix + param1);
            return;
        }// end function

        public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : void
        {
            this.ga_tracker.trackEvent(param1, param2, param3, param4);
            return;
        }// end function

        public function setGuestPrefix(param1:Number = 0) : void
        {
            this.prefix = param1 > 0 ? ("/guest" + param1) : ("");
            return;
        }// end function

        private function getUserAgent() : String
        {
            var userAgent:String;
            var browser:String;
            try
            {
                userAgent = ExternalInterface.call("window.navigator.userAgent.toString");
                browser;
                if (userAgent.indexOf("Safari") != -1)
                {
                    browser;
                }
                if (userAgent.indexOf("Firefox") != -1)
                {
                    browser;
                }
                if (userAgent.indexOf("Chrome") != -1)
                {
                    browser;
                }
                if (userAgent.indexOf("MSIE") != -1)
                {
                    browser;
                }
                if (userAgent.indexOf("Opera") != -1)
                {
                    browser;
                }
            }
            catch (e:Error)
            {
                return "Unknown";
            }
            return browser;
        }// end function

        private function getSWFUrl() : String
        {
            var url:String;
            try
            {
                url = Global.base.stage.loaderInfo.url;
            }
            catch (e:Error)
            {
                url;
            }
            if (url.indexOf("file://") != -1)
            {
                url;
            }
            url = url.replace("http://", "");
            url = url.replace(":", "%3A");
            return url;
        }// end function

    }
}
