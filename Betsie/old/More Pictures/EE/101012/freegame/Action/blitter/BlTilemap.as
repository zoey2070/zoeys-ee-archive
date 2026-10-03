package blitter
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import items.*;

    public class BlTilemap extends BlObject
    {
        protected var rect:Rectangle;
        protected var size:int;
        protected var hitOffset:int;
        protected var hitEnd:int;
        public var depth:int = 0;
        protected var bmd:BitmapData;
        protected var realmap:Vector.<Vector.<Vector.<int>>>;
        protected var background:Vector.<Vector.<int>>;
        protected var decoration:Vector.<Vector.<int>>;
        protected var forground:Vector.<Vector.<int>>;
        protected var above:Vector.<Vector.<int>>;

        public function BlTilemap(param1:Bitmap, param2:int = 1, param3:int = 99, param4:int = 121)
        {
            this.bmd = param1.bitmapData;
            this.rect = new Rectangle(0, 0, this.bmd.height, this.bmd.height);
            this.size = this.bmd.height;
            this.hitOffset = param2;
            this.hitEnd = param3;
            return;
        }// end function

        public function setMapArray(param1:Array) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            this.depth = param1.length;
            height = param1[0].length;
            width = param1[0][0].length;
            this.background = new Vector.<Vector.<int>>(height);
            this.decoration = new Vector.<Vector.<int>>(height);
            this.forground = new Vector.<Vector.<int>>(height);
            this.above = new Vector.<Vector.<int>>(height);
            var _loc_2:int = 0;
            while (_loc_2 < height)
            {
                
                this.background[_loc_2] = new Vector.<int>(width);
                this.decoration[_loc_2] = new Vector.<int>(width);
                this.forground[_loc_2] = new Vector.<int>(width);
                this.above[_loc_2] = new Vector.<int>(width);
                _loc_2++;
            }
            this.realmap = new Vector.<Vector.<Vector.<int>>>(this.depth);
            var _loc_3:int = 0;
            while (_loc_3 < this.depth)
            {
                
                this.realmap[_loc_3] = new Vector.<Vector.<int>>(height);
                _loc_4 = 0;
                while (_loc_4 < height)
                {
                    
                    this.realmap[_loc_3][_loc_4] = new Vector.<int>(width);
                    _loc_5 = 0;
                    while (_loc_5 < width)
                    {
                        
                        this.realmap[_loc_3][_loc_4][_loc_5] = param1[_loc_3][_loc_4][_loc_5];
                        this.setMagicTile(_loc_3, _loc_5, _loc_4, param1[_loc_3][_loc_4][_loc_5]);
                        _loc_5++;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function overlaps(param1:BlObject) : int
        {
            return 0;
        }// end function

        protected function setMagicTile(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:ItemBrick = null;
            if (param1 == ItemLayer.BACKGROUND)
            {
                this.background[param3][param2] = param4;
            }
            else
            {
                this.decoration[param3][param2] = 0;
                this.forground[param3][param2] = 0;
                this.above[param3][param2] = 0;
                _loc_5 = ItemManager.bricks[param4];
                if (_loc_5 != null)
                {
                    switch(_loc_5.layer)
                    {
                        case ItemLayer.BACKGROUND:
                        {
                            break;
                        }
                        case ItemLayer.DECORATION:
                        {
                            this.decoration[param3][param2] = param4;
                            break;
                        }
                        case ItemLayer.FORGROUND:
                        {
                            this.forground[param3][param2] = param4;
                            break;
                        }
                        case ItemLayer.ABOVE:
                        {
                            this.above[param3][param2] = param4;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        protected function setTile(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.setMagicTile(param1, param2, param3, param4);
            if (this.realmap[param1] != null)
            {
                if (this.realmap[param1][param3] != null)
                {
                    this.realmap[param1][param3][param2] = param4;
                }
            }
            return;
        }// end function

        public function getTile(param1:int, param2:int, param3:int) : int
        {
            if (param1 < 0 || param1 >= this.depth || param2 < 0 || param2 >= width || param3 < 0 || param3 >= height)
            {
                return 0;
            }
            return this.realmap[param1][param3][param2];
        }// end function

        public function getTypeCount(param1:int) : int
        {
            var _loc_4:int = 0;
            var _loc_5:Vector.<int> = null;
            var _loc_6:int = 0;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < this.realmap.length)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this.realmap[_loc_3].length)
                {
                    
                    _loc_5 = this.realmap[_loc_3][_loc_4];
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5.length)
                    {
                        
                        if (_loc_5[_loc_6] == param1)
                        {
                            _loc_2++;
                        }
                        _loc_6++;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

    }
}
