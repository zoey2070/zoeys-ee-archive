package ui.login
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import playerio.*;

    public class LoginWindow extends assets_loginwindow
    {
        private var lock_overlay:Sprite;
        private var defaulttext:Object;
        private var displayAsPassword:Object;

        public function LoginWindow()
        {
            this.defaulttext = {};
            this.displayAsPassword = {};
            filters = [new DropShadowFilter(0, 45, 0, 1, 40, 40, 1, 1)];
            close.addEventListener(MouseEvent.CLICK, this.handleClose, false, 0, true);
            btn_login.addEventListener(MouseEvent.CLICK, this.handleLogin, false, 0, true);
            btn_remember.gotoAndStop(2);
            btn_remember.mouseEnabled = true;
            btn_remember.buttonMode = true;
            btn_remember.mouseChildren = false;
            btn_remember.addEventListener(MouseEvent.CLICK, this.handleRemember, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.lock_overlay = new Sprite();
            this.lock_overlay.graphics.beginFill(0, 0);
            this.lock_overlay.graphics.drawRect(0, 0, this.width, height);
            this.lock_overlay.mouseEnabled = true;
            this.lock_overlay.visible = false;
            addChild(this.lock_overlay);
            this.defaulttext[inpemail.name] = inpemail.text;
            this.defaulttext[inppassword.name] = inppassword.text;
            this.displayAsPassword[inpemail.name] = false;
            this.displayAsPassword[inppassword.name] = true;
            inpemail.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inpemail.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inpemail.tabIndex = 1;
            inppassword.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inppassword.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inppassword.tabIndex = 2;
            return;
        }// end function

        public function hasEmptyFields() : Boolean
        {
            if (inpemail.text == this.defaulttext[inpemail.name])
            {
                bg_mail.gotoAndStop(2);
            }
            if (inppassword.text == this.defaulttext[inppassword.name])
            {
                bg_password.gotoAndStop(2);
            }
            return bg_mail.currentFrame == 2 || bg_password.currentFrame == 2;
        }// end function

        public function lock(param1:Boolean) : void
        {
            this.lock_overlay.visible = param1;
            return;
        }// end function

        protected function handleFocus(event:FocusEvent) : void
        {
            var _loc_2:* = event.target as TextField;
            if (event.type == FocusEvent.FOCUS_IN)
            {
                if (_loc_2.text == this.defaulttext[_loc_2.name])
                {
                    _loc_2.defaultTextFormat = new TextFormat(null, null, 0);
                    _loc_2.displayAsPassword = this.displayAsPassword[_loc_2.name];
                    _loc_2.text = "";
                }
            }
            else if (_loc_2.text == "")
            {
                _loc_2.defaultTextFormat = new TextFormat(null, null, 10066329);
                _loc_2.displayAsPassword = false;
                _loc_2.text = this.defaulttext[_loc_2.name];
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return bg.width;
        }// end function

        protected function handleClose(event:MouseEvent) : void
        {
            Global.base.showMainLogin();
            return;
        }// end function

        protected function handleRemember(event:MouseEvent) : void
        {
            btn_remember.gotoAndStop(btn_remember.currentFrame == 1 ? (2) : (1));
            return;
        }// end function

        protected function handleLogin(event:MouseEvent) : void
        {
            var event:* = event;
            btn_login.visible = false;
            errors.text = "";
            bg_mail.gotoAndStop(1);
            bg_password.gotoAndStop(1);
            if (this.hasEmptyFields())
            {
                errors.text = "Please fill out both email and password.";
                btn_login.visible = true;
                return;
            }
            if (inpemail.text == "guest")
            {
                return;
            }
            PlayerIO.quickConnect.simpleConnect(Bl.stage, Config.playerio_game_id, inpemail.text, inppassword.text, function (param1:Client) : void
            {
                Global.tracker.deleteGuestTracker();
                if (btn_remember.currentFrame == 2)
                {
                    Global.cookie.data.username = inpemail.text;
                    Global.cookie.data.password = inppassword.text;
                    Global.cookie.data.remember = true;
                    Global.cookie.flush();
                }
                else
                {
                    Global.base.cleanCookie();
                }
                if (parent)
                {
                    hide();
                }
                Global.base.disconnectRPC();
                Global.base.simpleConnect(param1);
                return;
            }// end function
            , function (param1:PlayerIOError) : void
            {
                btn_login.visible = true;
                if (param1.message.toString().toLowerCase().indexOf("password") < 0)
                {
                    errors.appendText("Email not registered.");
                    bg_mail.gotoAndStop(2);
                }
                else if (param1.message.toString().toLowerCase().indexOf("password") > 0)
                {
                    errors.appendText("Password incorect");
                    bg_password.gotoAndStop(2);
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function hide() : void
        {
            parent.removeChild(this);
            return;
        }// end function

    }
}
