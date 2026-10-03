package ui.profile
{
    import SynchronizedSprite.*;
    import flash.display.*;
    import flash.geom.*;

    public class FriendSmiley extends SynchronizedSprite
    {

        public function FriendSmiley(param1:BitmapData)
        {
            super(param1);
            size = 16;
            width = 16;
            height = 26;
            frames = param1.width / size;
            return;
        }// end function

        public function getAsBitmap(param1:uint = 1) : Bitmap
        {
            var _loc_2:* = new BitmapData(width, height);
            draw(_loc_2, 0, 0);
            var _loc_3:* = new BitmapData(_loc_2.width * param1, _loc_2.height * param1, true, 0);
            var _loc_4:* = new Matrix();
            new Matrix().scale(param1, param1);
            _loc_3.draw(_loc_2, _loc_4);
            var _loc_5:* = new Bitmap(_loc_3);
            new Bitmap(_loc_3).smoothing = false;
            _loc_5.pixelSnapping = PixelSnapping.NEVER;
            return _loc_5;
        }// end function

    }
}
