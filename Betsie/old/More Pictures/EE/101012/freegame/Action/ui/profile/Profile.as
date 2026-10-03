package ui.profile
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import items.*;
    import playerio.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class Profile extends Sprite
    {
        private var mode:String;
        private var base:Box;
        private var content:Box;
        private var player_items:Rows;
        private var player_levels:Rows;
        private var smilies:FillBox;
        private var blocks:FillBox;
        private var worlds:FillBox;
        private var close_button:ProfileCloseButton;
        private var username:String;
        private var isOldBetaMember:Boolean = false;
        private var rooms:Array;
        private var worldlist:Array;
        public static var MODE_STANDALONE:String = "standalone";
        public static var MODE_INGAME:String = "ingame";

        public function Profile(param1:String, param2:String = "")
        {
            var username:* = param1;
            var mode:* = param2;
            this.base = new Box();
            this.content = new Box();
            this.player_items = new Rows();
            this.player_levels = new Rows();
            this.smilies = new FillBox(0);
            this.blocks = new FillBox(2);
            this.worlds = new FillBox(2);
            this.rooms = [];
            this.worldlist = [];
            if (mode == "")
            {
                mode = MODE_STANDALONE;
            }
            this.mode = mode;
            this.username = username;
            this.base.margin(10, 0, 0, 0);
            this.base.add(new Box().fill(2236962, 1, 10).margin(5, 5, 5, 5).add(this.content));
            this.content.margin(0, 0, 0, 0);
            this.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.base.filters = [new GlowFilter(0, 1, 20, 20, 2)];
            if (mode != MODE_INGAME)
            {
                PlayerIO.quickConnect.simpleConnect(Global.stage, Config.playerio_game_id, "guest", "guest", this.handleConnectedToService, this.handleError);
            }
            else
            {
                this.handleConnectedToService(Global.client);
            }
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            return;
        }// end function

        private function handleConnectedToService(param1:Client) : void
        {
            var c:* = param1;
            c.bigDB.load("Usernames", this.username, function (param1:DatabaseObject) : void
            {
                var oo:* = param1;
                if (oo == null || !oo.owner)
                {
                    content.addChild(new Box().add(new Label("User not found", 20, "center", 16777215, false, "system")));
                    var _loc_3:* = base;
                    var _loc_4:* = base.height + 1;
                    _loc_3.height = _loc_4;
                    handleResize();
                    return;
                }
                c.bigDB.load("PlayerObjects", oo.owner, function (param1:DatabaseObject) : void
                {
                    var _loc_5:String = null;
                    var _loc_6:ProfileCloseButton = null;
                    var _loc_7:Box = null;
                    var _loc_8:Label = null;
                    var _loc_9:Box = null;
                    if (mode == MODE_INGAME)
                    {
                        _loc_6 = new ProfileCloseButton();
                        _loc_6.addEventListener(MouseEvent.MOUSE_DOWN, handleCloseProfile, false, 0, true);
                        _loc_7 = new Box().margin(4, 4, NaN, NaN).add(_loc_6);
                        content.add(_loc_7);
                    }
                    if (param1 == null || param1.banned)
                    {
                        content.addChild(new Box().add(new Label("User not found", 20, "center", 16777215, false, "system")));
                        var _loc_10:* = base;
                        var _loc_11:* = base.height + 1;
                        _loc_10.height = _loc_11;
                        handleResize();
                        return;
                    }
                    if (param1.visible === false)
                    {
                        content.addChild(new Box().add(new Label("Profile is private", 20, "center", 16777215, false, "system")));
                        var _loc_10:* = base;
                        var _loc_11:* = base.height + 1;
                        _loc_10.height = _loc_11;
                        handleResize();
                        return;
                    }
                    player_levels.spacing(0);
                    content.add(new Box().margin(50, 0, 0, 350).add(new Box().fill(0, 1, 10).margin(3, 3, 3, 3).add(new ScrollBox().margin(0, 0, 0, 0).add(new Box().margin(0, 0, 0, 2).add(player_levels)))));
                    player_levels.addChild(new Label("Levels by " + username.toUpperCase() + ", Click to play", 15, "left", 16777215, false, "system"));
                    player_levels.addChild(worlds);
                    worlds.forceScale = true;
                    content.add(new Box().margin(50, NaN, 0, 0).add(new Box().minSize(350 - 5, 0).margin(3, 3, 3, 3).fill(0, 1, 10).add(new ScrollBox().margin(0, 0, 0, 0).add(new Box().margin(0, 0, 0, 2).add(player_items)))));
                    player_items.spacing(1);
                    player_items.addChild(new Label("Smilies", 15, "left", 16777215, false, "system"));
                    player_items.addChild(smilies);
                    player_items.addChild(new Label("Blocks", 15, "left", 16777215, false, "system"));
                    player_items.addChild(blocks);
                    var _loc_2:* = new Label(username.toUpperCase(), 40, "left", param1.isModerator ? (16759552) : (16777215), false, "system");
                    content.add(_loc_2);
                    var _loc_3:* = new Box().margin(4, NaN, NaN, _loc_2.textWidth + 10);
                    var _loc_4:* = new Label("Max Energy: " + (param1.maxEnergy ? (param1.maxEnergy) : ("200")), 12, "left", 16777215, false, "system");
                    _loc_3.add(_loc_4);
                    content.add(_loc_3);
                    if (mode == MODE_INGAME)
                    {
                        _loc_8 = new Label("", 10, "left", 16777215, false, "system");
                        _loc_8.htmlText = "<u>Show on homepage</u>";
                        _loc_8.mouseEnabled = false;
                        _loc_9 = new Box().margin(_loc_7.height + 4, 0, NaN, NaN).add(_loc_8);
                        _loc_9.mouseEnabled = true;
                        _loc_9.buttonMode = true;
                        _loc_9.addEventListener(MouseEvent.MOUSE_DOWN, handleShowProfilePage, false, 0, true);
                        content.add(_loc_9);
                    }
                    if (param1.isModerator)
                    {
                        content.add(new Box().margin(24, NaN, NaN, _loc_2.textWidth + 10).add(new Label("Everybody Edits Moderator!", 12, "left", 16759552, false, "system")));
                    }
                    isOldBetaMember = param1.haveSmileyPackage ? (true) : (false);
                    PlayerIO.connect(Global.stage, Config.playerio_game_id, "Public", param1.key, "", "", handleLoadComplete, handleError);
                    if (param1.room0)
                    {
                        rooms.push(param1.room0);
                    }
                    if (param1.betaonlyroom)
                    {
                        rooms.push(param1.betaonlyroom);
                    }
                    for (_loc_5 in param1)
                    {
                        
                        if (_loc_5.indexOf("world") == 0)
                        {
                            rooms.push(param1[_loc_5]);
                        }
                    }
                    loadNextLevel(c);
                    return;
                }// end function
                , handleError);
                addChild(base);
                return;
            }// end function
            , this.handleError);
            return;
        }// end function

        protected function handleShowProfilePage(event:MouseEvent) : void
        {
            navigateToURL(new URLRequest("http://everybodyedits.com/profiles/?/" + this.username), "_blank");
            return;
        }// end function

        protected function handleCloseProfile(event:MouseEvent) : void
        {
            parent.removeChild(this);
            return;
        }// end function

        private function loadNextLevel(param1:Client) : void
        {
            var c:* = param1;
            if (this.rooms.length == 0)
            {
                return;
            }
            var toload:* = this.rooms.pop();
            if (toload == "")
            {
                this.loadNextLevel(c);
                return;
            }
            c.bigDB.load("Worlds", toload, function (param1:DatabaseObject) : void
            {
                renderWorld(param1);
                loadNextLevel(c);
                return;
            }// end function
            , this.handleError);
            return;
        }// end function

        private function renderWorld(param1:DatabaseObject) : void
        {
            if (param1 == null || param1.worlddata == null)
            {
                return;
            }
            if (param1.name != Chat.filter(param1.name))
            {
                return;
            }
            if (!param1.width || !param1.height)
            {
                return;
            }
            if (param1.hasOwnProperty("visible") && !param1["visible"])
            {
                return;
            }
            var _loc_2:* = new ProfileWorld(param1);
            _loc_2.addEventListener(MouseEvent.CLICK, this.handleWorldClicked, false, 0, true);
            this.worldlist.push(_loc_2);
            this.worldlist.sortOn(["plays"], Array.NUMERIC | Array.DESCENDING);
            var _loc_3:int = 0;
            while (_loc_3 < this.worldlist.length)
            {
                
                this.worlds.addChild(this.worldlist[_loc_3]);
                _loc_3++;
            }
            var _loc_4:* = this.base;
            var _loc_5:* = this.base.height + 1;
            _loc_4.height = _loc_5;
            this.handleResize();
            return;
        }// end function

        private function handleWorldClicked(event:MouseEvent) : void
        {
            var _loc_3:NavigationEvent = null;
            var _loc_2:* = event.target as ProfileWorld;
            if (this.mode == MODE_STANDALONE)
            {
                navigateToURL(new URLRequest("http://everybodyedits.com/games/" + _loc_2.key), "_top");
            }
            else
            {
                _loc_3 = new NavigationEvent(NavigationEvent.JOIN_WORLD, true, false);
                _loc_3.world_author = this.username;
                _loc_3.world_id = _loc_2.key;
                dispatchEvent(_loc_3);
                parent.removeChild(this);
            }
            return;
        }// end function

        private function handleLoadComplete(param1:Client) : void
        {
            var c:* = param1;
            c.payVault.refresh(function () : void
            {
                renderItems(c);
                return;
            }// end function
            , this.handleError);
            return;
        }// end function

        private function renderItems(param1:Client) : void
        {
            var _loc_5:ItemSmiley = null;
            var _loc_6:ItemBrickPackage = null;
            var _loc_7:Vector.<ItemBrick> = null;
            var _loc_8:int = 0;
            var _loc_9:ItemBrick = null;
            var _loc_10:int = 0;
            var _loc_2:* = ItemManager.smilies;
            var _loc_3:int = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_5 = _loc_2[_loc_3];
                if (_loc_5.payvaultid == "" || param1.payVault.has(_loc_5.payvaultid) || _loc_5.payvaultid == "pro" && this.isOldBetaMember)
                {
                    this.smilies.addChild(new ProfileSmiley(_loc_5));
                }
                _loc_3++;
            }
            var _loc_4:* = ItemManager.brickPackages;
            _loc_3 = 0;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_3];
                _loc_7 = new Vector.<ItemBrick>;
                _loc_8 = 0;
                while (_loc_8 < _loc_6.bricks.length)
                {
                    
                    _loc_9 = _loc_6.bricks[_loc_8];
                    if (!_loc_9.requiresAdmin)
                    {
                        if (_loc_9.payvaultid == "" || param1.payVault.has(_loc_9.payvaultid) || _loc_9.payvaultid == "pro" && this.isOldBetaMember)
                        {
                            _loc_10 = 0;
                            while (_loc_10 < (param1.payVault.count(_loc_9.payvaultid) || 1))
                            {
                                
                                _loc_7.push(_loc_9);
                                if (_loc_9.payvaultid != "brickdiamond")
                                {
                                    break;
                                }
                                _loc_10++;
                            }
                        }
                    }
                    _loc_8++;
                }
                if (_loc_7.length)
                {
                    this.blocks.addChild(new ProfileBrickPackage(_loc_6, _loc_7));
                }
                _loc_3++;
            }
            var _loc_11:* = this.player_items;
            var _loc_12:* = this.player_items.width + 1;
            _loc_11.width = _loc_12;
            var _loc_11:* = this.base;
            var _loc_12:* = this.base.height + 1;
            _loc_11.height = _loc_12;
            this.handleResize();
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            stage.addEventListener(Event.RESIZE, this.handleResize);
            this.handleResize();
            return;
        }// end function

        private function handleRemove(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            stage.removeEventListener(Event.RESIZE, this.handleResize);
            return;
        }// end function

        private function handleError(param1:Error) : void
        {
            return;
        }// end function

        private function handleResize(event:Event = null) : void
        {
            if (stage != null)
            {
                this.base.x = 0;
                this.base.y = 0;
                this.base.width = Global.width - 20;
                this.base.height = Global.height - 20;
            }
            return;
        }// end function

    }
}
