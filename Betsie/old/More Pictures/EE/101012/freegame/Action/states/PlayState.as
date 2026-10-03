package states
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import items.*;
    import playerio.*;
    import ui.*;

    public class PlayState extends BlState
    {
        protected var player:Player;
        protected var world:World;
        protected var connection:Connection;
        protected var players:Object;
        protected var minimap:MiniMap;
        protected var totalCoins:int = 0;
        protected var bonusCoins:int = 0;
        protected var gravityMultiplier:Number = 1;
        protected var cointext:BlText;
        protected var cointextcontainer:BlContainer;
        protected var bcointext:BlText;
        protected var bcointextcontainer:BlContainer;
        protected var rw:int = 0;
        protected var rh:int = 0;
        protected var eraserLayerLock:int;
        protected var isTutorialRoom:Boolean = false;
        private var queue:Array;
        private var tilequeue:Array;
        private var inEditArea:Boolean = false;
        private var showCoinGate:uint = 0;
        private var pastX:uint = 0;
        private var pastY:uint = 0;
        private var pastT:Number;
        private var chatTime:Number;

        public function PlayState(param1:Connection, param2:Message, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int, param9:Boolean, param10:Number)
        {
            var s:PlayState;
            var shadowDebug:Boolean;
            var c:* = param1;
            var m:* = param2;
            var myid:* = param3;
            var name:* = param4;
            var x:* = param5;
            var y:* = param6;
            var rw:* = param7;
            var rh:* = param8;
            var isTutorialRoom:* = param9;
            var gravityMultiplier:* = param10;
            this.players = {};
            this.cointextcontainer = new BlContainer();
            this.bcointextcontainer = new BlContainer();
            this.queue = [];
            this.tilequeue = [];
            this.pastT = new Date().time;
            this.chatTime = new Date().time;
            this.isTutorialRoom = isTutorialRoom;
            this.rw = width;
            this.rh = height;
            this.connection = c;
            this.gravityMultiplier = gravityMultiplier;
            this.world = new World();
            this.world.deserializeFromMessage(rw, rh, m);
            add(this.world);
            this.totalCoins = this.world.getTypeCount(100);
            this.bonusCoins = this.world.getTypeCount(101);
            this.player = new Player(this.world, name, true, c, this);
            this.player.gravityMultiplier = gravityMultiplier;
            this.player.x = x;
            this.player.y = y;
            this.x = -x;
            this.y = -y;
            add(this.player);
            this.world.setPlayer(this.player);
            target = this.player;
            this.player.hitmap = this.world;
            this.minimap = new MiniMap(this.world, rw, rh);
            this.cointext = new BlText(12, 100, 16777215, "right");
            this.cointext.x = 526;
            this.cointextcontainer.add(this.cointext);
            this.bcointext = new BlText(12, 100, 16777215, "right");
            this.bcointext.x = 526;
            this.bcointextcontainer.add(this.bcointext);
            var tcoin:* = BlSprite.createFromBitmapData(ItemManager.getBrickPackageByName("coins").bricks[0].bmd);
            tcoin.x = 626 - 2;
            tcoin.y = 4 - 3;
            this.cointextcontainer.add(tcoin);
            var btcoin:* = BlSprite.createFromBitmapData(ItemManager.getBrickPackageByName("coins").bricks[1].bmd);
            btcoin.x = 626 - 2;
            btcoin.y = 4 - 3;
            this.bcointextcontainer.add(btcoin);
            s;
            shadowDebug = Config.enableDebugShadow;
            this.connection.addMessageHandler("m", function (param1:Message, param2:int, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:int) : void
            {
                var _loc_12:Player = null;
                if (param2 != myid || shadowDebug)
                {
                    _loc_12 = players[param2] as Player;
                    if (!_loc_12 && shadowDebug)
                    {
                        _loc_12 = new Player(world, "shadow", false, connection, s);
                        players[param2] = _loc_12;
                        addBefore(_loc_12, player);
                    }
                    if (_loc_12)
                    {
                        _loc_12.x = param3;
                        _loc_12.y = param4;
                        _loc_12.speedX = param5;
                        _loc_12.speedY = param6;
                        _loc_12.modifierX = param7;
                        _loc_12.modifierY = param8;
                        _loc_12.horizontal = param9;
                        _loc_12.vertical = param10;
                        _loc_12.coins = param11;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("add", function (param1:Message, param2:int, param3:String, param4:int, param5:Number, param6:Number, param7:Boolean, param8:Boolean, param9:Boolean, param10:int, param11:Boolean) : void
            {
                var _loc_13:Boolean = false;
                var _loc_14:Number = NaN;
                var _loc_12:* = players[param2] as Player;
                if (!(players[param2] as Player))
                {
                    _loc_12 = new Player(world, param3);
                    players[param2] = _loc_12;
                    _loc_12.isgod = param7;
                    _loc_12.ismod = param8;
                    _loc_12.gravityMultiplier = gravityMultiplier;
                    _loc_12.x = Math.min(param5, (rw - 2) * 16);
                    _loc_12.y = Math.min(param6, (rh - 2) * 16);
                    _loc_12.frame = param4;
                    _loc_12.coins = param10;
                    _loc_13 = param3.indexOf("-") != -1;
                    _loc_14 = 13421772;
                    if (!param9)
                    {
                        _loc_14 = 11184810;
                    }
                    if (_loc_13)
                    {
                        _loc_14 = 6710886;
                    }
                    if (param11)
                    {
                        _loc_14 = Config.friend_color;
                    }
                    if (Player.isAdmin(param3))
                    {
                        _loc_14 = Config.admin_color;
                    }
                    _loc_12.nameColor = _loc_14;
                    addBefore(_loc_12, player);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("k", function (param1:Message, param2:int) : void
            {
                var _loc_3:String = null;
                var _loc_4:Player = null;
                player.hascrown = param2 == myid;
                for (_loc_3 in players)
                {
                    
                    _loc_4 = players[_loc_3] as Player;
                    _loc_4.hascrown = parseInt(_loc_3) == param2;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("ks", function (param1:Message, param2:int) : void
            {
                var _loc_3:String = null;
                var _loc_4:Player = null;
                if (!player.hascrownsilver)
                {
                    player.hascrownsilver = param2 == myid;
                }
                for (_loc_3 in players)
                {
                    
                    _loc_4 = players[_loc_3] as Player;
                    if (!_loc_4.hascrownsilver)
                    {
                        _loc_4.hascrownsilver = parseInt(_loc_3) == param2;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("c", function (param1:Message, param2:String, param3:int) : void
            {
                var _loc_4:* = players[param2];
                if (players[param2] != null)
                {
                    _loc_4.coins = param3;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("p", function (param1:Message, param2:int, param3:int, param4:Boolean) : void
            {
                var _loc_5:* = players[param2];
                if (param2 == myid)
                {
                    _loc_5 = player;
                }
                if (_loc_5 != null)
                {
                    handlePotion(_loc_5, param3, param4);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("b", function (param1:Message, param2:int, param3:int, param4:int, param5:int) : void
            {
                setTile(param2, param3, param4, param5, {});
                return;
            }// end function
            );
            this.connection.addMessageHandler("bc", function (param1:Message, param2:int, param3:int, param4:int, param5:int) : void
            {
                setTile(0, param2, param3, param4, {goal:param5});
                return;
            }// end function
            );
            this.connection.addMessageHandler("pt", function (param1:Message, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
            {
                setTile(0, param2, param3, param4, {rotation:param5, id:param6, target:param7});
                return;
            }// end function
            );
            this.connection.addMessageHandler("lb", function (param1:Message, param2:int, param3:int, param4:int, param5:String) : void
            {
                setTile(0, param2, param3, param4, {text:param5});
                return;
            }// end function
            );
            this.connection.addMessageHandler("bs", function (param1:Message, param2:int, param3:int, param4:int, param5:int) : void
            {
                setTile(0, param2, param3, param4, {sound:param5});
                return;
            }// end function
            );
            this.connection.addMessageHandler("left", function (param1:Message, param2:int) : void
            {
                var _loc_3:* = players[param2];
                if (_loc_3 != null)
                {
                    delete players[param2];
                    remove(_loc_3);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("god", function (param1:Message, param2:int, param3:Boolean) : void
            {
                if (param2 == myid)
                {
                    player.isgod = param3;
                    world.setShowAllSecrets(param3);
                }
                var _loc_4:* = players[param2];
                if (players[param2] != null)
                {
                    _loc_4.isgod = param3;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("lostaccess", function (param1:Message) : void
            {
                var _loc_2:Player = null;
                if (!Bl.data.owner)
                {
                    player.isgod = false;
                }
                for each (_loc_2 in players)
                {
                    
                    _loc_2.isgod = false;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("mod", function (param1:Message, param2:int) : void
            {
                if (param2 == myid)
                {
                    player.ismod = true;
                }
                var _loc_3:* = players[param2];
                if (_loc_3 != null)
                {
                    _loc_3.ismod = true;
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("say", function (param1:Message, param2:int, param3:String, param4:Boolean) : void
            {
                if (param2 == myid)
                {
                    player.say(param3);
                }
                var _loc_5:* = players[param2];
                if (players[param2] != null)
                {
                    _loc_5.say(param3);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("autotext", function (param1:Message, param2:int, param3:String) : void
            {
                if (param2 == myid)
                {
                    player.say(param3);
                }
                var _loc_4:* = players[param2];
                if (players[param2] != null)
                {
                    _loc_4.say(param3);
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("face", function (param1:Message, param2:int, param3:int) : void
            {
                var _loc_4:Player = null;
                if (param2 == myid)
                {
                    player.frame = param3;
                }
                else
                {
                    _loc_4 = players[param2] as Player;
                    if (_loc_4)
                    {
                        _loc_4.frame = param3;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("hide", function (param1:Message, param2:String) : void
            {
                switch(param2)
                {
                    case "red":
                    {
                        showRed();
                        ;
                    }
                    case "green":
                    {
                        showGreen();
                        ;
                    }
                    case "blue":
                    {
                        showBlue();
                        ;
                    }
                    case "timedoor":
                    {
                        showTimedoor();
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("show", function (param1:Message, param2:String) : void
            {
                switch(param2)
                {
                    case "red":
                    {
                        hideRed();
                        ;
                    }
                    case "green":
                    {
                        hideGreen();
                        ;
                    }
                    case "blue":
                    {
                        hideBlue();
                        ;
                    }
                    case "timedoor":
                    {
                        hideTimedoor();
                        ;
                    }
                    default:
                    {
                        ;
                    }
                }
                return;
            }// end function
            );
            this.connection.addMessageHandler("reset", function (param1:Message) : void
            {
                var _loc_2:* = world.deserializeFromMessage(rw, rh, param1);
                world.setMapArray(_loc_2);
                world.resetSecrets();
                minimap.reset(world);
                _loc_2 = [];
                player.coins = 0;
                player.bcoins = 0;
                totalCoins = world.getTypeCount(100);
                bonusCoins = world.getTypeCount(101);
                return;
            }// end function
            );
            this.connection.addMessageHandler("clear", function (param1:Message, param2:int, param3:int, param4:int = 9, param5:int = 0) : void
            {
                var _loc_8:int = 0;
                var _loc_9:int = 0;
                var _loc_6:Array = [];
                var _loc_7:int = 0;
                while (_loc_7 < 2)
                {
                    
                    _loc_6[_loc_7] = [];
                    _loc_8 = 0;
                    while (_loc_8 < param3)
                    {
                        
                        _loc_6[_loc_7][_loc_8] = [];
                        _loc_9 = 0;
                        while (_loc_9 < param2)
                        {
                            
                            _loc_6[_loc_7][_loc_8][_loc_9] = param5;
                            _loc_9++;
                        }
                        _loc_8++;
                    }
                    _loc_7++;
                }
                _loc_8 = 0;
                while (_loc_8 < rh)
                {
                    
                    _loc_6[0][_loc_8][0] = param4;
                    _loc_6[0][_loc_8][(rw - 1)] = param4;
                    _loc_8++;
                }
                _loc_8 = 0;
                while (_loc_8 < rw)
                {
                    
                    _loc_6[0][0][_loc_8] = param4;
                    _loc_6[0][(rh - 1)][_loc_8] = param4;
                    _loc_8++;
                }
                totalCoins = 0;
                bonusCoins = 0;
                player.coins = 0;
                player.bcoins = 0;
                world.setMapArray(_loc_6);
                minimap.reset(world);
                _loc_6 = [];
                world.resetSecrets();
                world.resetPortals();
                world.resetSounds();
                return;
            }// end function
            );
            this.connection.addMessageHandler("refreshshop", function () : void
            {
                Global.base.refresShop();
                return;
            }// end function
            );
            this.connection.addMessageHandler("tele", function (param1:Message) : void
            {
                var _loc_4:int = 0;
                var _loc_5:int = 0;
                var _loc_6:int = 0;
                var _loc_7:Player = null;
                var _loc_2:* = param1.getBoolean(0);
                var _loc_3:int = 1;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_4 = param1.getInt(_loc_3);
                    _loc_5 = param1.getInt((_loc_3 + 1));
                    _loc_6 = param1.getInt(_loc_3 + 2);
                    _loc_7 = players[_loc_4];
                    if (_loc_7 != null)
                    {
                        _loc_7.x = _loc_5;
                        _loc_7.y = _loc_6;
                        if (_loc_2)
                        {
                            _loc_7.resetCoins();
                        }
                    }
                    if (_loc_4 == myid)
                    {
                        player.x = _loc_5;
                        player.y = _loc_6;
                        this.x = -_loc_6;
                        this.y = -_loc_6;
                        if (_loc_2)
                        {
                            player.resetCoins();
                            world.resetCoins();
                            world.resetSecrets();
                        }
                    }
                    _loc_3++;
                }
                return;
            }// end function
            );
            this.connection.send("init2");
            Global.stage.frameRate = Config.maxFrameRate;
            return;
        }// end function

        private function loadFile(param1:String, param2:Function) : void
        {
            var url:* = param1;
            var callback:* = param2;
            var wrapper:* = new Loader();
            var loader:* = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                callback();
                return;
            }// end function
            );
            loader.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent) : void
            {
                return;
            }// end function
            );
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function (event:SecurityErrorEvent) : void
            {
                return;
            }// end function
            );
            loader.load(new URLRequest(url));
            return;
        }// end function

        private function updateMinimap(param1:int, param2:int) : void
        {
            this.minimap.updatePixel(param1, param2, this.world.getMinimapColor(param1, param2));
            return;
        }// end function

        public function hideRed() : void
        {
            this.world.hideRed = false;
            if (this.world.overlaps(this.player))
            {
                this.world.hideRed = true;
                this.queue.push(this.hideRed);
            }
            return;
        }// end function

        public function hideGreen() : void
        {
            this.world.hideGreen = false;
            if (this.world.overlaps(this.player))
            {
                this.world.hideGreen = true;
                this.queue.push(this.hideGreen);
            }
            return;
        }// end function

        public function hideBlue() : void
        {
            this.world.hideBlue = false;
            if (this.world.overlaps(this.player))
            {
                this.world.hideBlue = true;
                this.queue.push(this.hideBlue);
            }
            return;
        }// end function

        public function hideTimedoor() : void
        {
            this.world.hideTimedoor = false;
            return;
        }// end function

        public function showRed() : void
        {
            this.world.hideRed = true;
            if (this.world.overlaps(this.player))
            {
                this.world.hideRed = false;
                this.queue.push(this.showRed);
            }
            return;
        }// end function

        public function showGreen() : void
        {
            this.world.hideGreen = true;
            if (this.world.overlaps(this.player))
            {
                this.world.hideGreen = false;
                this.queue.push(this.showGreen);
            }
            return;
        }// end function

        public function showBlue() : void
        {
            this.world.hideBlue = true;
            if (this.world.overlaps(this.player))
            {
                this.world.hideBlue = false;
                this.queue.push(this.showBlue);
            }
            return;
        }// end function

        public function showTimedoor() : void
        {
            this.world.hideTimedoor = true;
            return;
        }// end function

        public function setTile(param1:int, param2:int, param3:int, param4:int, param5:Object) : void
        {
            var _loc_14:Tile = null;
            var _loc_6:int = 0;
            while (_loc_6 < this.tilequeue.length)
            {
                
                _loc_14 = this.tilequeue[_loc_6] as Tile;
                if ((this.tilequeue[_loc_6] as Tile).equals(new Tile(param1, param2, param3, param4, param5)))
                {
                    this.tilequeue.splice(_loc_6, 1);
                    _loc_6 = _loc_6 - 1;
                }
                _loc_6++;
            }
            var _loc_7:* = this.world.getTile(param1, param2, param3);
            if (this.world.getTile(param1, param2, param3) == param4 && _loc_7 != ItemId.COINDOOR && _loc_7 != ItemId.COINGATE && _loc_7 != 242 && _loc_7 != 77 && _loc_7 != 83)
            {
                return;
            }
            var _loc_8:* = this.totalCoins;
            var _loc_9:* = this.player.coins;
            this.world.setTileComplex(param1, param2, param3, param4, param5);
            var _loc_10:* = _loc_7 == 100 || _loc_7 == 110;
            var _loc_11:* = param4 == 100 || param4 == 110;
            if (param4 == 100 || param4 == 110)
            {
                if (!_loc_10)
                {
                    var _loc_15:String = this;
                    var _loc_16:* = this.totalCoins + 1;
                    _loc_15.totalCoins = _loc_16;
                }
                else
                {
                    var _loc_15:* = this.player;
                    var _loc_16:* = this.player.coins - 1;
                    _loc_15.coins = _loc_16;
                }
            }
            else if (_loc_10)
            {
                if (_loc_7 == 110)
                {
                    var _loc_15:* = this.player;
                    var _loc_16:* = this.player.coins - 1;
                    _loc_15.coins = _loc_16;
                }
                var _loc_15:String = this;
                var _loc_16:* = this.totalCoins - 1;
                _loc_15.totalCoins = _loc_16;
            }
            var _loc_12:* = _loc_7 == 101 || _loc_7 == 111;
            var _loc_13:* = param4 == 101 || param4 == 111;
            if (param4 == 101 || param4 == 111)
            {
                if (!_loc_12)
                {
                    var _loc_15:String = this;
                    var _loc_16:* = this.bonusCoins + 1;
                    _loc_15.bonusCoins = _loc_16;
                }
                else
                {
                    var _loc_15:* = this.player;
                    var _loc_16:* = this.player.bcoins - 1;
                    _loc_15.bcoins = _loc_16;
                }
            }
            else if (_loc_12)
            {
                if (_loc_7 == 111)
                {
                    var _loc_15:* = this.player;
                    var _loc_16:* = this.player.bcoins - 1;
                    _loc_15.bcoins = _loc_16;
                }
                var _loc_15:String = this;
                var _loc_16:* = this.bonusCoins - 1;
                _loc_15.bonusCoins = _loc_16;
            }
            if (this.world.overlaps(this.player))
            {
                this.totalCoins = _loc_8;
                this.player.coins = _loc_9;
                this.world.setTileComplex(param1, param2, param3, _loc_7, null);
                this.tilequeue.push(new Tile(param1, param2, param3, param4, param5));
            }
            this.updateMinimap(param2, param3);
            return;
        }// end function

        override public function enterFrame() : void
        {
            var _loc_3:Player = null;
            var _loc_4:String = null;
            var _loc_5:Tile = null;
            super.enterFrame();
            this.cointext.text = this.player.coins + "/" + this.totalCoins;
            this.bcointext.text = this.player.bcoins + "/" + this.bonusCoins;
            var _loc_1:* = this.queue.length;
            while (_loc_1--)
            {
                
                this.this.queue.shift()();
            }
            var _loc_2:* = this.tilequeue.length;
            while (_loc_2--)
            {
                
                _loc_5 = this.tilequeue.shift();
                this.setTile(_loc_5.layer, _loc_5.xo, _loc_5.yo, _loc_5.value, _loc_5.properties);
            }
            for each (_loc_3 in this.players)
            {
                
                this.minimap.showPlayer(_loc_3, _loc_3.minimapColor);
            }
            this.minimap.showPlayer(this.player, this.player.minimapColor);
            for (_loc_4 in this.players)
            {
                
                _loc_3 = this.players[_loc_4] as Player;
                _loc_3.enterChat();
            }
            if (this.isTutorialRoom && Global.roomid == Config.server_type_tutorialroom + "3")
            {
                if (this.player.x >= 16 * 42 && this.player.x <= 16 * 117)
                {
                    if (!this.inEditArea)
                    {
                        this.inEditArea = true;
                        Global.base.showUi();
                    }
                }
                else if (this.inEditArea)
                {
                    this.inEditArea = false;
                    Global.base.hideUi();
                }
            }
            this.player.enterChat();
            return;
        }// end function

        override public function tick() : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Boolean = false;
            var _loc_1:* = this.world.overlaps(this.player) != 0;
            var _loc_2:* = this.world.showCoinGate;
            this.world.showCoinGate = this.player.coins;
            if (this.world.overlaps(this.player))
            {
                this.world.showCoinGate = _loc_2;
            }
            if (Bl.data.isModerator && Bl.isKeyDown(16))
            {
                if (Bl.isKeyDown(71))
                {
                    x = x + 20;
                }
                if (Bl.isKeyDown(74))
                {
                    x = x - 20;
                }
                if (Bl.isKeyDown(89))
                {
                    y = y + 20;
                }
                if (Bl.isKeyDown(72))
                {
                    y = y - 20;
                }
                if (Bl.isKeyJustPressed(82))
                {
                    if (target)
                    {
                        target = null;
                    }
                    else
                    {
                        target = this.player;
                    }
                }
            }
            else
            {
                if (Bl.isKeyJustPressed(71) && Bl.data.canEdit)
                {
                    this.connection.send("god", !this.player.isgod);
                }
                if (Bl.isKeyJustPressed(80) && Bl.data.isModerator == true)
                {
                    this.connection.send("mod");
                }
            }
            if (Bl.isMouseJustPressed || Bl.data.isLockedRoom && Bl.isMouseDown && !this.isTutorialRoom)
            {
                if (!(Bl.mouseX > 640 || Bl.mouseX < 0 || Bl.mouseY > 470 || Bl.mouseY < 0))
                {
                    _loc_3 = (Bl.mouseX - this.x) / 16 >> 0;
                    _loc_4 = (Bl.mouseY - this.y) / 16 >> 0;
                    if (Bl.data.brick == 0)
                    {
                        if (Bl.isMouseJustPressed)
                        {
                            if (this.world.getTile(0, _loc_3, _loc_4) != 0)
                            {
                                _loc_5 = 0;
                            }
                            else
                            {
                                _loc_5 = 1;
                            }
                            this.eraserLayerLock = _loc_5;
                        }
                        else
                        {
                            _loc_5 = this.eraserLayerLock;
                        }
                    }
                    else
                    {
                        _loc_5 = Bl.data.brick >= 500 && Bl.data.brick < 700 ? (1) : (0);
                    }
                    if (_loc_3 >= 0 && _loc_4 >= 0 && _loc_3 < this.world.width && _loc_4 < this.world.height)
                    {
                        if (Bl.data.brick == 100 && this.world.getTile(0, _loc_3, _loc_4) == 110)
                        {
                            this.setTile(0, _loc_3, _loc_4, 100, null);
                        }
                        if (Bl.data.brick == 101 && this.world.getTile(0, _loc_3, _loc_4) == 111)
                        {
                            this.setTile(0, _loc_3, _loc_4, 101, null);
                        }
                        if (this.connection.connected && !this.isSame(_loc_5, _loc_3, _loc_4) && Bl.data.brick >= 0)
                        {
                            _loc_6 = true;
                            if (_loc_3 == this.pastX && _loc_4 == this.pastY)
                            {
                                if (new Date().time - this.pastT < 500)
                                {
                                    _loc_6 = false;
                                }
                            }
                            if (_loc_6)
                            {
                                this.pastX = _loc_3;
                                this.pastY = _loc_4;
                                this.pastT = new Date().time;
                                switch(Bl.data.brick)
                                {
                                    case ItemId.COINDOOR:
                                    case ItemId.COINGATE:
                                    {
                                        this.connection.send(Bl.data.m, _loc_5, _loc_3, _loc_4, Bl.data.brick, Bl.data.coincount);
                                        break;
                                    }
                                    case 242:
                                    {
                                        this.connection.send(Bl.data.m, _loc_5, _loc_3, _loc_4, Bl.data.brick, (this.world.getPortal(_loc_3, _loc_4).rotation + 1), Bl.data.portal_id, Bl.data.portal_target);
                                        break;
                                    }
                                    case 1000:
                                    {
                                        this.connection.send(Bl.data.m, _loc_5, _loc_3, _loc_4, Bl.data.brick, Global.default_label_text);
                                        break;
                                    }
                                    case 83:
                                    {
                                        this.connection.send(Bl.data.m, _loc_5, _loc_3, _loc_4, Bl.data.brick, Global.drumOffset);
                                        break;
                                    }
                                    case 77:
                                    {
                                        this.connection.send(Bl.data.m, _loc_5, _loc_3, _loc_4, Bl.data.brick, Global.pianoOffset);
                                        break;
                                    }
                                    default:
                                    {
                                        this.connection.send(Bl.data.m, _loc_5, _loc_3, _loc_4, Bl.data.brick);
                                        break;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            super.tick();
            return;
        }// end function

        private function isSame(param1:int, param2:int, param3:int) : Boolean
        {
            if (Bl.data.brick == this.world.getTile(param1, param2, param3))
            {
                switch(Bl.data.brick)
                {
                    case ItemId.COINDOOR:
                    case ItemId.COINGATE:
                    {
                        if (this.world.getCoinValue(param2, param3) != Bl.data.coincount)
                        {
                            return false;
                        }
                        break;
                    }
                    case 83:
                    {
                        if (this.world.getSound(param2, param3) != Global.drumOffset)
                        {
                            return false;
                        }
                        break;
                    }
                    case 77:
                    {
                        if (this.world.getSound(param2, param3) != Global.pianoOffset)
                        {
                            return false;
                        }
                        break;
                    }
                    case 242:
                    {
                        return false;
                    }
                    default:
                    {
                        break;
                    }
                }
                return true;
            }
            return false;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_6:String = null;
            var _loc_7:Player = null;
            var _loc_4:* = new Date().time;
            super.draw(param1, param2, param3);
            var _loc_5:* = !this.player.moving || Global.chatIsVisible;
            if (!(!this.player.moving || Global.chatIsVisible))
            {
                this.chatTime = new Date().time;
            }
            else if (new Date().time - this.chatTime < 1500)
            {
                _loc_5 = false || Global.chatIsVisible;
            }
            this.world.postDraw(param1, param2 + x, param3 + y);
            for (_loc_6 in this.players)
            {
                
                _loc_7 = this.players[_loc_6] as Player;
                _loc_7.drawChat(param1, param2 + x, param3 + y, _loc_5);
                _loc_7.drawGods(param1, param2 + x, param3 + y);
            }
            this.player.drawChat(param1, param2 + x, param3 + y, _loc_5);
            this.player.drawGods(param1, param2 + x, param3 + y);
            Chat.drawAll();
            if (this.totalCoins > 0)
            {
                this.cointextcontainer.draw(param1, 0, 0);
            }
            if (this.bonusCoins > 0)
            {
                this.bcointextcontainer.draw(param1, 0, 15);
            }
            if (Bl.data.showMap)
            {
                this.minimap.draw(param1, 0, 0);
            }
            else
            {
                this.minimap.clear();
            }
            return;
        }// end function

        override public function get align() : String
        {
            return STATE_ALIGN_LEFT;
        }// end function

        public function reset() : void
        {
            return;
        }// end function

        private function handlePotion(param1:Player, param2:int, param3:Boolean) : void
        {
            var p:* = param1;
            var id:* = param2;
            var active:* = param3;
            if (p == this.player)
            {
                Shop.refresh(function () : void
            {
                return;
            }// end function
            );
            }
            switch(id)
            {
                case 1:
                {
                    p.aura_color = active ? (4294901760) : (4294967295);
                    p.aura_offset = active ? (1) : (0);
                    break;
                }
                case 2:
                {
                    p.aura_color = active ? (4278190335) : (4294967295);
                    p.aura_offset = active ? (2) : (0);
                    break;
                }
                case 3:
                {
                    p.aura_color = active ? (4294967040) : (4294967295);
                    p.aura_offset = active ? (3) : (0);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
