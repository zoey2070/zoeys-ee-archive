package blitter
{
    import flash.display.*;

    public class BlObject extends Object
    {
        public var x:Number = 0;
        public var y:Number = 0;
        public var width:int = 1;
        public var height:int = 1;
        public var moving:Boolean = false;
        public var hitmap:BlTilemap;

        public function BlObject()
        {
            return;
        }// end function

        public function update() : void
        {
            return;
        }// end function

        public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            param1.setPixel(this.x + param2, this.y + param3, 16777215);
            return;
        }// end function

        public function enterFrame() : void
        {
            return;
        }// end function

        public function tick() : void
        {
            this.update();
            return;
        }// end function

        public function exitFrame() : void
        {
            return;
        }// end function

    }
}
