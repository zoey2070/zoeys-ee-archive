package states
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import playerio.*;
    import ui.*;
    import ui.lobby.*;
    import ui.profile.*;
    import ui.roomlist.*;
    import ui.shop.*;

    public class LobbyState extends BlState
    {
        protected var world:Class;
        protected var twitter:Class;
        protected var image:BitmapData;
        protected var levels:Object;
        protected var callback:Function;
        protected var createCallback:Function;
        protected var subtext:BlText;
        protected var bm_subtext:Bitmap;
        protected var roomlist:RoomList;
        protected var createroom:CreateRoom;
        protected var filter:WorldsFilter;
        protected var fbtextfield:TextField;
        protected var tw:Sprite;
        protected var shopbar:ShopBar;
        protected var myworlds:PlayerWorlds;
        protected var loginbox:LobbyLoginBox;
        protected var newfilter:RoomFilter;
        protected var gw:GuestWellcome;
        protected var mainprofile:MainProfile;
        protected var container:Sprite;
        private var handleJoinSaved:Function;
        private var myroomsCallback:Function;
        private var announce:News;
        private var bm_subtext_holder:Sprite;
        private var last_world_reload:Object;
        private var loading_worlds:Boolean;
        private var refreshtimer:Timer;
        private var show_guest_layout:Boolean;

        public function LobbyState(param1:Array, param2:Function, param3:Function, param4:Function, param5:Boolean, param6:EverybodyEdits, param7:Function)
        {
            var tb:BlText;
            var bmtb:Bitmap;
            var f:TextFormat;
            var f2:TextFormat;
            var rooms:* = param1;
            var callback:* = param2;
            var createCallback:* = param3;
            var myroomsCallback:* = param4;
            var iseecom:* = param5;
            var base:* = param6;
            var handleJoinSaved:* = param7;
            this.world = LobbyState_world;
            this.twitter = LobbyState_twitter;
            this.image = new this.world().bitmapData;
            this.levels = {};
            this.subtext = new BlText(11, 300, 11184810);
            this.tw = new Sprite();
            this.shopbar = new ShopBar();
            this.container = new Sprite();
            this.container.x = 0;
            Bl.stage.addChild(this.container);
            this.handleJoinSaved = handleJoinSaved;
            this.myroomsCallback = myroomsCallback;
            this.callback = callback;
            this.createCallback = createCallback;
            Global.tracker.trackPageview("/lobby/" + (Global.player_is_guest ? ("guest") : ("authed")));
            Global.tracker.trackUserEvent("enterlobby");
            this.show_guest_layout = false;
            var t:* = new BlText(30, 400, 14179354);
            t.text = "Everybody Edits";
            var bmt:* = new Bitmap(t.clone());
            bmt.x = 10;
            bmt.y = 5 + (!this.show_guest_layout ? (30) : (0));
            this.container.addChild(bmt);
            this.bm_subtext_holder = new Sprite();
            this.container.addChild(this.bm_subtext_holder);
            if (Global.player_is_beta_member)
            {
                tb = new BlText(11, 400, 16758528);
                tb.text = Bl.data.isbeta ? ("Beta") : ("");
                tb.x = 286;
                tb.y = 3 + (!this.show_guest_layout ? (30) : (0));
                bmtb = new Bitmap(tb.clone());
                bmtb.x = 286;
                bmtb.y = 3 + (!this.show_guest_layout ? (30) : (0));
                this.container.addChild(bmtb);
            }
            var betaonline:int;
            var openonline:int;
            var protectedonline:int;
            this.roomlist = new RoomList(384 - 42 - (this.show_guest_layout ? (6) : (40)), this.joinRoom);
            this.roomlist.x = 13;
            this.roomlist.y = 50 + (!this.show_guest_layout ? (30) : (0)) + 55 >> 0;
            this.newfilter = new RoomFilter(this.roomlist.render, function () : void
            {
                createroom = new CreateRoom(createRoom);
                createroom.x = (Global.width - 327) / 2;
                container.addChild(createroom);
                return;
            }// end function
            , this.reloadRooms);
            this.newfilter.x = 13;
            this.newfilter.y = 10 + (!this.show_guest_layout ? (30) : (0)) + 55 >> 0;
            this.newfilter.height = 384 - 25 - (this.show_guest_layout ? (6) : (40));
            this.container.addChild(this.newfilter);
            this.container.addChild(this.roomlist);
            this.reloadRooms();
            if (!this.show_guest_layout)
            {
                Shop.setContainer(this.container);
                this.shopbar.shop.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                if (Shop.refreshLobby)
                {
                    Shop.refreshLobby = false;
                }
                else
                {
                    shopbar.shop.visible = false;
                }
                return;
            }// end function
            );
                Shop.addEventListener(ShopEvent.ITEM_AQUIRED, this.handleShopUpdate);
                this.shopbar.newsbtn.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                if (announce)
                {
                    announce.visible = true;
                }
                return;
            }// end function
            );
                this.mainprofile = new MainProfile();
                this.mainprofile.x = 324;
                this.mainprofile.y = 10 + (!this.show_guest_layout ? (30) : (0)) + 55;
                this.mainprofile.width = Global.width - this.mainprofile.x - 13;
                this.container.addChild(this.mainprofile);
                this.tw.x = 500;
                this.tw.y = 59;
                this.tw.buttonMode = true;
                this.tw.addChild(new this.twitter());
                this.tw.addEventListener(MouseEvent.CLICK, function (event:Event) : void
            {
                var e:* = event;
                var url:String;
                var request:* = new URLRequest(url);
                try
                {
                    navigateToURL(request, "_new");
                }
                catch (e:Error)
                {
                }
                return;
            }// end function
            );
                this.container.addChildAt(this.tw, 0);
                this.initNews();
                this.container.addChild(this.shopbar);
            }
            else
            {
                this.gw = new GuestWellcome();
                this.gw.x = 327;
                this.gw.y = this.newfilter.y;
                this.container.addChild(this.gw);
                this.loginbox = new LobbyLoginBox(base);
                this.container.addChild(this.loginbox);
                this.loginbox.x = 327;
                this.loginbox.y = this.gw.y + this.gw.height + 10;
            }
            if (iseecom)
            {
                if (Global.client.connectUserId)
                {
                    this.fbtextfield = new TextField();
                    this.fbtextfield.width = 200;
                    this.fbtextfield.autoSize = TextFieldAutoSize.LEFT;
                    f = new TextFormat();
                    f.align = TextFormatAlign.RIGHT;
                    f.color = 0;
                    this.fbtextfield.defaultTextFormat = f;
                    this.fbtextfield.text = Global.client.connectUserId + "-" + Global.client.partnerPay.currentPartner;
                    this.fbtextfield.x = Global.width - 10;
                    this.fbtextfield.y = 500 - this.fbtextfield.height;
                    Bl.stage.addChild(this.fbtextfield);
                    this.container.addChild(this.fbtextfield);
                }
            }
            else
            {
                this.fbtextfield = new TextField();
                this.fbtextfield.width = 200;
                this.fbtextfield.x = 640 - 210;
                this.fbtextfield.y = 50;
                f2 = new TextFormat();
                f2.align = TextFormatAlign.RIGHT;
                f2.color = 0;
                this.fbtextfield.defaultTextFormat = f2;
                this.fbtextfield.text = ">" + (LoaderInfo(Bl.stage.root.loaderInfo).parameters.nonoba$referer || "") + "<";
                this.container.addChild(this.fbtextfield);
            }
            return;
        }// end function

        private function handleShopUpdate(event:ShopEvent) : void
        {
            var e:* = event;
            Global.base.updatePlayerProperties(function () : void
            {
                reloadRooms();
                return;
            }// end function
            );
            return;
        }// end function

        private function reloadRooms() : void
        {
            var to_load:int;
            var all_rooms:Array;
            var id:String;
            var ready:* = function () : void
            {
                var _loc_3:* = undefined;
                loading_worlds = false;
                if (!Global.player_is_guest)
                {
                    PlayerWorlds.addSavedWorlds(all_rooms, Global.base.client, Global.player_is_beta_member, Global.player_is_beta_member);
                }
                enableRefreshButton();
                var _loc_1:Array = [];
                var _loc_2:int = 0;
                while (_loc_2 < all_rooms.length)
                {
                    
                    _loc_3 = all_rooms[_loc_2];
                    if (_loc_3.data)
                    {
                        if (_loc_3.data.owned == "true" && !_loc_3.data.name)
                        {
                        }
                        else if (!_loc_3.data.name)
                        {
                        }
                        else if (_loc_3.id != "ChrisWorld" && _loc_3.data.name.replace(/benjaminsen|benjaminson""benjaminsen|benjaminson/gi, "") != _loc_3.data.name)
                        {
                        }
                        else
                        {
                            _loc_1.push(_loc_3);
                        }
                    }
                    _loc_2++;
                }
                redrawRooms(_loc_1);
                return;
            }// end function
            ;
            this.refreshtimer = new Timer(1000, 1);
            this.refreshtimer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent) : void
            {
                refreshtimer.stop();
                refreshtimer = null;
                enableRefreshButton();
                return;
            }// end function
            );
            this.refreshtimer.start();
            this.newfilter.enableRefreshButton(false);
            this.roomlist.setRooms([]);
            this.roomlist.doRender(true);
            this.loading_worlds = true;
            this.last_world_reload = new Date();
            var loaded:int;
            to_load;
            all_rooms;
            var i:int;
            while (i < Config.tutorial_names.length)
            {
                
                id = new String((i + 1));
                all_rooms.push({id:new String((i + 1)), data:{name:"Tutorial: " + Config.tutorial_names[i], plays:"0", owned:false, needskey:true, tutorial:true, tutorialseen:Global.sharedCookie.data["tutorial_" + id] != null && !Global.player_is_guest}});
                i = (i + 1);
            }
            if (Global.player_is_beta_member)
            {
                to_load = (to_load + 1);
                Global.client.multiplayer.listRooms(Config.server_type_betaroom, {}, 0, 0, function (param1:Array) : void
            {
                all_rooms = all_rooms.concat(param1);
                if (++loaded == to_load)
                {
                    ready();
                }
                return;
            }// end function
            , this.handleLoadRoomError);
            }
            Global.client.multiplayer.listRooms(Config.server_type_normalroom, {}, 0, 0, function (param1:Array) : void
            {
                all_rooms = all_rooms.concat(param1);
                if (++loaded == to_load)
                {
                    ready();
                }
                return;
            }// end function
            , this.handleLoadRoomError);
            return;
        }// end function

        private function enableRefreshButton() : void
        {
            this.newfilter.enableRefreshButton(this.refreshtimer == null && !this.loading_worlds);
            return;
        }// end function

        private function handleLoadRoomError(param1:PlayerIOError) : void
        {
            return;
        }// end function

        private function redrawRooms(param1:Array) : void
        {
            this.roomlist.setRooms(param1);
            this.roomlist.doRender(false);
            this.refresh(param1);
            return;
        }// end function

        private function initNews() : void
        {
            Global.base.requestRemoteMethod("getNews", function (param1:Message) : void
            {
                var loader:Loader;
                var msg:* = param1;
                announce = new News();
                announce.tf_header.text = msg.getString(0);
                announce.tf_body.autoSize = TextFieldAutoSize.LEFT;
                announce.tf_body.htmlText = msg.getString(1);
                announce.tf_date.text = msg.getString(2);
                loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
                {
                    announce.imageloader.visible = false;
                    loader.y = announce.tf_body.y + announce.tf_body.textHeight + 10;
                    loader.x = announce.bg.x + (announce.bg.width - loader.width) / 2;
                    announce.addChild(loader);
                    announce.btnreadblog.y = Math.min(345, loader.y + loader.height + 30);
                    return;
                }// end function
                );
                loader.load(new URLRequest(msg.getString(3)));
                announce.cacheAsBitmap = true;
                announce.x = (Global.width - 300) / 2;
                announce.btnreadblog.useHandCursor = true;
                announce.btnreadblog.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
                {
                    navigateToURL(new URLRequest("http://blog.everybodyedits.com/"), "_new");
                    return;
                }// end function
                );
                if (Global.client.payVault.has("smileypostman"))
                {
                    announce.gotoAndStop(2);
                    announce.fbsharebtn.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
                {
                    navigateToURL(new URLRequest("http://www.facebook.com/sharer.php?u=http%3A//everybodyedits.com/%3Ffbshare"), "_new");
                    Global.tracker.trackPageview("/facebooksharebtn");
                    return;
                }// end function
                );
                }
                else
                {
                    announce.btnreadnewsletter.useHandCursor = true;
                    announce.newsletter_name.tabIndex = 1;
                    announce.newsletter_email.tabIndex = 2;
                    announce.btnreadnewsletter.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
                {
                    var _loc_1:* = new URLRequest("http://playerio.createsend.com/t/r/s/ujddji/");
                    _loc_1.method = URLRequestMethod.POST;
                    var _loc_2:* = new URLVariables();
                    _loc_2["cm-name"] = announce.newsletter_name.text;
                    _loc_2["cm-ujddji-ujddji"] = announce.newsletter_email.text;
                    _loc_1.data = _loc_2;
                    navigateToURL(_loc_1, "_new");
                    return;
                }// end function
                );
                }
                if (Global.sharedCookie.data.hasOwnProperty("news"))
                {
                    announce.visible = (Global.sharedCookie.data.news as String).search(announce.tf_date.text) == -1;
                }
                announce.btn_close.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
                {
                    announce.visible = false;
                    if (!Global.sharedCookie.data.hasOwnProperty("news"))
                    {
                        Global.sharedCookie.data.news = "";
                    }
                    if ((Global.sharedCookie.data.news as String).search(announce.tf_date.text) == -1)
                    {
                        Global.sharedCookie.data.news = Global.sharedCookie.data.news + ("[" + announce.tf_date.text + "]");
                        Global.sharedCookie.flush();
                    }
                    return;
                }// end function
                );
                container.addChild(announce);
                return;
            }// end function
            , Config.debug_news || "");
            return;
        }// end function

        public function refresh(param1:Array) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:RoomInfo = null;
            var _loc_2:Number = 0;
            for each (_loc_3 in param1)
            {
                
                _loc_4 = _loc_3 as RoomInfo;
                if (_loc_4)
                {
                    _loc_2 = _loc_2 + _loc_4.onlineUsers;
                }
            }
            this.subtext.text = _loc_2 + " Online - Click a world to join it!";
            if (this.bm_subtext != null)
            {
                this.bm_subtext_holder.removeChild(this.bm_subtext);
            }
            this.bm_subtext = new Bitmap(this.subtext.clone());
            this.bm_subtext.x = 10;
            this.bm_subtext.y = 42 + (!this.show_guest_layout ? (30) : (0));
            this.bm_subtext_holder.addChild(this.bm_subtext);
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            param1.fillRect(param1.rect, 0);
            Global.stage.frameRate = 20;
            return;
        }// end function

        private function joinRoom(param1:String, param2:String, param3:Object) : void
        {
            var _loc_4:Array = null;
            this.reset();
            if (param3.data.tutorial)
            {
                this.reset();
                Global.sharedCookie.data["tutorial_" + param1] = true;
                this.createCallback(Config.server_type_tutorialroom + param1, "", true);
            }
            else if (param3.data.myworld)
            {
                if (param1 == "savedworld")
                {
                    this.myroomsCallback();
                }
                else if (param1 == "savedbetaworld")
                {
                    this.myroomsCallback(true);
                }
                else if (param1.substring(0, 2) == "PW" || param1.substring(0, 2) == "BW" || param1 == "ChrisWorld" || param1 == "tutorialWorld")
                {
                    Bl.data.roomname = param2;
                    this.callback(param1);
                }
                else
                {
                    _loc_4 = param1.split("x");
                    this.handleJoinSaved(_loc_4[0], _loc_4[1]);
                }
            }
            else
            {
                Bl.data.roomname = param2;
                this.callback(param1);
            }
            return;
        }// end function

        private function createRoom(param1:String, param2:String = "", param3:Boolean = false) : void
        {
            this.reset();
            this.createCallback(param1, param2);
            return;
        }// end function

        override public function resize() : void
        {
            if (this.mainprofile != null)
            {
                this.mainprofile.width = Global.width - this.mainprofile.x - 13;
            }
            this.shopbar.shop.x = (Global.width - 620) / 2;
            var _loc_1:* = this.container.getChildByName("GetGemsNow");
            if (_loc_1)
            {
                _loc_1.x = (Global.width - 606) / 2;
            }
            var _loc_2:* = this.container.getChildByName("Thankyou");
            if (_loc_2)
            {
                _loc_2.x = (Global.width - 472) / 2;
            }
            if (this.announce != null)
            {
                this.announce.x = (Global.width - 300) / 2;
            }
            if (this.createroom != null)
            {
                this.createroom.x = (Global.width - 327) / 2;
            }
            if (this.fbtextfield != null)
            {
                this.fbtextfield.x = Global.width - 10;
            }
            if (!this.show_guest_layout)
            {
                this.container.x = Math.round((Bl.stage.stageWidth - Global.width) / 2);
            }
            else
            {
                this.container.x = Math.round((Bl.stage.stageWidth - 640) / 2);
            }
            return;
        }// end function

        public function reset() : void
        {
            Global.stage.frameRate = Config.maxFrameRate;
            if (this.fbtextfield && this.fbtextfield.parent)
            {
                this.container.removeChild(this.fbtextfield);
            }
            if (this.roomlist && this.roomlist.parent)
            {
                this.container.removeChild(this.roomlist);
            }
            if (this.createroom && this.createroom.parent)
            {
                this.container.removeChild(this.createroom);
            }
            if (this.tw && this.tw.parent)
            {
                this.tw.parent.removeChild(this.tw);
            }
            if (this.loginbox && this.loginbox.parent)
            {
                this.container.removeChild(this.loginbox);
            }
            if (this.shopbar && this.shopbar.parent)
            {
                this.shopbar.parent.removeChild(this.shopbar);
            }
            if (this.container && this.container.parent)
            {
                this.container.parent.removeChild(this.container);
            }
            return;
        }// end function

        override public function get align() : String
        {
            return STATE_ALIGN_LEFT;
        }// end function

    }
}
