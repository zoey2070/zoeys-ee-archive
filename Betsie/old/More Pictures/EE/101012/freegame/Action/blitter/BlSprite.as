package blitter
{
    import flash.display.*;
    import flash.geom.*;

    public class BlSprite extends BlObject
    {
        public var rect:Rectangle;
        public var bmd:BitmapData;
        protected var frames:int;
        protected var bmdAlpha:BitmapData;
        private static var dp:Point = new Point();

        public function BlSprite(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int)
        {
            this.bmd = new BitmapData(param4 * param6, param5);
            this.bmd.copyPixels(param1, new Rectangle(param2 * param4, param3 * param5, param4 * param6, param5), new Point(0, 0));
            this.rect = new Rectangle(0, 0, param4, param5);
            this.frames = param6;
            this.width = param4;
            this.height = param5;
            return;
        }// end function

        public function addShadow(param1:Boolean = false) : void
        {
            width = width + 4;
            height = height + 4;
            this.rect = new Rectangle(0, 0, width, height);
            var _loc_2:* = new BitmapData(width, height, true, 0);
            var _loc_3:* = new Matrix();
            _loc_3.translate(2, 2);
            _loc_2.draw(this.bmd, _loc_3, new ColorTransform(0, 0, 0, 0.22, 0, 0, 0, 0));
            _loc_2.draw(this.bmd);
            this.bmd = _loc_2;
            return;
        }// end function

        public function set frame(param1:int) : void
        {
            this.rect.x = param1 * width;
            return;
        }// end function

        public function get frame() : int
        {
            return this.rect.x / width;
        }// end function

        public function hitTest(param1:int, param2:int) : Boolean
        {
            return param1 >= x && param2 >= y && param1 <= x + width && param2 <= y + height;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            dp.x = param2 + x;
            dp.y = param3 + y;
            param1.copyPixels(this.bmd, this.rect, dp);
            return;
        }// end function

        public function drawPoint(param1:BitmapData, param2:Point) : void
        {
            param1.copyPixels(this.bmd, this.rect, param2);
            return;
        }// end function

        public static function createFromBitmapData(param1:BitmapData) : BlSprite
        {
            return new BlSprite(param1, 0, 0, param1.width, param1.height, 1);
        }// end function

    }
}
