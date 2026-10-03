package 
{
    import EverybodyEdits.*;
    import Facebook.*;
    import __AS3__.vec.*;
    import analytics.*;
    import blitter.*;
    import com.adobe.crypto.*;
    import data.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import gameanalytics.*;
    import input.*;
    import items.*;
    import playerio.*;
    import states.*;
    import ui.*;
    import ui.chat.*;
    import ui.login.*;
    import ui.profile.*;

    public class EverybodyEdits extends BlGame
    {
        public var client:Client;
        protected var ui2instance:UI2;
        protected var iseecom:Boolean = false;
        private var mainlogin:MainLogin;
        protected var lb:LoginBox;
        protected var bp:BetaProgram;
        protected var roomname:String = null;
        protected var inviteid:String = null;
        protected var forcejoin:String = null;
        protected var quickinviteid:String = null;
        protected var kongregate:Object;
        protected var sidechat:SideChat;
        protected var seenTutorial:Boolean = false;
        private var eiw:ExternalInterfaceWrapper;
        private var rpcCon:Connection;
        private var rpcConnecting:Boolean = false;
        private var rpcConnectQueue:Vector.<Function>;
        private var forceShowToturial:Boolean = false;
        private var connection:Connection;
        private var deltas:Array;
        private var inited:Boolean = false;
        private var upgrade:Boolean = false;
        private var swapittimer:SharedObject;
        private var loginwindow:LoginWindow;

        public function EverybodyEdits()
        {
            this.bp = new BetaProgram();
            this.rpcConnectQueue = new Vector.<Function>;
            this.deltas = [];
            this.swapittimer = SharedObject.getLocal("swapit");
            super(640, 480, 1);
            Global.base = this;
            Bl.data.brick = 0;
            Bl.data.base = this;
            Bl.data.isbeta = false || Config.forceBeta;
            Bl.data.iskongregate = false;
            Bl.data.onsite = false;
            Bl.data.roomname = "";
            Bl.data.name = "";
            Bl.data.portal_id = 0;
            Bl.data.portal_target = 0;
            Bl.data.coincount = 10;
            Bl.data.fromemail = false;
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage, false, 0, true);
            this.eiw = new ExternalInterfaceWrapper();
            this.eiw.addEventListener(NavigationEvent.SHOW_PROFILE, this.handleShowProfile, false, 0, true);
            return;
        }// end function

        protected function handleAddedToStage(event:Event) : void
        {
            Bl.stage.removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
            Bl.stage.addEventListener(NavigationEvent.SHOW_PROFILE, this.handleShowProfile, false, 0, true);
            Bl.stage.addEventListener(NavigationEvent.JOIN_WORLD, this.handleJoinWorld, false, 0, true);
            Bl.stage.addEventListener(NavigationEvent.LOGOUT, this.handleLogout, false, 0, true);
            KeyState.activate(Bl.stage);
            return;
        }// end function

        protected function handleLogout(event:NavigationEvent) : void
        {
            this.logout();
            return;
        }// end function

        protected function handleShowProfile(event:NavigationEvent) : void
        {
            this.showProfile(event.username, Profile.MODE_INGAME);
            return;
        }// end function

        private function showProfile(param1:String, param2:String = "") : void
        {
            var _loc_3:* = new Profile(param1, param2);
            overlayContainer.addChild(_loc_3);
            return;
        }// end function

        private function showQuickInviteHandler(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = new QuickInviteHandler(param1, param2);
            overlayContainer.addChild(_loc_3);
            return;
        }// end function

        protected function handleJoinWorld(event:NavigationEvent) : void
        {
            this.cleanUIAndConnections();
            this.joinRoom(event.world_id);
            return;
        }// end function

        private function handleFullScreen(event:Event) : void
        {
            var _loc_2:Number = NaN;
            if (Bl.stage.displayState == StageDisplayState.NORMAL)
            {
                Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
            }
            else
            {
                _loc_2 = Math.min(stage.stageHeight / Config.height, stage.stageWidth / Config.width);
                Global.fullWidth = Math.round(Config.width + (stage.stageWidth - Config.width * _loc_2) / _loc_2);
                Global.fullHeight = Math.round(Config.height + (stage.stageHeight - Config.height * _loc_2) / _loc_2);
                Bl.stage.scaleMode = StageScaleMode.SHOW_ALL;
                Bl.stage.dispatchEvent(new Event(Event.RESIZE, false, false));
            }
            return;
        }// end function

        public function updatePlayerProperties(param1:Function) : void
        {
            var spo:SimplePlayerObject;
            var callback:* = param1;
            if (this.client.connectUserId != "simpleguest")
            {
                this.requestRemoteMethod("getMySimplePlayerObject", function (param1:Message) : void
            {
                var _loc_2:* = new SimplePlayerObject();
                _loc_2.name = param1.getString(0);
                _loc_2.smiley = param1.getInt(1);
                _loc_2.maxEnergy = param1.getInt(2);
                _loc_2.chatbanned = param1.getBoolean(3);
                _loc_2.haveSmileyPackage = param1.getBoolean(4);
                _loc_2.isModerator = param1.getBoolean(5);
                _loc_2.room0 = param1.getString(6) != "" ? (param1.getString(6)) : (null);
                _loc_2.betaonlyroom = param1.getString(7) != "" ? (param1.getString(7)) : (null);
                _loc_2.setRooms(param1.getString(8).split(","), param1.getString(9).split(","), param1.getString(10).split(","));
                _loc_2.visible = param1.getBoolean(11);
                _loc_2.banned = param1.getBoolean(12);
                _loc_2.woot = param1.getInt(13);
                Global.playerObject = _loc_2;
                Global.canchat = (client.payVault.has("canchat") || client.payVault.has("canchat2")) && !_loc_2.chatbanned;
                Bl.data.chatbanned = _loc_2.chatbanned || false;
                Global.player_is_beta_member = _loc_2.haveSmileyPackage || client.payVault.has("pro");
                Bl.data.isModerator = _loc_2.isModerator;
                if (!ItemManager.getSmileyById(_loc_2.smiley) || !client.payVault.has(ItemManager.getSmileyById(_loc_2.smiley).payvaultid))
                {
                    _loc_2.smiley = 0;
                }
                callback.call(this);
                GameAnalytics.newEvent(EventCategory.USER, {canchat:Global.canchat, beta:Global.player_is_beta_member, maxEnergy:_loc_2.maxEnergy});
                return;
            }// end function
            );
            }
            else
            {
                spo = new SimplePlayerObject();
                spo.name = "guest";
                spo.smiley = 0;
                spo.maxEnergy = 0;
                spo.chatbanned = true;
                spo.haveSmileyPackage = false;
                spo.isModerator = false;
                spo.room0 = null;
                spo.betaonlyroom = null;
                spo.visible = false;
                spo.banned = false;
                spo.woot = 0;
                Global.playerObject = spo;
                Global.canchat = false;
                Global.player_is_beta_member = spo.haveSmileyPackage || this.client.payVault.has("pro");
                Bl.data.isModerator = spo.isModerator;
                callback.call(this);
            }
            return;
        }// end function

        public function requestRemoteMethod(param1:String, param2:Function, ... args) : void
        {
            args = new activation;
            var name:* = param1;
            var callback:* = param2;
            var args:* = args;
            this.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler(name, function (param1:Message) : void
                {
                    if (callback != null)
                    {
                        callback.apply(this, [param1]);
                    }
                    con.removeMessageHandler(name, arguments.callee);
                    return;
                }// end function
                );
                var m:* = con.createMessage.apply(this, [name].concat(args));
                con.sendMessage(m);
                return;
            }// end function
            );
            return;
        }// end function

        public function getRPCConnection(param1:Function, param2:Function = null) : void
        {
            var callback:* = param1;
            var errorHandler:* = param2;
            if (this.rpcCon != null && this.rpcCon.connected)
            {
                this.callback(this.rpcCon);
            }
            else
            {
                this.rpcConnectQueue.push(callback);
                if (this.rpcConnecting)
                {
                    return;
                }
                this.rpcConnecting = true;
                this.client.multiplayer.createJoinRoom(Global.player_is_guest ? (null) : (this.client.connectUserId), Global.player_is_guest ? (Config.server_type_guestserviceroom) : (Config.server_type_serviceroom), true, {}, {}, function (param1:Connection) : void
            {
                var con:* = param1;
                rpcCon = con;
                con.addMessageHandler("info", function (param1:Message, param2:String, param3:String) : void
                {
                    showInfo(param2, param3);
                    return;
                }// end function
                );
                con.addDisconnectHandler(function () : void
                {
                    disconnectRPC();
                    return;
                }// end function
                );
                con.addMessageHandler("connectioncomplete", function (param1:Message) : void
                {
                    rpcConnecting = false;
                    while (rpcConnectQueue.length)
                    {
                        
                        null.rpcConnectQueue.shift()(rpcCon);
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            , errorHandler);
            }
            return;
        }// end function

        public function disconnectRPC() : void
        {
            if (this.rpcCon != null)
            {
                if (this.rpcCon.connected)
                {
                    this.rpcCon.disconnect();
                }
                this.rpcCon = null;
                this.rpcConnecting = false;
                ;
            }
            return;
        }// end function

        private function cleanUIAndConnections() : void
        {
            if (!Config.isMobile)
            {
                Bl.stage.displayState = StageDisplayState.NORMAL;
            }
            Bl.stage.scaleMode = StageScaleMode.NO_SCALE;
            if (this.ui2instance && this.ui2instance.parent)
            {
                overlayContainer.removeChild(this.ui2instance);
            }
            if (this.sidechat && this.sidechat.parent)
            {
                overlayContainer.removeChild(this.sidechat);
            }
            if (this.connection && this.connection.connected)
            {
                this.connection.disconnect();
            }
            if (state && state is LobbyState)
            {
                LobbyState(state).reset();
            }
            if (state && state is PlayState)
            {
                PlayState(state).reset();
            }
            return;
        }// end function

        public function ShowLobby() : void
        {
            clearOverlayContainer();
            this.cleanUIAndConnections();
            this.showLobby();
            return;
        }// end function

        private function loadStoredCookie(param1:Function) : void
        {
            var l:Loader;
            var so:SharedObject;
            var callback:* = param1;
            try
            {
                so = SharedObject.getLocal("check" + Math.random());
                so.flush();
            }
            catch (e:Error)
            {
                handleError("Error loading SharedObject. Please check you Flash Player settings (Right click -> Global Settings)");
                return;
            }
            if (Config.disableCookie)
            {
                Global.cookie = SharedObject.getLocal("Temp" + Math.random());
                this.callback();
                return;
            }
            if (Config.isMobile)
            {
                Global.cookie = SharedObject.getLocal("ssx");
                this.callback();
                return;
            }
            l = new Loader();
            l.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var e:* = event;
                try
                {
                    Global.cookie = Object(l.content).data;
                }
                catch (e:Error)
                {
                    handleError(e);
                }
                loadPostManCheck(callback);
                return;
            }// end function
            );
            l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.handleError);
            l.load(new URLRequest("http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/ssx.swf"), new LoaderContext(true));
            return;
        }// end function

        private function loadPostManCheck(param1:Function) : void
        {
            var l:Loader;
            var callback:* = param1;
            l = new Loader();
            l.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var e:* = event;
                try
                {
                    Global.sharedCookie = Object(l.content).data;
                    Bl.data.fromemail = Global.sharedCookie.data.fromemail || false;
                }
                catch (e:Error)
                {
                }
                callback();
                return;
            }// end function
            );
            l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.handleError);
            l.load(new URLRequest("http://r.playerio.com/r/everybody-edits-su9rn58o40itdbnw69plyw/ss.swf"), new LoaderContext(true));
            return;
        }// end function

        private function configureBasedOnLoadvariabels() : void
        {
            var _loc_1:* = LoaderInfo(stage.root.loaderInfo).parameters;
            Global.affiliate = _loc_1.ee$affiliate || _loc_1.querystring_a;
            Global.playing_on_kongregate = _loc_1.kongregate_api_path ? (true) : (false);
            Global.playing_on_armorgames = Global.affiliate == "armorgames" || Config.forceArmor;
            Global.playing_on_playedonline = Global.affiliate == "playedonline";
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            var offset:int;
            var e:* = event;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            Global.stage = stage;
            ItemManager.init();
            var toLoad:* = Config.show_debug_profile ? (Config.debug_profile) : ("");
            if (ExternalInterface.available)
            {
                try
                {
                    toLoad = ExternalInterface.call("load_user.toString") || toLoad;
                    this.inviteid = ExternalInterface.call("ee_inviteid.toString");
                    this.quickinviteid = ExternalInterface.call("ee_quickinviteid.toString");
                }
                catch (e:Error)
                {
                }
            }
            if (toLoad != "")
            {
                this.showProfile(toLoad);
                return;
            }
            if (this.quickinviteid != null && this.quickinviteid != "")
            {
                this.showQuickInviteHandler(this.quickinviteid, true);
                return;
            }
            Global.tracker = new Tracker(stage);
            Global.tracker.trackPageview("/");
            offset;
            setInterval(function () : void
            {
                Global.tracker.trackEvent("ping", "online", "minutes", offset);
                offset = offset + 5;
                return;
            }// end function
            , 60 * 5 * 1000);
            this.loadStoredCookie(this.handleLoadCookie);
            return;
        }// end function

        private function handleLoadCookie() : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            if (this.inviteid != null && this.inviteid != "")
            {
                this.showQuickInviteHandler(this.inviteid, false);
                return;
            }
            stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.handleFullScreen);
            Bl.data.showMap = false;
            Bl.data.canEdit = false;
            var _loc_1:* = new LoadState();
            state = _loc_1;
            this.configureBasedOnLoadvariabels();
            this.iseecom = ((LoaderInfo(stage.root.loaderInfo).parameters.nonoba$referer || "") + "").toLowerCase().indexOf("kongregate") == -1;
            Global.affiliate = Global.affiliate || Global.cookie.data.affiliate || null;
            if (ExternalInterface.available)
            {
                try
                {
                    this.forcejoin = ExternalInterface.call("ee_forcejoin.toString");
                    this.inviteid = ExternalInterface.call("ee_inviteid.toString");
                    this.roomname = ExternalInterface.call("ee_roomname.toString");
                    Bl.data.isbeta = ExternalInterface.call("isbeta.toString") == "true" || Config.forceBeta;
                    Bl.data.onsite = ExternalInterface.call("iseecom.toString") == "true" && !Bl.data.isbeta || true;
                    Global.affiliate = ExternalInterface.call("affiliate.toString") || Global.affiliate;
                }
                catch (e:Error)
                {
                }
            }
            if (!Global.cookie.data.affiliate && Global.affiliate)
            {
                Global.cookie.data.affiliate = Global.affiliate;
                Global.cookie.flush();
            }
            this.seenTutorial = Global.sharedCookie.data.toturial || false;
            if (Config.run_in_development_mode)
            {
                this.roomname = Config.development_mode_autojoin_room;
            }
            if (this.roomname != null)
            {
                if (this.roomname.substring(0, 2) == "PW" || this.roomname.substring(0, 2) == "BW" || this.roomname.substring(0, 2) == "OW")
                {
                    this.roomname = this.roomname.split("-").join(" ");
                }
            }
            if (Config.show_debug_friendrequest)
            {
                this.inviteid = Config.debug_friendrequest;
            }
            if (Global.cookie.data.username == "guest")
            {
                Global.cookie.data.username = "";
                Global.cookie.data.password = "";
            }
            var _loc_2:* = LoaderInfo(this.root.loaderInfo).parameters;
            if (_loc_2.GameUserId && _loc_2.UserAuthCode)
            {
                Bl.data.isswappit = true;
                Bl.data.swappitusername = ExternalInterface.call("top.$.userName.toString");
                PlayerIO.connect(stage, Config.playerio_game_id, "secure", _loc_2.GameUserId, _loc_2.UserAuthCode, Global.affiliate, this.simpleConnect, this.handleFailedAuth);
            }
            else if (_loc_2.fb_access_token)
            {
                PlayerIO.quickConnect.facebookOAuthConnect(stage, Config.playerio_game_id, _loc_2.fb_access_token, Global.affiliate, this.simpleConnect, this.handleError);
                FB.init({access_token:_loc_2.fb_access_token, app_id:"132690750091157", debug:true});
                Global.playing_on_faceboook = true;
            }
            else
            {
                if (Global.cookie.data.remember && this.lb && this.lb.keeplogin)
                {
                    this.lb.keeplogin.gotoAndStop(2);
                }
                if (this.forcejoin != null && this.forcejoin != "")
                {
                    this.forcejoin = unescape(this.forcejoin);
                    _loc_3 = this.forcejoin.split(",")[0];
                    _loc_4 = this.forcejoin.split(",")[1];
                    PlayerIO.quickConnect.simpleConnect(Bl.stage, Config.playerio_game_id, _loc_3, _loc_4, this.simpleConnect, this.handleFailedAuth);
                }
                else if (Global.cookie.data.username && Global.cookie.data.password && !Global.playing_on_armorgames && !Global.playing_on_kongregate)
                {
                    PlayerIO.quickConnect.simpleConnect(Bl.stage, Config.playerio_game_id, Global.cookie.data.username, Global.cookie.data.password, this.simpleConnect, this.handleFailedAuth);
                }
                else if (Global.cookie.data.access_token)
                {
                    PlayerIO.quickConnect.facebookOAuthConnect(stage, Config.playerio_game_id, Global.cookie.data.access_token, Global.affiliate, this.simpleConnect, this.handleFailedAuth);
                }
                else
                {
                    this.authenticateUser();
                }
            }
            return;
        }// end function

        private function authenticateWithKongregate(param1:String) : void
        {
            var apiPath:* = param1;
            if (this.lb && this.lb.recoverpass)
            {
                this.lb.recoverpass.visible = false;
            }
            Bl.data.iskongregate = true;
            Security.allowDomain(apiPath);
            var request:* = new URLRequest(apiPath);
            var loader:* = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var user_id:String;
                var token:String;
                var e:* = event;
                kongregate = e.target.content;
                kongregate.services.connect();
                var isKongregateGuest:* = kongregate.services.isGuest();
                if (isKongregateGuest)
                {
                    baseInit();
                    kongregate.services.addEventListener("login", function () : void
                {
                    var _loc_1:* = kongregate.services.getUserId();
                    var _loc_2:* = kongregate.services.getGameAuthToken();
                    PlayerIO.quickConnect.kongregateConnect(stage, Config.playerio_game_id, _loc_1, _loc_2, simpleConnect, handleError);
                    return;
                }// end function
                );
                }
                else
                {
                    user_id = kongregate.services.getUserId();
                    token = kongregate.services.getGameAuthToken();
                    PlayerIO.quickConnect.kongregateConnect(stage, Config.playerio_game_id, user_id, token, simpleConnect, handleError);
                }
                return;
            }// end function
            );
            loader.load(request);
            overlayContainer.addChild(loader);
            return;
        }// end function

        public function authenticateWithArmorgames(param1:String, param2:String, param3:Function) : void
        {
            var armor_auth_token:* = param1;
            var armor_user_id:* = param2;
            var callback:* = param3;
            this.authenticateAsGuest(function (param1:Client) : void
            {
                var c:* = param1;
                client = c;
                Global.client = c;
                client.multiplayer.createJoinRoom(null, Config.server_type_authroom, false, {}, {}, function (param1:Connection) : void
                {
                    var con:* = param1;
                    con.addMessageHandler("auth", function (param1:Message, param2:String, param3:String) : void
                    {
                        var auid:String;
                        var m:* = param1;
                        var id:* = param2;
                        var aauth:* = param3;
                        if (id.length == 0 && aauth.length == 0)
                        {
                            handleFailedAuth(new PlayerIOError("Armor Games authorizatioon failed", 27667));
                            con.disconnect();
                        }
                        else
                        {
                            auid = id;
                            PlayerIO.connect(stage, Config.playerio_game_id, "secure", auid, aauth, Global.affiliate, function (param1:Client) : void
                        {
                            callback(param1);
                            return;
                        }// end function
                        , function (param1:PlayerIOError) : void
                        {
                            handleFailedAuth(param1);
                            con.disconnect();
                            return;
                        }// end function
                        );
                        }
                        return;
                    }// end function
                    );
                    con.send("auth", armor_user_id, armor_auth_token);
                    return;
                }// end function
                , handleError);
                return;
            }// end function
            );
            return;
        }// end function

        private function handleReturnToLobbyError(param1:PlayerIOError) : void
        {
            this.showLobby();
            return;
        }// end function

        private function handleFailedAuth(param1:PlayerIOError) : void
        {
            this.authenticateUser();
            return;
        }// end function

        private function authenticateUser() : void
        {
            var _loc_1:* = LoaderInfo(root.loaderInfo).parameters;
            var _loc_2:* = _loc_1.kongregate_api_path;
            if (Global.playing_on_kongregate && _loc_2)
            {
                this.authenticateWithKongregate(_loc_2);
            }
            else if (this.roomname != null && this.roomname != "")
            {
                this.authenticateAsGuest();
            }
            else
            {
                this.baseInit();
            }
            return;
        }// end function

        public function authenticateAsGuest(param1:Function = null) : void
        {
            var callback:* = param1;
            PlayerIO.quickConnect.simpleConnect(stage, Config.playerio_game_id, "guest", "guest", function (param1:Client) : void
            {
                if (Config.use_debug_server)
                {
                    param1.multiplayer.developmentServer = Config.developer_server;
                }
                Global.player_is_guest = true;
                if (callback != null)
                {
                    callback(param1);
                    return;
                }
                simpleConnect(param1);
                return;
            }// end function
            , this.handleError);
            return;
        }// end function

        private function baseInit() : void
        {
            setTimeout(function () : void
            {
                showMainLogin();
                return;
            }// end function
            , Config.run_in_development_mode ? (0) : (400));
            return;
        }// end function

        public function cleanCookie() : void
        {
            Global.cookie.data.access_token = "";
            Global.cookie.data.facebookuserid = "";
            Global.cookie.data.username = "";
            Global.cookie.data.password = "";
            Global.cookie.data.remember = false;
            Global.cookie.flush();
            return;
        }// end function

        public function logout() : void
        {
            Global.tracker.trackPageview("/logout");
            Bl.data.brick = 0;
            Bl.data.base = this;
            Bl.data.iskongregate = false;
            Bl.data.config = [0, 9, 10, 11, 16, 17, 18, 29, 32, 2, 100];
            Global.chatIsVisible = false;
            Global.player_is_beta_member = false;
            Bl.data.roomname = "";
            Bl.data.name = "";
            if (this.bp && this.bp.parent)
            {
                this.bp.parent.removeChild(this.bp);
            }
            this.cleanCookie();
            if (state && state is LobbyState)
            {
                LobbyState(state).reset();
            }
            var _loc_1:* = new LoadState();
            state = _loc_1;
            var _loc_2:String = null;
            this.client = null;
            Global.client = _loc_2;
            Testing.reset();
            Global.tracker.reConnectToService();
            Global.player_is_guest = true;
            this.disconnectRPC();
            this.baseInit();
            return;
        }// end function

        public function showMainLogin() : void
        {
            clearOverlayContainer();
            this.cleanUIAndConnections();
            this.mainlogin = new MainLogin();
            overlayContainer.addChild(this.mainlogin);
            return;
        }// end function

        public function showLoginWindow() : void
        {
            clearOverlayContainer();
            this.cleanUIAndConnections();
            this.loginwindow = new LoginWindow();
            overlayContainer.addChild(this.loginwindow);
            return;
        }// end function

        public function showKongregateLoginWindow() : void
        {
            this.kongregate.services.showSignInBox();
            return;
        }// end function

        private function handleLoginClose(event:MouseEvent) : void
        {
            this.lb.stopAll();
            this.lb.parent.removeChild(this.lb);
            this.authenticateAsGuest();
            return;
        }// end function

        private function hideLogin() : void
        {
            if (this.lb)
            {
                this.lb.stopAll();
                if (this.lb.parent)
                {
                    this.lb.parent.removeChild(this.lb);
                }
            }
            return;
        }// end function

        public function refresShop() : void
        {
            Shop.refresh(function () : void
            {
                return;
            }// end function
            );
            return;
        }// end function

        public function buyGemsWithKongregate(param1:int, param2:Function) : void
        {
            var count:* = param1;
            var callback:* = param2;
            this.kongregate.mtx.purchaseItems(["coins" + count], function (param1:Object) : void
            {
                var result:* = param1;
                setTimeout(function () : void
                {
                    Shop.refresh(callback(count));
                    return;
                }// end function
                , 1000);
                return;
            }// end function
            );
            return;
        }// end function

        public function buyGemsWithFacebook(param1:int, param2:Function) : void
        {
            var count:* = param1;
            var callback:* = param2;
            this.client.payVault.getBuyCoinsInfo("facebook", {coinamount:count, title:count + " Gems", description:"Buy " + count + " Energy for Everybdoy Edits", image_url:"http://cdn.playerio.com/everybody-edits-su9rn58o40itdbnw69plyw/Everybody%20Edits/img/ee100x100.png", product_url:"http://game.example.com/coins"}, function (param1:Object) : void
            {
                var info:* = param1;
                FB.ui(info, function (param1:Object) : void
                {
                    var fbdata:* = param1;
                    if (fbdata.order_id)
                    {
                        setTimeout(function () : void
                    {
                        Shop.refresh(callback(count));
                        return;
                    }// end function
                    , 1000);
                    }
                    else
                    {
                        Shop.refresh(callback(count));
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                return;
            }// end function
            );
            return;
        }// end function

        public function showRecoverPassword() : void
        {
            clearOverlayContainer();
            var r:* = new ResetPassword();
            overlayContainer.addChild(r);
            r.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            r.close.addEventListener(MouseEvent.CLICK, function () : void
            {
                showMainLogin();
                return;
            }// end function
            );
            return;
        }// end function

        public function showRegister() : void
        {
            var r:RegisterWindow;
            clearOverlayContainer();
            if (Global.playing_on_kongregate)
            {
                Global.base.showKongregateLoginWindow();
                return;
            }
            if (this.client == null)
            {
                this.authenticateAsGuest(function (param1:Client) : void
            {
                client = param1;
                showRegister();
                return;
            }// end function
            );
                return;
            }
            Global.tracker.trackPageview("/register");
            r = new RegisterWindow();
            r.name = "RegisterWindow";
            r.stop();
            r.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            overlayContainer.addChild(r);
            if (state is LobbyState)
            {
                r.x = (Global.width - r.width) / 2;
            }
            r.close.tabEnabled = false;
            r.close.addEventListener(MouseEvent.CLICK, function () : void
            {
                if (state is LobbyState)
                {
                    clearOverlayContainer();
                }
                else
                {
                    showMainLogin();
                }
                return;
            }// end function
            );
            if (Global.playing_on_playedonline)
            {
                r.registerbutton_facebook.visible = false;
                r.tf_fbheader.visible = false;
            }
            r.registerbutton_facebook.addEventListener(MouseEvent.CLICK, function () : void
            {
                r.registerbutton.mouseEnabled = false;
                r.registerbutton.enabled = false;
                setTimeout(function () : void
                {
                    r.registerbutton.mouseEnabled = true;
                    r.registerbutton.enabled = false;
                    return;
                }// end function
                , 1000);
                PlayerIO.quickConnect.facebookOAuthConnect(stage, Config.playerio_game_id, Global.cookie.data.access_token, Global.affiliate, simpleConnect, function (param1:PlayerIOError) : void
                {
                    fbconnect(true);
                    overlayContainer.removeChild(r);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            r.registerbutton.addEventListener(MouseEvent.CLICK, function () : void
            {
                r.bg_mail.gotoAndStop(1);
                r.bg_password.gotoAndStop(1);
                r.bg_password2.gotoAndStop(1);
                r.bg_name.gotoAndStop(1);
                r.errors.text = "";
                if (r.hasEmptyFields())
                {
                    r.errors.text = "All fields should be filled out";
                    return;
                }
                var validEmailRegExp:* = /([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})""([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})/;
                if (!validEmailRegExp.test(r.inpemail.text))
                {
                    r.bg_mail.gotoAndStop(2);
                    r.errors.text = "Not a proper email.";
                    return;
                }
                if (r.inppassword.text != r.inppassword2.text)
                {
                    r.bg_password.gotoAndStop(2);
                    r.bg_password2.gotoAndStop(2);
                    r.errors.text = "Passwords does not match";
                    return;
                }
                if (r.chosen_name == null)
                {
                    r.bg_name.gotoAndStop(2);
                    r.errors.text = "Please choose a screenname.";
                    return;
                }
                r.lock(true);
                r.registerbutton.visible = false;
                PlayerIO.quickConnect.simpleRegister(Bl.stage, Config.playerio_game_id, new Date().time + "x" + (Math.random() * 100 >> 0), r.inppassword.text, r.inpemail.text, "", "", Global.affiliate ? ({affiliate:Global.affiliate}) : ({}), Global.affiliate, function (param1:Client) : void
                {
                    var c:* = param1;
                    disconnectRPC();
                    client = c;
                    Global.player_is_guest = false;
                    if (Config.use_debug_server)
                    {
                        client.multiplayer.developmentServer = Config.developer_server;
                    }
                    var onNameSet:* = function () : void
                    {
                        forceShowToturial = true;
                        overlayContainer.removeChild(r);
                        cleanUIAndConnections();
                        Testing.isFirstLogin = true;
                        state = new LoadState();
                        simpleConnect(c);
                        Global.tracker.trackUserEvent("register", c.connectUserId);
                        Global.tracker.deleteGuestTracker();
                        return;
                    }// end function
                    ;
                    requestRemoteMethod("setUsername", onNameSet, r.chosen_name);
                    return;
                }// end function
                , function (param1:PlayerIORegistrationError) : void
                {
                    r.errors.text = "";
                    if (param1.usernameError != null)
                    {
                        r.errors.appendText(param1.usernameError + "\n");
                    }
                    if (param1.emailError != null)
                    {
                        r.errors.appendText(param1.emailError + "\n");
                        r.bg_mail.gotoAndStop(2);
                    }
                    if (param1.passwordError != null)
                    {
                        r.errors.appendText(param1.passwordError + "\n");
                        r.bg_password.gotoAndStop(2);
                        r.bg_password2.gotoAndStop(2);
                    }
                    r.registerbutton.visible = true;
                    r.lock(false);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function setError(param1:TextField, param2:Boolean) : void
        {
            var _loc_3:* = new TextFormat();
            _loc_3.color = param2 ? (16711680) : (16777215);
            param1.setTextFormat(_loc_3, -1, -1);
            return;
        }// end function

        private function makeHash(param1:String, param2:String) : String
        {
            var _loc_3:* = new Date();
            var _loc_4:* = Math.round(_loc_3.time * 0.001).toString();
            var _loc_5:* = Math.round(_loc_3.time * 0.001).toString() + ":" + param1;
            return _loc_4 + ":" + HMAC.hash(param2, _loc_5, SHA1);
        }// end function

        public function simpleConnect(param1:Client, param2:String = "") : void
        {
            var c:* = param1;
            var id:* = param2;
            clearOverlayContainer();
            this.loadAndInitPlayer(c, function () : void
            {
                if (forceShowToturial && !seenTutorial || c.connectUserId == "simpleguest" && !seenTutorial && !roomname)
                {
                    joinTutorialRoom(Config.server_type_tutorialroom + "1");
                }
                else if (roomname)
                {
                    setTimeout(function () : void
                {
                    LoadState(state).fadeOut(function () : void
                    {
                        joinRoom(roomname, true);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , Config.run_in_development_mode ? (0) : (500));
                }
                else
                {
                    showLobby(LoadState(state));
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function SystemSay(param1:String) : void
        {
            if (this.sidechat)
            {
                this.sidechat.addLine("* Warning", param1, 16777215);
            }
            return;
        }// end function

        public function showKongregatePayment() : void
        {
            var kongbox:BetaProgramInfoKong;
            LobbyState(state).reset();
            kongbox = new BetaProgramInfoKong();
            kongbox.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                if (kongbox.parent)
                {
                    kongbox.parent.removeChild(kongbox);
                }
                showLobby();
                return;
            }// end function
            );
            kongbox.buybtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                kongbox.buybtn.visible = false;
                kongregate.mtx.purchaseItems(["itempro"], function (param1:Object) : void
                {
                    if (param1.success)
                    {
                        if (kongbox.parent)
                        {
                            kongbox.parent.removeChild(kongbox);
                        }
                        Global.player_is_beta_member = true;
                        showLobby();
                    }
                    else
                    {
                        kongbox.buybtn.visible = true;
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            );
            overlayContainer.addChild(kongbox);
            return;
        }// end function

        private function handleFacebookAuthSuccess(param1:Client, param2:String, param3:String) : void
        {
            var c:* = param1;
            var access_token:* = param2;
            var facebookuserid:* = param3;
            clearOverlayContainer();
            Global.cookie.data.access_token = access_token;
            Global.cookie.data.facebookuserid = facebookuserid;
            Global.cookie.data.remember = true;
            Global.cookie.flush();
            this.loadAndInitPlayer(c, function () : void
            {
                if (roomname)
                {
                    setTimeout(function () : void
                {
                    LoadState(state).fadeOut(function () : void
                    {
                        joinRoom(roomname, true);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                , Config.run_in_development_mode ? (0) : (500));
                }
                else
                {
                    showLobby(LoadState(state));
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function migrateUsername(param1:SimplePlayerObject, param2:Client, param3:Function) : void
        {
            var o:* = param1;
            var c:* = param2;
            var callback:* = param3;
            this.getRPCConnection(function (param1:Connection) : void
            {
                var _loc_2:UsernameWindow = null;
                if (!o.name && c.connectUserId != "simpleguest")
                {
                    clearOverlayContainer();
                    _loc_2 = new UsernameWindow(callback);
                    overlayContainer.addChild(_loc_2);
                    return;
                }
                callback();
                return;
            }// end function
            , this.handleError);
            return;
        }// end function

        private function loadAndInitPlayer(param1:Client, param2:Function, param3:Boolean = true) : void
        {
            var c:* = param1;
            var callback:* = param2;
            var showlog:* = param3;
            if (showlog)
            {
                PlayerIO.showLogo(stage, "BC");
            }
            this.client = c;
            Shop.setBase(this, c);
            Global.client = c;
            if (Config.use_debug_server)
            {
                this.client.multiplayer.developmentServer = Config.developer_server;
            }
            if (c.connectUserId == "simpleguest")
            {
                Global.player_is_guest = true;
                Global.sharedCookie.data.guestvisit = (Global.sharedCookie.data.guestvisit || 0) + 1;
                Global.tracker.setGuestPrefix(Global.sharedCookie.data.guestvisit);
            }
            else
            {
                Global.player_is_guest = false;
                Global.sharedCookie.data.guestvisit = 0;
                Global.sharedCookie.data.hasLoggedIn = true;
            }
            Global.tracker.onPlayerInit(c.connectUserId);
            c.payVault.refresh(function () : void
            {
                updatePlayerProperties(function () : void
                {
                    migrateUsername(Global.playerObject, c, callback);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        public function fbconnect(param1:Boolean) : void
        {
            PlayerIO.quickConnect.facebookOAuthConnectPopup(stage, Config.playerio_game_id, "facebookpopup", param1 ? (["offline_access"]) : ([]), Global.affiliate || null, this.handleFacebookAuthSuccess, this.handleError);
            return;
        }// end function

        private function showLobby(param1:LoadState = null) : void
        {
            var self:EverybodyEdits;
            var lstate:* = param1;
            Global.setPath("Play Everybody Edits!", "/");
            this.cleanUIAndConnections();
            var _loc_3:* = lstate || new LoadState();
            lstate = lstate || new LoadState();
            state = _loc_3;
            if (this.upgrade)
            {
                return;
            }
            self;
            setTimeout(function () : void
            {
                var rooms1:Array;
                var rooms2:Array;
                var to_load:int;
                var ready:* = function () : void
                {
                    var allinvites:Array;
                    inviteid = Global.sharedCookie.data.inviteid ? (Global.sharedCookie.data.inviteid.split(",")[0]) : (null);
                    if (Global.sharedCookie.data.inviteid)
                    {
                        allinvites = Global.sharedCookie.data.inviteid.split(",");
                        inviteid = allinvites.pop();
                        Global.sharedCookie.data.inviteid = allinvites.length > 0 ? (allinvites.join(",")) : (null);
                        Global.sharedCookie.flush();
                    }
                    if (inviteid != null && inviteid != "")
                    {
                        requestRemoteMethod("activateInvite", function (param1:Message) : void
                    {
                        ready();
                        return;
                    }// end function
                    , inviteid);
                        return;
                    }
                    lstate.fadeOut(function () : void
                    {
                        state = new LobbyState(rooms1.concat(rooms2), joinRoom, createRoom, joinMyRoom, iseecom, self, handleJoinSaved);
                        return;
                    }// end function
                    );
                    return;
                }// end function
                ;
                rooms1;
                rooms2;
                var loaded:int;
                to_load;
                Shop.reset(function () : void
                {
                    if (++loaded == to_load)
                    {
                        ready();
                    }
                    return;
                }// end function
                );
                updatePlayerProperties(function () : void
                {
                    if (++loaded == to_load)
                    {
                        ready();
                    }
                    return;
                }// end function
                );
                return;
            }// end function
            , Config.run_in_development_mode ? (0) : (500));
            return;
        }// end function

        private function getBetaRooms(param1:Function) : void
        {
            if (Global.player_is_beta_member)
            {
                this.client.multiplayer.listRooms(Config.server_type_betaroom, {}, 0, 0, param1);
            }
            else
            {
                this.param1([]);
            }
            return;
        }// end function

        private function joinRoom(param1:String, param2:Boolean = false) : void
        {
            var rid:* = param1;
            var direct:* = param2;
            Global.tracker.trackPageview("/games/" + rid);
            state = new JoinState();
            if (rid.substring(0, 2) == "PW" || rid.substring(0, 2) == "BW" || rid == "ChrisWorld" || rid == "tutorialWorld")
            {
                this.joinSaved(rid);
            }
            else
            {
                this.client.multiplayer.joinRoom(rid, {}, function (param1:Connection) : void
            {
                handleJoin(param1, rid, direct);
                return;
            }// end function
            , this.handleReturnToLobbyError);
            }
            return;
        }// end function

        private function joinTutorialRoom(param1:String) : void
        {
            var id:* = param1;
            state = new JoinState();
            Global.tracker.trackPageview("/tutorial" + id);
            this.client.multiplayer.createJoinRoom("$service-room$", id, true, {}, {}, function (param1:Connection) : void
            {
                handleJoin(param1, id, true);
                return;
            }// end function
            , this.handleReturnToLobbyError);
            return;
        }// end function

        private function joinSaved(param1:String) : void
        {
            var roomid:* = param1;
            roomid = roomid.split(" ").join("-");
            this.client.multiplayer.createJoinRoom(roomid, roomid.substring(0, 2) == "BW" ? (Config.server_type_betaroom) : (Config.server_type_normalroom), true, {owned:"true"}, {}, function (param1:Connection) : void
            {
                handleJoin(param1, roomid, false, true);
                return;
            }// end function
            , this.handleReturnToLobbyError);
            return;
        }// end function

        private function handleJoinSaved(param1:int, param2:int) : void
        {
            var type:* = param1;
            var offset:* = param2;
            state = new JoinState();
            this.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler("r", function (param1:Message, param2:String) : void
                {
                    joinSaved(param2);
                    con.removeMessageHandler("r", arguments.callee);
                    return;
                }// end function
                );
                con.send("getSavedLevel", type, offset);
                return;
            }// end function
            , this.handleReturnToLobbyError);
            return;
        }// end function

        private function joinMyRoom(param1:Boolean = false) : void
        {
            var isbetaroom:* = param1;
            if (!Global.player_is_beta_member)
            {
                return;
            }
            state = new JoinState();
            this.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler("r", function (param1:Message, param2:String) : void
                {
                    joinSaved(param2);
                    con.removeMessageHandler("r", arguments.callee);
                    return;
                }// end function
                );
                con.send(isbetaroom ? ("getBetaRoom") : ("getRoom"));
                return;
            }// end function
            , this.handleReturnToLobbyError);
            return;
        }// end function

        private function handleJoin(param1:Connection, param2:String, param3:Boolean = false, param4:Boolean = false) : void
        {
            var self:EverybodyEdits;
            var connection:* = param1;
            var roomid:* = param2;
            var direct:* = param3;
            var isLockedRoom:* = param4;
            Global.roomid = roomid;
            this.seenTutorial = true;
            Global.sharedCookie.data.toturial = true;
            Global.sharedCookie.flush();
            if (Bl.data.isbeta || Bl.data.onsite || Bl.stage.stageWidth > 700)
            {
                this.sidechat = new SideChat(connection);
                this.sidechat.x = 640 - 1;
            }
            this.deltas = [];
            this.inited = false;
            self;
            this.connection = connection;
            connection.addMessageHandler("upgrade", function () : void
            {
                var _loc_1:* = new Upgrade();
                overlayContainer.addChild(_loc_1);
                upgrade = true;
                return;
            }// end function
            );
            connection.addMessageHandler("info", function (param1:Message, param2:String, param3:String) : void
            {
                showInfo(param2, param3);
                return;
            }// end function
            );
            connection.addMessageHandler("init", function (param1:Message, param2:String, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int, param9:String, param10:Boolean, param11:Boolean, param12:int, param13:int, param14:Boolean, param15:Number, param16:Boolean) : void
            {
                if (sidechat)
                {
                    sidechat.setMe(param6.toString(), param9, Global.canchat);
                    sidechat.setMetaData(param2, param3, parseInt(param4));
                }
                Bl.data.m = derot(param5);
                Bl.data.isLockedRoom = isLockedRoom || !param10 || param11;
                Bl.data.owner = param11;
                Global.hasOwner = param2 != "";
                Global.currentLevelname = param3;
                state = new PlayState(connection, param1, param6, param9, param7, param8, param12, param13, param14, param15);
                Bl.data.canEdit = param10;
                ui2instance = new UI2(self, connection, param1, param6, param10, roomid, sidechat, param14, param16);
                ui2instance.y = 500;
                overlayContainer.addChild(ui2instance);
                if (sidechat)
                {
                    overlayContainer.addChild(sidechat);
                }
                Global.tracker.trackUserEvent("joinroom", param10, param11, roomid);
                GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"EnterWorld:" + (param11 ? ("Own") : (param10 ? ("Open") : ("Locked")))});
                return;
            }// end function
            );
            connection.addDisconnectHandler(function () : void
            {
                showLobby();
                if (ui2instance && ui2instance.parent)
                {
                    overlayContainer.removeChild(ui2instance);
                }
                if (sidechat && sidechat.parent)
                {
                    overlayContainer.removeChild(sidechat);
                }
                return;
            }// end function
            );
            this.inited = true;
            connection.send("init");
            return;
        }// end function

        public function showPrompt(param1:Prompt) : void
        {
            overlayContainer.addChild(param1);
            return;
        }// end function

        public function showLevelComplete(param1:LevelComplete) : void
        {
            if (overlayContainer.getChildByName("LevelCompleteScreen"))
            {
                return;
            }
            GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"World:Complete"});
            Global.tracker.trackUserEvent("roomcomplete");
            overlayContainer.addChild(param1);
            return;
        }// end function

        public function showUi() : void
        {
            if (this.ui2instance != null)
            {
                this.ui2instance.configureInterface();
            }
            return;
        }// end function

        public function hideUi() : void
        {
            if (this.ui2instance != null)
            {
                this.ui2instance.configureInterface();
            }
            return;
        }// end function

        public function awardSwappits() : void
        {
            if (new Date().getTime() - this.swapittimer.data.lastCoin < 1000 * 60 * 60 * 1)
            {
                return;
            }
            this.swapittimer.data.lastCoin = this.swapittimer.data.lastCoin || 0;
            this.swapittimer.data.lastCoin = new Date().getTime();
            this.swapittimer.flush();
            if (!Bl.data.isswappit)
            {
                return;
            }
            var req:* = new URLRequest("http://playerio.com/clientintegrations/swapits/award");
            req.method = URLRequestMethod.GET;
            var vars:* = new URLVariables();
            vars.username = Bl.data.swappitusername;
            vars.swapits = 10;
            vars.reason = "You earned 10 swapits for finding a swapit coin in Everybody Edits!";
            req.data = vars;
            var loader:* = new URLLoader();
            loader.addEventListener(Event.COMPLETE, function () : void
            {
                showInfo("Congratulations", "You just found an Everybody Edits swapit coin and earned 10 swapits!");
                return;
            }// end function
            );
            loader.load(req);
            return;
        }// end function

        public function showInfo(param1:String, param2:String, param3:int = 0) : void
        {
            var inf:InfoBox;
            var title:* = param1;
            var body:* = param2;
            var smiley:* = param3;
            inf = new InfoBox();
            inf.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            inf.ttitle.text = title;
            inf.tbody.autoSize = TextFieldAutoSize.LEFT;
            inf.tbody.text = body;
            inf.bg.height = inf.tbody.y - inf.bg.y + inf.tbody.height + 40;
            inf.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                overlayContainer.removeChild(inf);
                return;
            }// end function
            );
            overlayContainer.addChild(inf);
            return;
        }// end function

        private function derot(param1:String) : String
        {
            var _loc_4:int = 0;
            var _loc_2:String = "";
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1.charCodeAt(_loc_3);
                if (_loc_4 >= "a".charCodeAt(0) && _loc_4 <= "z".charCodeAt(0))
                {
                    if (_loc_4 > "m".charCodeAt(0))
                    {
                        _loc_4 = _loc_4 - 13;
                    }
                    else
                    {
                        _loc_4 = _loc_4 + 13;
                    }
                }
                else if (_loc_4 >= "A".charCodeAt(0) && _loc_4 <= "Z".charCodeAt(0))
                {
                    if (_loc_4 > "M".charCodeAt(0))
                    {
                        _loc_4 = _loc_4 - 13;
                    }
                    else
                    {
                        _loc_4 = _loc_4 + 13;
                    }
                }
                _loc_2 = _loc_2 + String.fromCharCode(_loc_4);
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function createRoom(param1:String, param2:String = "", param3:Boolean = false) : void
        {
            var roomid:String;
            var rid:* = param1;
            var editkey:* = param2;
            var istutorial:* = param3;
            if (istutorial)
            {
                state = new JoinState();
                this.joinTutorialRoom(rid);
                return;
            }
            Bl.data.roomname = rid;
            state = new JoinState();
            roomid = "OW" + this.generateUniqueRoomId(rid);
            this.client.multiplayer.createJoinRoom(roomid, Config.server_type_normalroom, true, editkey == "" ? ({name:rid}) : ({editkey:editkey, name:rid}), editkey == "" ? ({}) : ({editkey:editkey}), function (param1:Connection) : void
            {
                handleJoin(param1, roomid, false, editkey != "");
                return;
            }// end function
            , this.handleReturnToLobbyError);
            return;
        }// end function

        private function generateUniqueRoomId(param1:String) : String
        {
            return ((Math.random() * 1000 >> 0) + new Date().getMilliseconds()).toString(36) + " " + param1;
        }// end function

        private function handleError(param1:Object) : void
        {
            var _loc_2:* = param1.hasOwnProperty("message") ? (param1.message) : (param1.hasOwnProperty("text") ? (param1.text) : (param1.toString()));
            Global.tracker.trackEvent("Error", "General", _loc_2);
            return;
        }// end function

        private function showBuyBetaMembershipOverlay(param1:Function) : void
        {
            var that:EverybodyEdits;
            var callback:* = param1;
            that;
            this.client.payVault.getBuyCoinsInfo("superrewards", {}, function (param1:Object) : void
            {
                var info:* = param1;
                hideLogin();
                var _loc_3:Boolean = true;
                bp.buywithcoinsbtn.visible = true;
                bp.earnnowbtn.visible = _loc_3;
                if (client.payVault.coins >= 100)
                {
                    bp.cointext.text = "Success!!";
                    bp.earnnowbtn.visible = false;
                }
                else
                {
                    bp.cointext.text = "You need " + (100 - client.payVault.coins) + " Gems";
                    bp.buywithcoinsbtn.visible = false;
                    setTimeout(function () : void
                {
                    var t:Number;
                    bp.cointext.text = "Refreshing, please wait...";
                    t = setTimeout(function () : void
                    {
                        if (!bp.parent)
                        {
                            clearTimeout(t);
                            return;
                        }
                        loadAndInitPlayer(client, callback, false);
                        return;
                    }// end function
                    , 1000);
                    return;
                }// end function
                , 10000);
                }
                if (!bp.parent)
                {
                    bp.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
                {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                    event.stopPropagation();
                    return;
                }// end function
                );
                    bp.buybtn.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
                {
                    var e:* = event;
                    var paypalargs:Object;
                    paypalargs["return"] = "http://beta.everybodyedits.com/welcometobeta";
                    client.payVault.getBuyDirectInfo("paypal", paypalargs, [{itemKey:"pro"}], function (param1:Object) : void
                    {
                        navigateToURL(new URLRequest(param1.paypalurl), "_self");
                        return;
                    }// end function
                    , function (param1:PlayerIOError) : void
                    {
                        return;
                    }// end function
                    );
                    bp.buybtn.visible = false;
                    return;
                }// end function
                );
                    bp.buywithcoinsbtn.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
                {
                    bp.buywithcoinsbtn.visible = false;
                    client.payVault.buy([{itemKey:"pro"}], true, function () : void
                    {
                        if (bp.parent)
                        {
                            bp.parent.removeChild(bp);
                        }
                        callback();
                        return;
                    }// end function
                    );
                    return;
                }// end function
                );
                    bp.earnnowbtn.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
                {
                    Shop.getMoreGems();
                    return;
                }// end function
                );
                }
                overlayContainer.addChild(bp);
                var loginbox:* = new LobbyLoginBox(that);
                loginbox.ShowLogout();
                loginbox.y = 420 + 60 - 5;
                overlayContainer.addChild(loginbox);
                Shop.doFocus();
                return;
            }// end function
            );
            return;
        }// end function

    }
}
