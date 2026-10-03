package ui
{
    import flash.display.*;

    public class OverlayContainer extends Sprite
    {

        public function OverlayContainer()
        {
            return;
        }// end function

        override public function get width() : Number
        {
            var _loc_1:Number = 0;
            var _loc_2:* = numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1 = Math.max(_loc_1, getChildAt(_loc_3).width);
                _loc_3++;
            }
            return _loc_1;
        }// end function

    }
}
