package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import playerio.*;

    public class RegisterWindow extends asset_registerwindow
    {
        private var defaulttext:Object;
        private var displayAsPassword:Object;
        private var lock_overlay:Sprite;
        public var chosen_name:String;

        public function RegisterWindow()
        {
            this.defaulttext = {};
            this.displayAsPassword = {};
            Global.base.getRPCConnection(function () : void
            {
                return;
            }// end function
            );
            filters = [new DropShadowFilter(0, 45, 0, 1, 40, 40, 1, 1)];
            this.lock_overlay = new Sprite();
            this.lock_overlay.graphics.beginFill(0, 0);
            this.lock_overlay.graphics.drawRect(0, 0, this.width, height);
            this.lock_overlay.mouseEnabled = true;
            this.lock_overlay.visible = false;
            addChild(this.lock_overlay);
            this.defaulttext[inpemail.name] = inpemail.text;
            this.defaulttext[inppassword.name] = inppassword.text;
            this.defaulttext[inppassword2.name] = inppassword2.text;
            this.defaulttext[inpname.name] = inpname.text;
            this.displayAsPassword[inpemail.name] = false;
            this.displayAsPassword[inppassword.name] = true;
            this.displayAsPassword[inppassword2.name] = true;
            this.displayAsPassword[inpname.name] = false;
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            inpemail.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inpemail.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inpemail.tabIndex = 2;
            inppassword.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inppassword.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inppassword.tabIndex = 3;
            inppassword2.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inppassword2.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inppassword2.tabIndex = 4;
            inpname.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inpname.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inpname.addEventListener(KeyboardEvent.KEY_UP, this.handleUsername, false, 0, true);
            inpname.tabIndex = 1;
            inpname.maxChars = 20;
            inpname.restrict = "0-9A-Z";
            return;
        }// end function

        override public function get width() : Number
        {
            return 590;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = param1;
            return;
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
            if (inppassword2.text == this.defaulttext[inppassword2.name])
            {
                bg_password2.gotoAndStop(2);
            }
            if (inpname.text == this.defaulttext[inpname.name])
            {
                bg_name.gotoAndStop(2);
            }
            return bg_mail.currentFrame == 2 || bg_password.currentFrame == 2 || bg_password2.currentFrame == 2 || bg_name.currentFrame == 2;
        }// end function

        protected function handleUsername(event:KeyboardEvent) : void
        {
            var username:String;
            var event:* = event;
            username = inpname.text;
            errors.text = "";
            bg_name.gotoAndStop(1);
            var pattern:* = /[^0-9A-Z]""[^0-9A-Z]/;
            if (pattern.test(username))
            {
                bg_name.gotoAndStop(2);
                errors.text = "Your username contains invalid charaters. Valid charaters are 0-9 and A-Z.";
                return;
            }
            if (username.length < 3 || username.length > 20)
            {
                bg_name.gotoAndStop(2);
                errors.text = "Your username must be between 3 and 20 characters long.";
                return;
            }
            Global.base.getRPCConnection(function (param1:Connection) : void
            {
                var con:* = param1;
                con.addMessageHandler("checkUsername", function (param1:Message, param2:String, param3:Boolean) : void
                {
                    if (inpname.text == param2)
                    {
                        if (param3)
                        {
                            chosen_name = param2;
                        }
                        else
                        {
                            chosen_name = null;
                            bg_name.gotoAndStop(2);
                            errors.text = "Username already taken";
                        }
                    }
                    return;
                }// end function
                );
                con.send("checkUsername", username);
                return;
            }// end function
            );
            return;
        }// end function

    }
}
