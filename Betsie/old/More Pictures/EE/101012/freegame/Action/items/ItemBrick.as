package items
{
    import flash.display.*;
    import flash.geom.*;

    public class ItemBrick extends Object
    {
        public var id:int;
        public var payvaultid:String = null;
        public var layer:int;
        public var bmd:BitmapData;
        public var tab:int;
        public var requiresOwnership:Boolean;
        public var requiresAdmin:Boolean;
        public var minimapColor:Number;

        public function ItemBrick(param1:int, param2:int, param3:BitmapData, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:Boolean, param9:Number)
        {
            this.id = param1;
            this.layer = param2;
            this.minimapColor = param9 == -1 ? (generateThumbColor(param3)) : (param9);
            this.bmd = param8 ? (this.drawWithShadow(param3)) : (param3);
            this.payvaultid = param4;
            this.tab = param5;
            this.requiresOwnership = param6;
            this.requiresAdmin = param7;
            return;
        }// end function

        private function drawWithShadow(param1:BitmapData) : BitmapData
        {
            var _loc_2:* = new Rectangle(0, 0, 18, 18);
            var _loc_3:* = new BitmapData(18, 18, true, 0);
            var _loc_4:* = new Matrix();
            new Matrix().translate(2, 2);
            _loc_3.draw(param1, _loc_4, new ColorTransform(0, 0, 0, 0.3, 0, 0, 0, 0));
            _loc_3.draw(param1);
            return _loc_3;
        }// end function

        public function drawTo(param1:BitmapData, param2:int, param3:int) : void
        {
            param1.copyPixels(this.bmd, this.bmd.rect, new Point(param2, param3));
            return;
        }// end function

        private static function generateThumbColor(param1:BitmapData) : uint
        {
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:uint = 0;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            _loc_5 = _loc_5;
            while (_loc_5 < param1.height)
            {
                
                _loc_6 = 0;
                while (_loc_6 < param1.width)
                {
                    
                    _loc_7 = param1.getPixel(_loc_6, _loc_5);
                    _loc_2 = _loc_2 + ((_loc_7 & 16711680) >> 16);
                    _loc_3 = _loc_3 + ((_loc_7 & 65280) >> 8);
                    _loc_4 = _loc_4 + (_loc_7 & 255);
                    _loc_6++;
                }
                _loc_5++;
            }
            _loc_2 = _loc_2 / (param1.width * param1.height);
            _loc_3 = _loc_3 / (param1.width * param1.height);
            _loc_4 = _loc_4 / (param1.width * param1.height);
            return 4278190080 | _loc_2 << 16 | _loc_3 << 8 | _loc_4 << 0;
        }// end function

    }
}
