package ui.shop
{
    import com.greensock.*;
    import com.greensock.easing.*;

    public class ShopItemBg extends assets_shopitembg
    {
        private var default_width:Number;
        private var default_height:Number;
        private static const BORDER_STROKE:int = 1;
        private static const TWEEN_METHOD:Function = Back.easeOut;

        public function ShopItemBg(param1:Number, param2:Number)
        {
            this.default_width = param1;
            this.default_height = param2;
            mouseEnabled = true;
            mouseChildren = false;
            this.setSize(this.default_width, this.default_height, 0, false);
            return;
        }// end function

        public function setSize(param1:Number, param2:Number, param3:Number = 0.4, param4:Boolean = true) : void
        {
            TweenMax.to(bg, param3, {width:param1 - BORDER_STROKE * 2, height:param2 - BORDER_STROKE * 2, ease:TWEEN_METHOD});
            TweenMax.to(border, param3, {width:param1, height:param2, ease:TWEEN_METHOD});
            if (param4)
            {
                TweenMax.to(this, param3, {x:(-(param1 - this.default_width)) / 2, y:(-(param2 - this.default_height)) / 2, ease:TWEEN_METHOD});
            }
            else
            {
                var _loc_5:int = 0;
                y = 0;
                x = _loc_5;
            }
            return;
        }// end function

        public function set dropshadow(param1:Boolean) : void
        {
            TweenMax.to(this, 0.4, {dropShadowFilter:param1 ? ({color:0, alpha:1, blurX:40, blurY:40, distance:0, strength:2}) : ({blurX:0, blurY:0, remove:true}), overwrite:0});
            return;
        }// end function

    }
}
