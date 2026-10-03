package 
{
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;

    public class CoinText extends BlText
    {

        public function CoinText(param1:int, param2:Number, param3:Number = 16777215, param4:String = "left", param5:String = "system")
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            param1.copyPixels(bmd, bmd.rect, new Point(x + param2, y + param3));
            return;
        }// end function

    }
}
