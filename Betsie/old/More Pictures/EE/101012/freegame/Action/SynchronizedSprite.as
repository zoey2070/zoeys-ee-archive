package 
{
    import SynchronizedSprite.*;
    import flash.display.*;
    import flash.geom.*;

    public class SynchronizedSprite extends SynchronizedObject
    {
        protected var rect:Rectangle;
        protected var bmd:BitmapData;
        protected var size:int;
        protected var frames:int;

        public function SynchronizedSprite(param1:BitmapData)
        {
            this.bmd = param1;
            this.rect = new Rectangle(0, 0, param1.height, param1.height);
            this.size = param1.height;
            this.frames = param1.width / this.size;
            width = this.size;
            height = this.size;
            return;
        }// end function

        public function set frame(param1:int) : void
        {
            this.rect.x = param1 * this.size;
            return;
        }// end function

        public function get frame() : int
        {
            return this.rect.x / this.size;
        }// end function

        public function hitTest(param1:int, param2:int) : Boolean
        {
            return param1 >= x && param2 >= y && param1 <= x + this.size && param2 <= y + this.size;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            param1.copyPixels(this.bmd, this.rect, new Point(x + param2, y + param3));
            return;
        }// end function

    }
}
