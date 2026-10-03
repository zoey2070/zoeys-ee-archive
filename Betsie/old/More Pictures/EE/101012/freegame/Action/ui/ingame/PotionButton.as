package ui.ingame
{
    import flash.display.*;
    import flash.geom.*;
    import ui2.*;

    public class PotionButton extends ui2potionbtn
    {
        private var bmd:BitmapData;
        private var smileybmd:BitmapData;

        public function PotionButton(param1:BitmapData)
        {
            this.bmd = new BitmapData(16, 24, true, 0);
            this.smileybmd = param1;
            var _loc_2:* = new Bitmap(this.bmd);
            addChild(_loc_2);
            _loc_2.x = 6;
            _loc_2.y = 10 - 6;
            this.setSelectedPotion(0);
            return;
        }// end function

        public function setSelectedPotion(param1:int) : void
        {
            this.bmd.copyPixels(this.smileybmd, new Rectangle(param1 * 16, 0, 16, 24), new Point(0, 0));
            return;
        }// end function

    }
}
