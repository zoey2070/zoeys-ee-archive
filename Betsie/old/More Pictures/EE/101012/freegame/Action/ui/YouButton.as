package ui
{
    import flash.display.*;
    import flash.geom.*;
    import ui2.*;

    public class YouButton extends ui2youbtn
    {
        private var bmd:BitmapData;
        private var smileybmd:BitmapData;

        public function YouButton(param1:BitmapData)
        {
            this.bmd = new BitmapData(16, 24, true, 0);
            this.smileybmd = param1;
            var _loc_2:* = new Bitmap(this.bmd);
            addChild(_loc_2);
            _loc_2.x = 6;
            _loc_2.y = 10 - 6;
            this.setSelectedSmiley(0);
            return;
        }// end function

        public function setSelectedSmiley(param1:int) : void
        {
            this.bmd.copyPixels(this.smileybmd, new Rectangle(param1 * 16, 0, 16, 24), new Point(0, 0));
            return;
        }// end function

    }
}
