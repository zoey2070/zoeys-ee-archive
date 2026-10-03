package ui.login
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import flash.system.*;
    import playerio.*;

    public class MainLogin extends assets_loginsimple
    {
        private var player:Object;
        private var loader:Loader;
        private var unloaded:Boolean = false;
        private var vx:int = 10;
        private var vy:int = 35;
        private var vw:int = 560;
        private var vh:int = 315;
        private var loginwindow:LoginWindow;

        public function MainLogin()
        {
            var armor_auth_token:String;
            var armor_user_id:String;
            this.loader = new Loader();
            stop();
            Security.allowDomain("www.youtube.com");
            filters = [new DropShadowFilter(0, 45, 0, 1, 40, 40, 1, 1)];
            this.loader.contentLoaderInfo.addEventListener(Event.INIT, this.onLoaderInit);
            this.loader.load(new URLRequest("http://www.youtube.com/v/K76E20gwFvQ?version=3&autohide=1&modestbranding=1"));
            this.loader.x = this.vx;
            this.loader.y = this.vy;
            var border:* = new Sprite();
            border.graphics.lineStyle(1, 8947848, 1);
            border.graphics.beginFill(1118481, 0.2);
            border.graphics.drawRect(0, 0, (this.vw + 1), (this.vh + 1));
            border.x = this.vx - 1;
            border.y = this.vy - 1;
            addChild(border);
            var mask:* = new Sprite();
            mask.graphics.beginFill(16777215, 1);
            mask.graphics.drawRect(0, 0, this.vw, this.vh);
            mask.x = this.vx;
            mask.y = this.vy;
            this.loader.mask = mask;
            addChild(mask);
            this.loader.addEventListener(Event.ADDED, this.handleAdded, false, 0, true);
            this.loader.addEventListener(Event.REMOVED, this.handleAdded, false, 0, true);
            if (Global.playing_on_kongregate)
            {
                gotoAndStop(2);
                btn_kongregate.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.base.showKongregateLoginWindow();
                return;
            }// end function
            );
            }
            else if (Global.playing_on_armorgames)
            {
                gotoAndStop(4);
                armor_auth_token = LoaderInfo(Global.stage.root.loaderInfo).parameters.auth_token || Config.armor_authtoken;
                armor_user_id = LoaderInfo(Global.stage.root.loaderInfo).parameters.user_id || Config.armor_userid;
                if (armor_auth_token != null && armor_user_id != null)
                {
                    btn_armorgames.gotoAndStop(2);
                    Global.base.authenticateWithArmorgames(armor_auth_token, armor_user_id, function (param1:Client) : void
            {
                var c:* = param1;
                btn_armorgames.gotoAndStop(3);
                btn_armorgames.buttonMode = true;
                btn_armorgames.mouseEnabled = true;
                btn_armorgames.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
                {
                    Global.base.clearOverlayContainer();
                    Global.base.simpleConnect(c);
                    return;
                }// end function
                );
                return;
            }// end function
            );
                }
                else
                {
                    btn_armorgames.gotoAndStop(1);
                }
            }
            else
            {
                btn_login.addEventListener(MouseEvent.CLICK, this.handleLoginButton, false, 0, true);
                btn_register.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.base.showRegister();
                return;
            }// end function
            );
                btn_recoverpass.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.base.showRecoverPassword();
                return;
            }// end function
            );
                btn_facebook.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.base.fbconnect(true);
                return;
            }// end function
            );
            }
            if (btn_guestlogin != null)
            {
                btn_guestlogin.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.base.clearOverlayContainer();
                Global.base.authenticateAsGuest();
                return;
            }// end function
            );
            }
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            return;
        }// end function

        protected function handleRemovedFromStage(event:Event) : void
        {
            this.stopAll();
            return;
        }// end function

        protected function handleLoginButton(event:MouseEvent) : void
        {
            Global.base.showLoginWindow();
            return;
        }// end function

        protected function handleAdded(event:Event) : void
        {
            event.stopImmediatePropagation();
            event.stopPropagation();
            return;
        }// end function

        override public function get width() : Number
        {
            return bg.width;
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

    }
}
