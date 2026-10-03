package ui.shop
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.events.*;

    public class ButtonBuy extends assets_buybutton
    {
        public var loadergx:ShopButtonLoader;

        public function ButtonBuy(param1:int)
        {
            stop();
            this.loadergx = new ShopButtonLoader();
            addChild(this.loadergx);
            this.mouseEnabled = true;
            mouseChildren = false;
            buttonMode = true;
            tf_cost.text = "" + param1;
            addEventListener(MouseEvent.MOUSE_OVER, this.handleMouse, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.handleMouse, false, 0, true);
            return;
        }// end function

        override public function set mouseEnabled(param1:Boolean) : void
        {
            this.loadergx.visible = !param1;
            super.mouseEnabled = param1;
            return;
        }// end function

        protected function handleMouse(event:MouseEvent) : void
        {
            this.setGlow(event.type == MouseEvent.MOUSE_OVER ? (20) : (0));
            return;
        }// end function

        public function showAsDollars() : void
        {
            gotoAndStop(2);
            return;
        }// end function

        public function setGlow(param1:Number) : void
        {
            TweenMax.to(this, 1 / 15, {glowFilter:{alpha:1, color:10223872, blurX:param1, blurY:param1, strength:2}, ease:Linear.easeNone});
            return;
        }// end function

    }
}
