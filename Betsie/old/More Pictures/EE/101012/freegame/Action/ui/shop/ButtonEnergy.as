package ui.shop
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.events.*;

    public class ButtonEnergy extends assets_energybutton
    {
        public var energybar:EnergyBar;
        public var loadergx:ShopButtonLoader;

        public function ButtonEnergy(param1:Number, param2:Number, param3:Number)
        {
            this.loadergx = new ShopButtonLoader();
            this.mouseEnabled = true;
            mouseChildren = false;
            buttonMode = true;
            tf_click.text = "Add " + param1;
            this.energybar = new EnergyBar(param3);
            this.energybar.width = this.width - 6;
            this.energybar.x = 3;
            this.energybar.y = this.height - this.energybar.height;
            this.energybar.setEnergy(param2);
            addChild(this.energybar);
            addChild(this.loadergx);
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

        override public function get height() : Number
        {
            return bg.height;
        }// end function

        override public function get width() : Number
        {
            return bg.width;
        }// end function

        protected function handleMouse(event:MouseEvent) : void
        {
            this.setGlow(event.type == MouseEvent.MOUSE_OVER ? (20) : (0));
            return;
        }// end function

        public function setGlow(param1:Number) : void
        {
            TweenMax.to(this, 1 / 15, {glowFilter:{alpha:1, color:5407646, blurX:param1, blurY:param1, strength:2}, ease:Linear.easeNone});
            return;
        }// end function

        public function setEnergy(param1:Number) : void
        {
            if (param1 > this.energybar.getEnergy())
            {
                this.doAddEnergyAnim(param1 - this.energybar.getEnergy());
            }
            this.energybar.setEnergy(param1);
            return;
        }// end function

        private function doAddEnergyAnim(param1:Number) : void
        {
            var anim:assets_energyadded;
            var num:* = param1;
            anim = new assets_energyadded();
            anim.tf_energy.text = "+" + num;
            anim.x = 40;
            anim.y = 15;
            anim.alpha = 1;
            addChild(anim);
            TweenMax.to(anim, 1, {y:"-40", alpha:0, ease:Sine.easeOut, onComplete:function () : void
            {
                removeChild(anim);
                return;
            }// end function
            });
            return;
        }// end function

    }
}
