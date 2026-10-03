package 
{
    import World.*;
    import __AS3__.vec.*;
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import items.*;
    import playerio.*;

    public class World extends BlTilemap
    {
        private var player:Player;
        private var labelcontainer:BlContainer;
        private var showAllSecrets:Boolean = false;
        private var offset:Number = 0;
        public var hideRed:Boolean = false;
        public var hideGreen:Boolean = false;
        public var hideBlue:Boolean = false;
        private var _hideTimedoor:Boolean = false;
        public var showCoinGate:int = 0;
        public var hideTimedoorOffset:Number = 0;
        public var hideTimedoorTimer:Number;
        private static var soundslookup:Object = {};
        private static var coindoorslookup:Object = {};
        private static var coingateslookup:Object = {};
        private static var knownSecrets:Object = {};
        private static var portalLookup:Object = {};
        private static var waterOffset:Object = {};
        private static var labelLookup:Object = {};
        private static var musicBlinkLookup:Object = {};
        private static var point:Point = new Point();
        private static var sprite:BlSprite;
        private static var rect16x16:Rectangle = new Rectangle(0, 0, 16, 16);
        private static var rect18x18:Rectangle = new Rectangle(0, 0, 18, 18);
        private static var bmd:BitmapData;
        private static var ashift:uint = 0;
        private static var type:int;

        public function World(param1:Boolean = true)
        {
            this.labelcontainer = new BlContainer();
            this.hideTimedoorTimer = new Date().time;
            super(new Bitmap(new BitmapData(16, 16, false, 0)), 9);
            if (param1)
            {
                coindoorslookup = {};
                coingateslookup = {};
                knownSecrets = {};
                portalLookup = {};
                labelLookup = {};
                soundslookup = {};
            }
            return;
        }// end function

        public function set hideTimedoor(param1:Boolean) : void
        {
            this.hideTimedoorOffset = this.offset;
            this.hideTimedoorTimer = new Date().time;
            this._hideTimedoor = param1;
            return;
        }// end function

        public function setShowAllSecrets(param1:Boolean) : void
        {
            this.showAllSecrets = param1;
            return;
        }// end function

        public function setPlayer(param1:Player) : void
        {
            this.player = param1;
            return;
        }// end function

        override public function update() : void
        {
            this.offset = this.offset + 0.3;
            super.update();
            return;
        }// end function

        public function getCoinValue(param1:int, param2:int) : int
        {
            return coindoorslookup[param1 + "x" + param2] || coingateslookup[param1 + "x" + param2] || 0;
        }// end function

        public function getPortal(param1:int, param2:int) : portal
        {
            return portalLookup[param1 + "x" + param2] || new portal(0, 0, 0);
        }// end function

        public function getSound(param1:int, param2:int) : int
        {
            var _loc_3:* = soundslookup[param1 + "x" + param2];
            return _loc_3 || 0;
        }// end function

        public function pingSound(param1:int, param2:int) : void
        {
            musicBlinkLookup[param1 + "x" + param2] = 30;
            return;
        }// end function

        public function getPortals(param1:int) : Vector.<Point>
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_2:* = new Vector.<Point>;
            for (_loc_3 in portalLookup)
            {
                
                _loc_4 = _loc_3.split("x");
                if (portalLookup[_loc_3].id == param1)
                {
                    _loc_2.push(new Point(parseInt(_loc_4[0]) << 4, parseInt(_loc_4[1]) << 4));
                }
            }
            return _loc_2;
        }// end function

        public function deserializeFromDatabaseObject(param1:DatabaseObject) : void
        {
            var _loc_10:int = 0;
            var _loc_11:Object = null;
            var _loc_12:ByteArray = null;
            var _loc_13:ByteArray = null;
            var _loc_14:int = 0;
            var _loc_15:int = 0;
            var _loc_16:int = 0;
            var _loc_17:int = 0;
            var _loc_2:* = param1.width;
            var _loc_3:* = param1.height;
            var _loc_4:Array = [];
            var _loc_5:Array = [];
            var _loc_6:Array = [];
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            while (_loc_8 < 2)
            {
                
                _loc_5 = [];
                _loc_7 = 0;
                while (_loc_7 < _loc_3)
                {
                    
                    _loc_6 = [];
                    _loc_10 = 0;
                    while (_loc_10 < _loc_2)
                    {
                        
                        _loc_6.push(0);
                        _loc_10++;
                    }
                    _loc_5.push(_loc_6);
                    _loc_7++;
                }
                _loc_4.push(_loc_5);
                _loc_8++;
            }
            setMapArray(_loc_4);
            var _loc_9:* = param1.worlddata;
            _loc_7 = 0;
            while (_loc_7 < _loc_9.length)
            {
                
                if (_loc_9[_loc_7] == null)
                {
                }
                else
                {
                    _loc_11 = _loc_9[_loc_7];
                    _loc_12 = _loc_11.x;
                    _loc_13 = _loc_11.y;
                    _loc_12.position = 0;
                    _loc_13.position = 0;
                    _loc_14 = _loc_11.layer || 0;
                    _loc_15 = _loc_11.type || 0;
                    while (_loc_12.position < _loc_12.length)
                    {
                        
                        _loc_16 = (_loc_12.readUnsignedByte() << 8) + _loc_12.readUnsignedByte();
                        _loc_17 = (_loc_13.readUnsignedByte() << 8) + _loc_13.readUnsignedByte();
                        _loc_4[_loc_14][_loc_17][_loc_16] = _loc_15;
                    }
                }
                _loc_7++;
            }
            setMapArray(_loc_4);
            return;
        }// end function

        public function deserializeFromMessage(param1:int, param2:int, param3:Message) : Array
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_15:ByteArray = null;
            var _loc_16:ByteArray = null;
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            var _loc_19:int = 0;
            var _loc_20:int = 0;
            var _loc_21:String = null;
            var _loc_22:int = 0;
            var _loc_23:int = 0;
            var _loc_24:int = 0;
            var _loc_25:BlText = null;
            var _loc_6:int = 0;
            while (_loc_6 < param3.length)
            {
                
                try
                {
                    if (param3.getString(_loc_6) == "ws")
                    {
                        _loc_4 = _loc_6 + 1;
                    }
                    if (param3.getString(_loc_6) == "we")
                    {
                        _loc_5 = _loc_6;
                    }
                }
                catch (e:Error)
                {
                }
                _loc_6++;
            }
            var _loc_7:Array = [];
            var _loc_8:Array = [];
            var _loc_9:Array = [];
            coindoorslookup = {};
            coingateslookup = {};
            var _loc_10:int = 0;
            while (_loc_10 < 2)
            {
                
                _loc_8 = [];
                _loc_11 = 0;
                while (_loc_11 < param2)
                {
                    
                    _loc_9 = [];
                    _loc_12 = 0;
                    while (_loc_12 < param1)
                    {
                        
                        _loc_9.push(0);
                        _loc_12++;
                    }
                    _loc_8.push(_loc_9);
                    _loc_11++;
                }
                _loc_7.push(_loc_8);
                _loc_10++;
            }
            while (_loc_4 < _loc_5)
            {
                
                _loc_13 = param3.getInt(_loc_4++);
                _loc_14 = param3.getInt(_loc_4++);
                _loc_15 = param3.getByteArray(_loc_4++);
                _loc_16 = param3.getByteArray(_loc_4++);
                _loc_17 = 0;
                _loc_18 = 0;
                _loc_19 = 0;
                _loc_20 = 0;
                switch(_loc_13)
                {
                    case ItemId.COINDOOR:
                    {
                        _loc_17 = param3.getInt(_loc_4++);
                        break;
                    }
                    case ItemId.COINGATE:
                    {
                        _loc_17 = param3.getInt(_loc_4++);
                        break;
                    }
                    case 242:
                    {
                        _loc_18 = param3.getInt(_loc_4++);
                        _loc_19 = param3.getInt(_loc_4++);
                        _loc_20 = param3.getInt(_loc_4++);
                        break;
                    }
                    case 1000:
                    {
                        _loc_21 = param3.getString(_loc_4++);
                        break;
                    }
                    case 83:
                    case 77:
                    {
                        _loc_19 = param3.getInt(_loc_4++);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_15.position = 0;
                _loc_16.position = 0;
                _loc_22 = 0;
                while (_loc_22 < _loc_15.length / 2)
                {
                    
                    _loc_23 = _loc_15.readUnsignedShort();
                    _loc_24 = _loc_16.readUnsignedShort();
                    _loc_7[_loc_14][_loc_24][_loc_23] = _loc_13;
                    switch(_loc_13)
                    {
                        case ItemId.COINDOOR:
                        {
                            coindoorslookup[_loc_23 + "x" + _loc_24] = _loc_17;
                            break;
                        }
                        case ItemId.COINGATE:
                        {
                            coingateslookup[_loc_23 + "x" + _loc_24] = _loc_17;
                            break;
                        }
                        case 83:
                        case 77:
                        {
                            soundslookup[_loc_23 + "x" + _loc_24] = _loc_19;
                            break;
                        }
                        case 242:
                        {
                            portalLookup[_loc_23 + "x" + _loc_24] = new portal(_loc_18, _loc_19, _loc_20);
                            break;
                        }
                        case 1000:
                        {
                            _loc_25 = new BlText(12, 200, 16777215, "left", "system", true);
                            _loc_25.text = _loc_21;
                            _loc_25.x = _loc_23 * size;
                            _loc_25.y = _loc_24 * size;
                            this.labelcontainer.add(_loc_25);
                        }
                        case ItemId.BRICK_COMPLETE:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_22++;
                }
            }
            setMapArray(_loc_7);
            knownSecrets = {};
            return _loc_7;
        }// end function

        public function resetCoins() : void
        {
            var _loc_2:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < width)
            {
                
                _loc_2 = 0;
                while (_loc_2 < height)
                {
                    
                    if (realmap[0][_loc_2][_loc_1] == 110)
                    {
                        this.setTile(0, _loc_1, _loc_2, 100);
                    }
                    if (realmap[0][_loc_2][_loc_1] == 111)
                    {
                        this.setTile(0, _loc_1, _loc_2, 101);
                    }
                    _loc_2++;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function setTileComplex(param1:int, param2:int, param3:int, param4:int, param5:Object) : void
        {
            var _loc_6:CoinText = null;
            switch(param4)
            {
                case ItemId.COINDOOR:
                {
                    coindoorslookup[param2 + "x" + param3] = param5.goal;
                    break;
                }
                case ItemId.COINGATE:
                {
                    coingateslookup[param2 + "x" + param3] = param5.goal;
                    break;
                }
                case 242:
                {
                    if (param5.rotation != null && param5.id != null && param5.target != null)
                    {
                        portalLookup[param2 + "x" + param3] = new portal(param5.rotation, param5.id, param5.target);
                    }
                    break;
                }
                case 83:
                case 77:
                {
                    soundslookup[param2 + "x" + param3] = param5.sound;
                    musicBlinkLookup[param2 + "x" + param3] = 30;
                    break;
                }
                case 1000:
                {
                    _loc_6 = new CoinText(12, 200, 16777215, "left");
                    _loc_6.text = param5.text;
                    _loc_6.x = param2 * size;
                    _loc_6.y = param3 * size;
                    this.labelcontainer.add(_loc_6);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param4 != 242 && param1 == 0)
            {
                delete portalLookup[param2 + "x" + param3];
            }
            this.setTile(param1, param2, param3, param4);
            return;
        }// end function

        override protected function setTile(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:Vector.<BlObject> = null;
            var _loc_6:int = 0;
            var _loc_7:BlObject = null;
            if (realmap[param1][param3][param2] == 1000)
            {
                _loc_5 = this.labelcontainer.children;
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_7 = _loc_5[_loc_6];
                    if (_loc_7.x == param2 * size && _loc_7.y == param3 * size)
                    {
                        this.labelcontainer.remove(_loc_7);
                        break;
                    }
                    _loc_6++;
                }
            }
            super.setTile(param1, param2, param3, param4);
            if (param1 == 0)
            {
                knownSecrets[param2 + "x" + param3] = false;
            }
            return;
        }// end function

        public function resetSecrets() : void
        {
            knownSecrets = {};
            return;
        }// end function

        public function resetPortals() : void
        {
            portalLookup = {};
            return;
        }// end function

        public function resetSounds() : void
        {
            soundslookup = {};
            return;
        }// end function

        override public function overlaps(param1:BlObject) : int
        {
            var _loc_8:Vector.<int> = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            if (param1.x < 0 || param1.y < 0 || param1.x > this.width * 16 - 16 || param1.y > this.height * 16 - 16)
            {
                return 1;
            }
            var _loc_2:* = param1 as Player;
            if (_loc_2.isgod || _loc_2.ismod)
            {
                return 0;
            }
            var _loc_3:* = _loc_2.x >> 4;
            var _loc_4:* = _loc_2.y >> 4;
            var _loc_5:* = (param1.x + param1.height) / size;
            var _loc_6:* = (param1.y + param1.width) / size;
            var _loc_7:Boolean = false;
            var _loc_9:* = _loc_4;
            while (_loc_9 < _loc_6)
            {
                
                _loc_8 = realmap[0][_loc_9];
                _loc_10 = _loc_3;
                while (_loc_10 < _loc_5)
                {
                    
                    if (_loc_8 != null)
                    {
                        _loc_11 = _loc_8[_loc_10];
                        if (ItemId.isSolid(_loc_11))
                        {
                            switch(_loc_11)
                            {
                                case 23:
                                {
                                    if (this.hideRed)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 24:
                                {
                                    if (this.hideGreen)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 25:
                                {
                                    if (this.hideBlue)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 26:
                                {
                                    if (!this.hideRed)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 27:
                                {
                                    if (!this.hideGreen)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 28:
                                {
                                    if (!this.hideBlue)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 156:
                                {
                                    if (this._hideTimedoor)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 157:
                                {
                                    if (!this._hideTimedoor)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case ItemId.COINDOOR:
                                {
                                    if (this.getCoinValue(_loc_10, _loc_9) <= _loc_2.coins)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case ItemId.COINGATE:
                                {
                                    if (this.getCoinValue(_loc_10, _loc_9) > this.showCoinGate)
                                    {
                                        break;
                                    }
                                    break;
                                }
                                case 50:
                                {
                                    if (_loc_2.isme)
                                    {
                                        knownSecrets[_loc_10 + "x" + _loc_9] = true;
                                    }
                                    break;
                                }
                                case 61:
                                case 62:
                                case 63:
                                case 64:
                                case 89:
                                case 90:
                                case 91:
                                case 96:
                                case 97:
                                case 122:
                                case 123:
                                case 124:
                                case 125:
                                case 126:
                                case 127:
                                case 146:
                                case 154:
                                case 158:
                                {
                                    if (_loc_2.speedY < 0 || _loc_9 <= _loc_2.overlapy)
                                    {
                                        if (_loc_9 != _loc_4 || _loc_2.overlapy == -1)
                                        {
                                            _loc_2.overlapy = _loc_9;
                                        }
                                        _loc_7 = true;
                                        break;
                                    }
                                    break;
                                }
                                case 83:
                                case 77:
                                {
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            return _loc_11;
                        }
                        else if (_loc_11 == 243)
                        {
                            if (_loc_2.isme)
                            {
                                knownSecrets[_loc_10 + "x" + _loc_9] = true;
                            }
                        }
                    }
                    _loc_10++;
                }
                _loc_9++;
            }
            if (!_loc_7)
            {
                _loc_2.overlapy = -1;
            }
            return 0;
        }// end function

        public function getMinimapColor(param1:int, param2:int) : Number
        {
            return ItemManager.getMinimapColor(decoration[param2][param1] || forground[param2][param1] || background[param2][param1]) || ItemManager.getMinimapColor(background[param2][param1]);
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            var _loc_11:Vector.<int> = null;
            var _loc_12:Vector.<int> = null;
            var _loc_13:Vector.<int> = null;
            var _loc_14:portal = null;
            var _loc_4:* = (-param3) / size;
            var _loc_5:* = (-param2) / size;
            var _loc_6:Boolean = false;
            if (_loc_4 < 0)
            {
                _loc_6 = true;
                _loc_4 = 0;
            }
            if (_loc_5 < 0)
            {
                _loc_6 = true;
                _loc_5 = 0;
            }
            var _loc_7:* = _loc_4 + Bl.height / size + 1;
            var _loc_8:* = _loc_5 + Bl.width / size + 1;
            if (_loc_7 > height)
            {
                _loc_6 = true;
                _loc_7 = height;
            }
            if (_loc_8 > width)
            {
                _loc_6 = true;
                _loc_8 = width;
            }
            if (_loc_6)
            {
                param1.fillRect(param1.rect, 0);
            }
            _loc_9 = _loc_4;
            while (_loc_9 < _loc_7)
            {
                
                _loc_11 = background[_loc_9];
                _loc_12 = forground[_loc_9];
                ashift = _loc_9 << 4;
                _loc_10 = _loc_5;
                while (_loc_10 < _loc_8)
                {
                    
                    point.x = (_loc_10 << 4) + param2;
                    point.y = ashift + param3;
                    if (_loc_12[_loc_10] != 0)
                    {
                    }
                    else
                    {
                        param1.copyPixels(ItemManager.bmdBricks[_loc_11[_loc_10]], rect16x16, point);
                    }
                    _loc_10 = _loc_10 + 1;
                }
                _loc_9 = _loc_9 + 1;
            }
            _loc_9 = _loc_4;
            while (_loc_9 < _loc_7)
            {
                
                _loc_11 = background[_loc_9];
                _loc_13 = decoration[_loc_9];
                _loc_12 = forground[_loc_9];
                ashift = _loc_9 << 4;
                _loc_10 = _loc_5;
                while (_loc_10 < _loc_8)
                {
                    
                    point.x = (_loc_10 << 4) + param2;
                    point.y = ashift + param3;
                    type = _loc_12[_loc_10];
                    if (type != 0)
                    {
                        param1.copyPixels(ItemManager.bmdBricks[type], rect18x18, point);
                    }
                    else
                    {
                        type = _loc_13[_loc_10];
                        if (type == 0)
                        {
                        }
                        else
                        {
                            switch(type)
                            {
                                case 23:
                                {
                                    if (this.hideRed)
                                    {
                                        ItemManager.sprDoors.frame = 0;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                        break;
                                    }
                                    break;
                                }
                                case 26:
                                {
                                    if (this.hideRed)
                                    {
                                        ItemManager.sprDoors.frame = 3;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                        break;
                                    }
                                    break;
                                }
                                case 24:
                                {
                                    if (this.hideGreen)
                                    {
                                        ItemManager.sprDoors.frame = 1;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                        break;
                                    }
                                    break;
                                }
                                case 27:
                                {
                                    if (this.hideGreen)
                                    {
                                        ItemManager.sprDoors.frame = 4;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                        break;
                                    }
                                    break;
                                }
                                case 25:
                                {
                                    if (this.hideBlue)
                                    {
                                        ItemManager.sprDoors.frame = 2;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                        break;
                                    }
                                    break;
                                }
                                case 28:
                                {
                                    if (this.hideBlue)
                                    {
                                        ItemManager.sprDoors.frame = 5;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                        break;
                                    }
                                    break;
                                }
                                case ItemId.TIMEDOOR:
                                {
                                    ItemManager.sprDoorsTime.frame = Math.min((this.offset - this.hideTimedoorOffset) / 30 >> 0, 4) + (this._hideTimedoor ? (5) : (0));
                                    ItemManager.sprDoorsTime.drawPoint(param1, point);
                                    break;
                                }
                                case ItemId.TIMEGATE:
                                {
                                    ItemManager.sprDoorsTime.frame = Math.min((this.offset - this.hideTimedoorOffset) / 30 >> 0, 4) + (this._hideTimedoor ? (0) : (5));
                                    ItemManager.sprDoorsTime.drawPoint(param1, point);
                                    break;
                                }
                                case ItemId.COINDOOR:
                                {
                                    if (this.getCoinValue(_loc_10, _loc_9) <= this.player.coins)
                                    {
                                        ItemManager.sprDoors.frame = 6;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                    }
                                    else
                                    {
                                        ItemManager.sprCoinDoors.frame = this.getCoinValue(_loc_10, _loc_9) - this.player.coins;
                                        ItemManager.sprCoinDoors.drawPoint(param1, point);
                                    }
                                    break;
                                }
                                case ItemId.COINGATE:
                                {
                                    if (this.getCoinValue(_loc_10, _loc_9) <= this.player.coins)
                                    {
                                        ItemManager.sprDoors.frame = 7;
                                        ItemManager.sprDoors.drawPoint(param1, point);
                                    }
                                    else
                                    {
                                        ItemManager.sprCoinGates.frame = this.getCoinValue(_loc_10, _loc_9) - this.player.coins;
                                        ItemManager.sprCoinGates.drawPoint(param1, point);
                                    }
                                    break;
                                }
                                case 83:
                                {
                                    if (musicBlinkLookup[_loc_10 + "x" + _loc_9] != null)
                                    {
                                        ItemManager.sprDrumsBlink.frame = musicBlinkLookup[_loc_10 + "x" + _loc_9] / 5 << 0;
                                        ItemManager.sprDrumsBlink.drawPoint(param1, point);
                                        var _loc_15:* = musicBlinkLookup;
                                        var _loc_16:* = _loc_10 + "x" + _loc_9;
                                        _loc_15[_loc_16] = musicBlinkLookup[_loc_10 + "x" + _loc_9] - 1;
                                        if (!musicBlinkLookup[_loc_10 + "x" + _loc_9]--)
                                        {
                                            delete musicBlinkLookup[_loc_10 + "x" + _loc_9];
                                        }
                                        break;
                                    }
                                    break;
                                }
                                case 77:
                                {
                                    if (musicBlinkLookup[_loc_10 + "x" + _loc_9] != null)
                                    {
                                        ItemManager.sprPianoBlink.frame = musicBlinkLookup[_loc_10 + "x" + _loc_9] / 5 << 0;
                                        ItemManager.sprPianoBlink.drawPoint(param1, point);
                                        var _loc_15:* = musicBlinkLookup;
                                        var _loc_16:* = _loc_10 + "x" + _loc_9;
                                        _loc_15[_loc_16] = musicBlinkLookup[_loc_10 + "x" + _loc_9] - 1;
                                        if (!musicBlinkLookup[_loc_10 + "x" + _loc_9]--)
                                        {
                                            delete musicBlinkLookup[_loc_10 + "x" + _loc_9];
                                        }
                                        break;
                                    }
                                    break;
                                }
                                case 110:
                                {
                                    if (Bl.data.canEdit)
                                    {
                                        ItemManager.sprCoinShadow.frame = ((this.offset >> 0) + _loc_10 + _loc_9) % 12;
                                        ItemManager.sprCoinShadow.drawPoint(param1, point);
                                    }
                                    break;
                                }
                                case 111:
                                {
                                    if (Bl.data.canEdit)
                                    {
                                        ItemManager.sprBonusCoinShadow.frame = ((this.offset >> 0) + _loc_10 + _loc_9) % 12;
                                        ItemManager.sprBonusCoinShadow.drawPoint(param1, point);
                                    }
                                    break;
                                }
                                case 242:
                                {
                                    _loc_14 = this.getPortal(_loc_10, _loc_9);
                                    ItemManager.sprPortal.frame = _loc_14.rotation * 15 + ((this.offset / 1.5 >> 0) + _loc_10 + _loc_9) % 15 + 1;
                                    ItemManager.sprPortal.drawPoint(param1, point);
                                    break;
                                }
                                case ItemId.DIAMOND:
                                {
                                    ItemManager.sprDiamond.frame = ((this.offset / 5 >> 0) + _loc_10 + _loc_9) % 13;
                                    ItemManager.sprDiamond.drawPoint(param1, point);
                                    break;
                                }
                                case ItemId.CAKE:
                                {
                                    ItemManager.sprCake.frame = ((this.offset / 5 >> 0) + _loc_10 + _loc_9) % 5;
                                    ItemManager.sprCake.drawPoint(param1, point);
                                    break;
                                }
                                case 50:
                                {
                                    if (this.showAllSecrets || knownSecrets[_loc_10 + "x" + _loc_9])
                                    {
                                        ItemManager.sprSecret.frame = 0;
                                        ItemManager.sprSecret.drawPoint(param1, point);
                                    }
                                    break;
                                }
                                case 243:
                                {
                                    if (this.showAllSecrets || knownSecrets[_loc_10 + "x" + _loc_9])
                                    {
                                        ItemManager.sprSecret.frame = 1;
                                        ItemManager.sprSecret.drawPoint(param1, point);
                                    }
                                    else
                                    {
                                        ItemManager.bricks[44].drawTo(param1, (_loc_10 << 4) + param2, (_loc_9 << 4) + param3);
                                    }
                                    break;
                                }
                                case 1000:
                                {
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            param1.copyPixels(ItemManager.bmdBricks[type], rect18x18, point);
                        }
                    }
                    _loc_10 = _loc_10 + 1;
                }
                _loc_9 = _loc_9 + 1;
            }
            return;
        }// end function

        final public function postDraw(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:Vector.<int> = null;
            var _loc_4:* = (-param3) / size;
            var _loc_5:* = (-param2) / size;
            if (_loc_4 < 0)
            {
                _loc_4 = 0;
            }
            if (_loc_5 < 0)
            {
                _loc_5 = 0;
            }
            var _loc_6:* = _loc_4 + Bl.height / size + 1;
            var _loc_7:* = _loc_5 + Bl.width / size + 1;
            if (_loc_6 > height)
            {
                _loc_6 = height;
            }
            if (_loc_7 > width)
            {
                _loc_7 = width;
            }
            _loc_8 = _loc_4;
            while (_loc_8 < _loc_6)
            {
                
                _loc_10 = above[_loc_8];
                ashift = _loc_8 << 4;
                _loc_9 = _loc_5;
                while (_loc_9 < _loc_7)
                {
                    
                    type = _loc_10[_loc_9];
                    point.x = (_loc_9 << 4) + param2;
                    point.y = ashift + param3;
                    switch(type)
                    {
                        case 0:
                        {
                            break;
                        }
                        default:
                        {
                            param1.copyPixels(ItemManager.bmdBricks[type], rect18x18, point);
                            break;
                        }
                        case 101:
                        {
                            ItemManager.sprCoin.frame = ((this.offset >> 0) + _loc_9 + _loc_8) % 12;
                            ItemManager.sprCoin.drawPoint(param1, point);
                            break;
                        }
                        case ItemId.WAVE:
                        {
                            ItemManager.sprBonusCoin.frame = ((this.offset >> 0) + _loc_9 + _loc_8) % 12;
                            ItemManager.sprBonusCoin.drawPoint(param1, point);
                            break;
                        }
                        case ItemId.WATER:
                        {
                            ItemManager.sprWave.frame = (this.offset / 5 >> 0) % 8;
                            ItemManager.sprWave.drawPoint(param1, point);
                            break;
                        }
                        case :
                        {
                            if (waterOffset[_loc_9 + "x" + _loc_8])
                            {
                                var _loc_11:* = waterOffset;
                                var _loc_12:* = _loc_9 + "x" + _loc_8;
                                var _loc_13:* = waterOffset[_loc_9 + "x" + _loc_8] + 1;
                                _loc_11[_loc_12] = _loc_13;
                                if (waterOffset[_loc_9 + "x" + _loc_8] % 25 == 0)
                                {
                                    waterOffset[_loc_9 + "x" + _loc_8] = 0;
                                }
                            }
                            else if (Math.random() < 0.001)
                            {
                                waterOffset[_loc_9 + "x" + _loc_8] = Math.floor(Math.random() * 4) * 25 + 5;
                            }
                            ItemManager.sprWater.frame = ((waterOffset[_loc_9 + "x" + _loc_8] / 5 || 0) >> 0) % 99;
                            ItemManager.sprWater.drawPoint(param1, point);
                            break;
                            break;
                        }
                    }
                    _loc_9++;
                }
                _loc_8++;
            }
            this.labelcontainer.draw(param1, param2, param3);
            return;
        }// end function

        public function reset() : void
        {
            bmd.dispose();
            realmap = null;
            background = null;
            decoration = null;
            forground = null;
            above = null;
            return;
        }// end function

    }
}

class portal extends Object
{
    private var _rotation:int = 0;
    public var target:int = 0;
    public var id:int = 0;

    function portal(param1:int, param2:int, param3:int) : void
    {
        this._rotation = param1;
        this.id = param2;
        this.target = param3;
        return;
    }// end function

    public function get rotation() : int
    {
        return this._rotation;
    }// end function

    public function set rotation(param1:int) : void
    {
        if (param1 >= 4)
        {
            param1 = param1 - 4;
        }
        if (param1 < 0)
        {
            param1 = param1 + 4;
        }
        this._rotation = param1;
        return;
    }// end function

}

