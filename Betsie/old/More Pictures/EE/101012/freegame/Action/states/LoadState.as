package states
{
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;

    public class LoadState extends BlState
    {
        protected var loading:Class;
        protected var image:BitmapData;
        protected var color:Number = 0;
        protected var modifier:Number = 0.05;
        protected var callback:Function;
        protected var flakes:Array;
        protected var timer:int = 0;

        public function LoadState()
        {
            this.loading = LoadState_loading;
            this.image = new this.loading().bitmapData;
            this.flakes = [];
            Global.stage.frameRate = 20;
            return;
        }// end function

        override public function enterFrame() : void
        {
            var _loc_1:String = this;
            var _loc_2:* = this.timer + 1;
            _loc_1.timer = _loc_2;
            if (Bl.isMouseJustPressed && this.timer > 10 && !Global.playing_on_armorgames && !Global.playing_on_playedonline && !Global.playing_on_kongregate)
            {
                if (!Global.player_is_beta_member)
                {
                    navigateToURL(new URLRequest("http://everybodyedits.com"), "_blank");
                }
            }
            super.enterFrame();
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            this.color = this.color + this.modifier;
            if (this.color > 1)
            {
                this.color = 1;
            }
            param1.copyPixels(this.image, this.image.rect, new Point(0, 0));
            param1.colorTransform(param1.rect, new ColorTransform(1, 1, 1, this.color));
            if (this.color < 0 && this.callback != null)
            {
                this.callback();
                this.callback = null;
            }
            super.draw(param1, param2, param3);
            return;
        }// end function

        public function fadeOut(param1:Function) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.flakes.length)
            {
                
                this.flakes[_loc_2].fade();
                _loc_2++;
            }
            this.color = 1;
            this.modifier = -0.05;
            this.callback = param1;
            return;
        }// end function

    }
}
