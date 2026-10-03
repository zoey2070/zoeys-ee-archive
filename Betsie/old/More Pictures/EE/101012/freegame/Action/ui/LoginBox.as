package ui
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    public class LoginBox extends asset_loginbox
    {
        private var player:Object;
        private var loader:Loader;
        private var vx:int;
        private var vy:int = -236;
        private var vw:int = 488;
        private var vh:int = 274;
        private var unloaded:Boolean = false;

        public function LoginBox()
        {
            var _loc_1:Sprite = null;
            var _loc_2:Sprite = null;
            this.loader = new Loader();
            Security.allowDomain("www.youtube.com");
            if (!Bl.data.isbeta)
            {
                this.vx = (606 - this.vw) / 2;
                this.loader.contentLoaderInfo.addEventListener(Event.INIT, this.onLoaderInit);
                this.loader.load(new URLRequest("http://www.youtube.com/v/K76E20gwFvQ?version=3&autohide=1&modestbranding=1"));
                this.loader.x = this.vx;
                this.loader.y = this.vy;
                _loc_1 = new Sprite();
                _loc_1.graphics.lineStyle(1, 8947848, 1);
                _loc_1.graphics.beginFill(1118481, 0.2);
                _loc_1.graphics.drawRect(0, 0, (this.vw + 1), (this.vh + 1));
                _loc_1.x = this.vx - 1;
                _loc_1.y = this.vy - 1;
                addChild(_loc_1);
                _loc_2 = new Sprite();
                _loc_2.graphics.beginFill(16777215, 1);
                _loc_2.graphics.drawRect(0, 0, this.vw, this.vh);
                _loc_2.x = this.vx;
                _loc_2.y = this.vy;
                this.loader.mask = _loc_2;
                addChild(_loc_2);
            }
            return;
        }// end function

        public function stopAll() : void
        {
            this.unloaded = true;
            if (this.player)
            {
                this.player.stopVideo();
            }
            if (this.loader != null)
            {
                this.loader.unloadAndStop(true);
                this.loader = null;
            }
            return;
        }// end function

        private function onLoaderInit(event:Event) : void
        {
            if (this.unloaded)
            {
                return;
            }
            addChild(this.loader);
            this.loader.content.addEventListener("onReady", this.onPlayerReady);
            this.loader.content.addEventListener("onError", this.onPlayerError);
            this.loader.content.addEventListener("onStateChange", this.onPlayerStateChange);
            this.loader.content.addEventListener("onPlaybackQualityChange", this.onVideoPlaybackQualityChange);
            return;
        }// end function

        private function onPlayerReady(event:Event) : void
        {
            if (this.unloaded)
            {
                return;
            }
            this.player = this.loader.content;
            this.player.mute();
            this.player.playVideo();
            this.player.setSize(this.vw, this.vh);
            return;
        }// end function

        private function onPlayerError(event:Event) : void
        {
            return;
        }// end function

        private function onPlayerStateChange(event:Event) : void
        {
            return;
        }// end function

        private function onVideoPlaybackQualityChange(event:Event) : void
        {
            return;
        }// end function

    }
}
