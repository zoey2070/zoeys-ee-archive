package 
{
    import Player.*;
    import SynchronizedObject.*;
    import SynchronizedSprite.*;
    import __AS3__.vec.*;
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import items.*;
    import playerio.*;
    import states.*;
    import ui.*;

    public class Player extends SynchronizedSprite
    {
        protected var Ding:Class;
        protected var Crown:Class;
        protected var CrownSilver:Class;
        protected var Aura:Class;
        protected var ModAura:Class;
        protected var ding:Sound;
        private var world:World;
        public var isme:Boolean;
        private var crown:BitmapData;
        private var crown_silver:BitmapData;
        private var aura:BitmapData;
        private var modaura:BitmapData;
        private var connection:Connection;
        private var state:PlayState;
        private var chat:Chat;
        public var name:String;
        private var textcolor:uint;
        private var morx:int = 0;
        private var mory:int = 0;
        public var coins:int = 0;
        public var bcoins:int = 0;
        public var hascrown:Boolean = false;
        public var hascrownsilver:Boolean = false;
        public var isgod:Boolean = false;
        public var ismod:Boolean = false;
        public var current:int = 0;
        public var current_bg:int = 0;
        public var overlapy:int = 0;
        public var gravityMultiplier:Number = 1;
        private var rect2:Rectangle;
        public var aura_color:uint = 4.29497e+009;
        public var aura_offset:int = 0;
        private var total:Number = 0;
        private var pastx:int = 0;
        private var pasty:int = 0;
        private var queue:Vector.<int>;
        private var lastJump:Number;
        private var changed:Boolean = false;
        private var leftdown:int = 0;
        private var rightdown:int = 0;
        private var updown:int = 0;
        private var downdown:int = 0;
        private var spacedown:Boolean = false;
        private var spacejustdown:Boolean = false;
        public var horizontal:int = 0;
        public var vertical:int = 0;
        public var oh:int = 0;
        public var ov:int = 0;
        private var lastPortal:Point;
        private var lastOverlap:int = 0;
        private var that:SynchronizedObject;
        private var bbest:Number = 0;
        private var donex:Boolean = false;
        private var doney:Boolean = false;
        private var modoffset:Number = 0;
        private var modrect:Rectangle;
        private static var admins:Object = {benjaminsen:true, cyclone:true, toby:true, rpgmaster2000:true, mrshoe:true};

        public function Player(param1:World, param2:String, param3:Boolean = false, param4:Connection = null, param5:PlayState = null)
        {
            this.Ding = Player_Ding;
            this.Crown = Player_Crown;
            this.CrownSilver = Player_CrownSilver;
            this.Aura = Player_Aura;
            this.ModAura = Player_ModAura;
            this.ding = new this.Ding();
            this.crown = new this.Crown().bitmapData;
            this.crown_silver = new this.CrownSilver().bitmapData;
            this.aura = new this.Aura().bitmapData;
            this.modaura = new this.ModAura().bitmapData;
            this.rect2 = new Rectangle(0, 0, 16, 26);
            this.queue = new Vector.<int>(Config.physics_queue_length);
            this.lastJump = -new Date().getTime();
            this.lastPortal = new Point();
            this.that = this as SynchronizedObject;
            this.modrect = new Rectangle(0, 0, 64, 64);
            super(ItemManager.smiliesBMD);
            this.state = param5;
            this.connection = param4;
            this.world = param1;
            this.hitmap = param1;
            this.x = 16;
            this.y = 16;
            this.isme = param3;
            this.name = param2;
            this.chat = new Chat(param2.indexOf(" ") != -1 ? ("") : (param2));
            size = 16;
            width = 16;
            height = 16;
            return;
        }// end function

        override public function tick() : void
        {
            var cx:int;
            var cy:int;
            var isgodmod:Boolean;
            var reminderX:Number;
            var currentSX:Number;
            var reminderY:Number;
            var currentSY:Number;
            var osx:Number;
            var osy:Number;
            var ox:Number;
            var oy:Number;
            var mod:int;
            var injump:Boolean;
            var cchanged:Boolean;
            var doJump:Boolean;
            var tx:Number;
            var ty:Number;
            var stepx:* = function () : void
            {
                if (currentSX > 0)
                {
                    if (currentSX + reminderX >= 1)
                    {
                        x = x + (1 - reminderX);
                        x = x >> 0;
                        currentSX = currentSX - (1 - reminderX);
                        reminderX = 0;
                    }
                    else
                    {
                        x = x + currentSX;
                        currentSX = 0;
                    }
                }
                else if (currentSX < 0)
                {
                    if (reminderX != 0 && reminderX + currentSX < 0)
                    {
                        currentSX = currentSX + reminderX;
                        x = x - reminderX;
                        x = x >> 0;
                        reminderX = 1;
                    }
                    else
                    {
                        x = x + currentSX;
                        currentSX = 0;
                    }
                }
                if (hitmap != null)
                {
                    if (hitmap.overlaps(that))
                    {
                        x = ox;
                        _speedX = 0;
                        currentSX = osx;
                        donex = true;
                    }
                }
                return;
            }// end function
            ;
            var stepy:* = function () : void
            {
                if (currentSY > 0)
                {
                    if (currentSY + reminderY >= 1)
                    {
                        y = y + (1 - reminderY);
                        y = y >> 0;
                        currentSY = currentSY - (1 - reminderY);
                        reminderY = 0;
                    }
                    else
                    {
                        y = y + currentSY;
                        currentSY = 0;
                    }
                }
                else if (currentSY < 0)
                {
                    if (reminderY != 0 && reminderY + currentSY < 0)
                    {
                        y = y - reminderY;
                        y = y >> 0;
                        currentSY = currentSY + reminderY;
                        reminderY = 1;
                    }
                    else
                    {
                        y = y + currentSY;
                        currentSY = 0;
                    }
                }
                if (hitmap != null)
                {
                    if (hitmap.overlaps(that))
                    {
                        y = oy;
                        _speedY = 0;
                        currentSY = osy;
                        doney = true;
                    }
                }
                return;
            }// end function
            ;
            var processPortals:* = function () : void
            {
                var _loc_1:Vector.<Point> = null;
                var _loc_2:int = 0;
                var _loc_3:Point = null;
                var _loc_4:int = 0;
                var _loc_5:int = 0;
                var _loc_6:Number = NaN;
                var _loc_7:Number = NaN;
                var _loc_8:Number = NaN;
                var _loc_9:Number = NaN;
                var _loc_10:int = 0;
                var _loc_11:Number = NaN;
                current = world.getTile(0, cx, cy);
                if (!isgodmod && current == 242)
                {
                    if (lastPortal == null)
                    {
                        lastPortal = new Point(cx << 4, cy << 4);
                        _loc_1 = world.getPortals(world.getPortal(cx, cy).target);
                        _loc_2 = 0;
                        while (_loc_2 < _loc_1.length)
                        {
                            
                            _loc_3 = _loc_1[_loc_2];
                            _loc_4 = world.getPortal(lastPortal.x >> 4, lastPortal.y >> 4).rotation;
                            _loc_5 = world.getPortal(_loc_3.x >> 4, _loc_3.y >> 4).rotation;
                            if (_loc_4 < _loc_5)
                            {
                                _loc_4 = _loc_4 + 4;
                            }
                            _loc_6 = speedX;
                            _loc_7 = speedY;
                            _loc_8 = modifierX;
                            _loc_9 = modifierY;
                            _loc_10 = _loc_4 - _loc_5;
                            _loc_11 = 1.42;
                            switch(_loc_10)
                            {
                                case 1:
                                {
                                    speedX = _loc_7 * _loc_11;
                                    speedY = (-_loc_6) * _loc_11;
                                    modifierX = _loc_9 * _loc_11;
                                    modifierY = (-_loc_8) * _loc_11;
                                    reminderY = -reminderY;
                                    currentSY = -currentSY;
                                    break;
                                }
                                case 3:
                                {
                                    speedX = (-_loc_7) * _loc_11;
                                    speedY = _loc_6 * _loc_11;
                                    modifierX = (-_loc_9) * _loc_11;
                                    modifierY = _loc_8 * _loc_11;
                                    reminderX = -reminderX;
                                    currentSX = -currentSX;
                                    break;
                                }
                                case 2:
                                {
                                    speedX = (-_loc_6) * _loc_11;
                                    speedY = (-_loc_7) * _loc_11;
                                    modifierX = (-_loc_8) * _loc_11;
                                    modifierY = (-_loc_9) * _loc_11;
                                    reminderY = -reminderY;
                                    currentSY = -currentSY;
                                    reminderX = -reminderX;
                                    currentSX = -currentSX;
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            if (isme && state)
                            {
                                state.offset(x - _loc_3.x, y - _loc_3.y);
                            }
                            x = _loc_3.x;
                            y = _loc_3.y;
                            lastPortal = _loc_3;
                            break;
                            _loc_2++;
                        }
                    }
                }
                else
                {
                    lastPortal = null;
                }
                return;
            }// end function
            ;
            if (this.ismod && !this.isgod)
            {
                this.modoffset = this.modoffset + 0.2;
                if (this.modoffset >= 16)
                {
                    this.modoffset = 10;
                }
            }
            else
            {
                this.modoffset = 0;
            }
            cx = this.x + 8 >> 4;
            cy = this.y + 8 >> 4;
            var delayed:* = this.queue.shift();
            this.current = this.world.getTile(0, cx, cy);
            this.queue.push(this.current);
            if (this.current == 4 || this.current == ItemId.NINJA_LADDER || this.current == ItemId.CHAIN)
            {
                delayed = this.queue.shift();
                this.queue.push(this.current);
            }
            if (this.isme)
            {
                this.leftdown = Bl.isKeyDown(37) || Bl.isKeyDown(65) ? (-1) : (0);
                this.rightdown = Bl.isKeyDown(39) || Bl.isKeyDown(68) ? (1) : (0);
                this.updown = Bl.isKeyDown(38) || Bl.isKeyDown(87) ? (-1) : (0);
                this.downdown = Bl.isKeyDown(40) || Bl.isKeyDown(83) ? (1) : (0);
                this.spacejustdown = Bl.isKeyJustPressed(32);
                this.spacedown = Bl.isKeyDown(32);
                this.horizontal = this.leftdown + this.rightdown;
                this.vertical = this.updown + this.downdown;
                Bl.resetJustPressed();
            }
            isgodmod = this.isgod || this.ismod;
            if (isgodmod)
            {
                this.morx = 0;
                this.mory = 0;
                this.mox = 0;
                this.moy = 0;
            }
            else
            {
                switch(this.current)
                {
                    case 1:
                    {
                        this.morx = -_gravity;
                        this.mory = 0;
                        break;
                    }
                    case 2:
                    {
                        this.morx = 0;
                        this.mory = -_gravity;
                        break;
                    }
                    case 3:
                    {
                        this.morx = _gravity;
                        this.mory = 0;
                        break;
                    }
                    case ItemId.CHAIN:
                    case ItemId.NINJA_LADDER:
                    case 4:
                    {
                        this.morx = 0;
                        this.mory = 0;
                        break;
                    }
                    case ItemId.WATER:
                    {
                        this.morx = 0;
                        this.mory = _water_buoyancy;
                        break;
                    }
                    default:
                    {
                        this.morx = 0;
                        this.mory = _gravity;
                        break;
                        break;
                    }
                }
                switch(delayed)
                {
                    case 1:
                    {
                        this.mox = -_gravity;
                        this.moy = 0;
                        break;
                    }
                    case 2:
                    {
                        this.mox = 0;
                        this.moy = -_gravity;
                        break;
                    }
                    case 3:
                    {
                        this.mox = _gravity;
                        this.moy = 0;
                        break;
                    }
                    case ItemId.CHAIN:
                    case ItemId.NINJA_LADDER:
                    case 4:
                    {
                        this.mox = 0;
                        this.moy = 0;
                        break;
                    }
                    case ItemId.WATER:
                    {
                        this.mox = 0;
                        this.moy = _water_buoyancy;
                        break;
                    }
                    default:
                    {
                        this.mox = 0;
                        this.moy = _gravity;
                        break;
                        break;
                    }
                }
            }
            if (this.moy == _water_buoyancy)
            {
                mx = this.horizontal;
                my = this.vertical;
            }
            else if (this.moy)
            {
                mx = this.horizontal;
                my = 0;
            }
            else if (this.mox)
            {
                mx = 0;
                my = this.vertical;
            }
            else
            {
                mx = this.horizontal;
                my = this.vertical;
            }
            mox = mox * this.gravityMultiplier;
            moy = moy * this.gravityMultiplier;
            this.modifierX = this.mox + mx;
            this.modifierY = this.moy + my;
            if (_speedX || _modifierX)
            {
                _speedX = _speedX + _modifierX;
                _speedX = _speedX * Config.physics_base_drag;
                if (mx == 0 && moy != 0 || _speedX < 0 && mx > 0 || _speedX > 0 && mx < 0 || (this.current == ItemId.NINJA_LADDER || this.current == ItemId.CHAIN) && !isgodmod)
                {
                    _speedX = _speedX * _no_modifier_dragX;
                }
                else if (this.current == ItemId.WATER && !isgodmod)
                {
                    _speedX = _speedX * _water_drag;
                }
                if (_speedX > 16)
                {
                    _speedX = 16;
                }
                else if (_speedX < -16)
                {
                    _speedX = -16;
                }
                else if (_speedX < 0.0001 && _speedX > -0.0001)
                {
                    _speedX = 0;
                }
            }
            if (_speedY || _modifierY)
            {
                _speedY = _speedY + _modifierY;
                _speedY = _speedY * Config.physics_base_drag;
                if (my == 0 && mox != 0 || _speedY < 0 && my > 0 || _speedY > 0 && my < 0 || (this.current == ItemId.NINJA_LADDER || this.current == ItemId.CHAIN) && !isgodmod)
                {
                    _speedY = _speedY * _no_modifier_dragY;
                }
                else if (this.current == ItemId.WATER && !isgodmod)
                {
                    _speedY = _speedY * _water_drag;
                }
                if (_speedY > 16)
                {
                    _speedY = 16;
                }
                else if (_speedY < -16)
                {
                    _speedY = -16;
                }
                else if (_speedY < 0.0001 && _speedY > -0.0001)
                {
                    _speedY = 0;
                }
            }
            if (!isgodmod)
            {
                switch(this.current)
                {
                    case ItemId.SPEED_LEFT:
                    {
                        _speedX = -_boost;
                        break;
                    }
                    case ItemId.SPEED_RIGHT:
                    {
                        _speedX = _boost;
                        break;
                    }
                    case ItemId.SPEED_UP:
                    {
                        _speedY = -_boost;
                        break;
                    }
                    case ItemId.SPEED_DOWN:
                    {
                        _speedY = _boost;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            reminderX = x % 1;
            currentSX = _speedX;
            reminderY = y % 1;
            currentSY = _speedY;
            this.donex = false;
            this.doney = false;
            while (currentSX != 0 && !this.donex || currentSY != 0 && !this.doney)
            {
                
                this.processPortals();
                ox = x;
                oy = y;
                osx = currentSX;
                osy = currentSY;
                this.stepx();
                this.stepy();
            }
            if (this.isme)
            {
                mod;
                injump;
                if (this.spacejustdown)
                {
                    this.lastJump = -new Date().getTime();
                    injump;
                    mod;
                }
                if (this.spacedown)
                {
                    doJump;
                    if (this.lastJump < 0)
                    {
                        if (new Date().getTime() + this.lastJump > 750)
                        {
                            doJump;
                            injump;
                        }
                    }
                    else if (new Date().getTime() - this.lastJump > 150)
                    {
                        doJump;
                        injump;
                    }
                }
                if (injump)
                {
                    if (this.speedX == 0 && this.morx && this.mox && this.x % 16 == 0)
                    {
                        this.speedX = this.speedX - this.morx * Config.physics_jump_height;
                        this.changed = true;
                        this.lastJump = new Date().getTime() * mod;
                    }
                    if (this.speedY == 0 && this.mory && this.moy && this.y % 16 == 0)
                    {
                        this.speedY = this.speedY - this.mory * Config.physics_jump_height;
                        this.changed = true;
                        this.lastJump = new Date().getTime() * mod;
                    }
                }
                cchanged;
                switch(this.current)
                {
                    case 100:
                    {
                        if (Global.play_sounds)
                        {
                            this.ding.play();
                        }
                        this.world.setTileComplex(0, cx, cy, 110, null);
                        var _loc_2:String = this;
                        var _loc_3:* = this.coins + 1;
                        _loc_2.coins = _loc_3;
                        cchanged;
                        break;
                    }
                    case 101:
                    {
                        if (Global.play_sounds)
                        {
                            this.ding.play();
                        }
                        this.world.setTileComplex(0, cx, cy, 111, null);
                        var _loc_2:String = this;
                        var _loc_3:* = this.bcoins + 1;
                        _loc_2.bcoins = _loc_3;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (this.pastx != cx || this.pasty != cy)
                {
                    switch(this.current)
                    {
                        case 5:
                        {
                            if (!this.hascrown && !isgodmod)
                            {
                                this.connection.send(Bl.data.m + "k");
                            }
                            break;
                        }
                        case 6:
                        {
                            this.connection.send(Bl.data.m + "r");
                            this.state.showRed();
                            break;
                        }
                        case 7:
                        {
                            this.connection.send(Bl.data.m + "g");
                            this.state.showGreen();
                            break;
                        }
                        case 8:
                        {
                            this.connection.send(Bl.data.m + "b");
                            this.state.showBlue();
                            break;
                        }
                        case 77:
                        {
                            if (this.pastx != cx || this.pasty != cy)
                            {
                                if (Global.play_sounds)
                                {
                                    ItemManager.pianoSounds[this.world.getSound(cx, cy)].play();
                                    this.world.pingSound(cx, cy);
                                }
                            }
                            break;
                        }
                        case 83:
                        {
                            if (this.pastx != cx || this.pasty != cy)
                            {
                                if (Global.play_sounds)
                                {
                                    ItemManager.drumSounds[this.world.getSound(cx, cy)].play();
                                    this.world.pingSound(cx, cy);
                                }
                            }
                            break;
                        }
                        case ItemId.DIAMOND:
                        {
                            this.connection.send("diamondtouch", cx, cy);
                            break;
                        }
                        case ItemId.CAKE:
                        {
                            this.connection.send("caketouch", cx, cy);
                            break;
                        }
                        case ItemId.BRICK_COMPLETE:
                        {
                            if (!isgodmod)
                            {
                                this.connection.send("levelcomplete");
                                if (!this.hascrownsilver)
                                {
                                    Global.base.showLevelComplete(new LevelComplete());
                                }
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    this.pastx = cx;
                    this.pasty = cy;
                }
                if (this.changed || this.oh != this.horizontal || this.ov != this.vertical)
                {
                    this.oh = this.horizontal;
                    this.ov = this.vertical;
                    if (this.connection.connected)
                    {
                        this.connection.send("m", this.x, this.y, this.speedX, this.speedY, this.modifierX, this.modifierY, this.horizontal, this.vertical, this.gravityMultiplier);
                    }
                }
                if (cchanged)
                {
                    this.connection.send("c", this.coins, cx, cy);
                    if (Math.random() * 3000 >> 0 == 0)
                    {
                        Global.base.awardSwappits();
                    }
                }
                this.changed = false;
            }
            var imx:* = _speedX << 8;
            var imy:* = _speedY << 8;
            moving = false;
            if (imx != 0 || this.current == ItemId.WATER)
            {
                moving = true;
            }
            else if (_modifierX < 0.1 && _modifierX > -0.1)
            {
                tx = x % 16;
                if (tx < 2)
                {
                    if (tx < 0.2)
                    {
                        x = x >> 0;
                    }
                    else
                    {
                        x = x - tx / 15;
                    }
                }
                else if (tx > 14)
                {
                    if (tx > 15.8)
                    {
                        x = x >> 0;
                        var _loc_3:* = x + 1;
                        x = _loc_3;
                    }
                    else
                    {
                        x = x + (tx - 14) / 15;
                    }
                }
            }
            if (imy != 0 || this.current == ItemId.WATER)
            {
                moving = true;
            }
            else if (_modifierY < 0.1 && _modifierY > -0.1)
            {
                ty = y % 16;
                if (ty < 2)
                {
                    if (ty < 0.2)
                    {
                        y = y >> 0;
                    }
                    else
                    {
                        y = y - ty / 15;
                    }
                }
                else if (ty > 14)
                {
                    if (ty > 15.8)
                    {
                        y = y >> 0;
                        var _loc_3:* = y + 1;
                        y = _loc_3;
                    }
                    else
                    {
                        y = y + (ty - 14) / 15;
                    }
                }
            }
            return;
        }// end function

        override public function update() : void
        {
            return;
        }// end function

        public function drawChat(param1:BitmapData, param2:Number, param3:Number, param4:Boolean) : void
        {
            this.chat.drawChat(param1, param2 + x, param3 + y, param4);
            return;
        }// end function

        public function enterChat() : void
        {
            this.chat.enterFrame();
            return;
        }// end function

        public function say(param1:String) : void
        {
            this.chat.say(param1);
            return;
        }// end function

        public function resetCoins() : void
        {
            this.coins = 0;
            this.bcoins = 0;
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            if (this.isgod || this.ismod)
            {
                return;
            }
            param1.copyPixels(bmd, this.rect2, new Point(x + param2, y + param3 - 5));
            if (this.hascrown)
            {
                param1.copyPixels(this.crown, this.crown.rect, new Point(x + param2, y + param3 - 6));
            }
            else if (this.hascrownsilver)
            {
                param1.copyPixels(this.crown_silver, this.crown_silver.rect, new Point(x + param2, y + param3 - 6));
            }
            return;
        }// end function

        public function drawGods(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_4:int = 0;
            if (!this.isgod && !this.ismod)
            {
                return;
            }
            if (this.isgod)
            {
                param1.copyPixels(this.aura, new Rectangle(this.aura_offset * 26, 0, 26, 26), new Point(x + param2 - 5, y + param3 - 5));
            }
            else if (this.ismod)
            {
                _loc_4 = this.modoffset;
                this.modrect.x = _loc_4 * 64;
                param1.copyPixels(this.modaura, this.modrect, new Point(x + param2 - 24, y + param3 - 24));
            }
            param1.copyPixels(bmd, this.rect2, new Point(x + param2, y + param3 - 5));
            if (this.hascrown)
            {
                param1.copyPixels(this.crown, this.crown.rect, new Point(x + param2, y + param3 - 6));
            }
            else if (this.hascrownsilver)
            {
                param1.copyPixels(this.crown_silver, this.crown_silver.rect, new Point(x + param2, y + param3 - 6));
            }
            return;
        }// end function

        override public function set frame(param1:int) : void
        {
            this.rect2.x = param1 * 16;
            return;
        }// end function

        override public function get frame() : int
        {
            return this.rect2.x / 16;
        }// end function

        public function set nameColor(param1:int) : void
        {
            this.chat.textColor = param1;
            return;
        }// end function

        public function get minimapColor() : uint
        {
            if (this.aura_color != 4294967295)
            {
                return this.aura_color;
            }
            return ItemManager.getSmileyById(this.frame).minimapcolor;
        }// end function

        public static function isAdmin(param1:String) : Boolean
        {
            return admins[param1] || false;
        }// end function

    }
}
