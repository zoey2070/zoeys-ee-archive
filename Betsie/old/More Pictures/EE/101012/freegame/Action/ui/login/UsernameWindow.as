package ui.login
{
    import flash.events.*;
    import flash.text.*;
    import playerio.*;

    public class UsernameWindow extends assets_username
    {
        private var oncomplete:Function;
        private var defaulttext:Object;
        private var chosen_name:String;
        private var connection:Connection;

        public function UsernameWindow(param1:Function)
        {
            var oncomplete:* = param1;
            this.defaulttext = {};
            this.oncomplete = oncomplete;
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.defaulttext[inpname.name] = inpname.text;
            inpname.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inpname.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            inpname.addEventListener(KeyboardEvent.KEY_UP, this.handleUsername, false, 0, true);
            inpname.maxChars = 20;
            inpname.restrict = "0-9A-Z";
            this.enableOkButton(false);
            btnOk.addEventListener(MouseEvent.CLICK, this.handleOk, false, 0, true);
            return;
        }// end function

        override public function get width() : Number
        {
            return bg.width;
        }// end function

        protected function handleOk(event:MouseEvent) : void
        {
            Global.base.requestRemoteMethod("setUsername", this.onNameSet, this.chosen_name);
            this.enableOkButton(false);
            return;
        }// end function

        private function onNameSet(param1:Message) : void
        {
            Global.base.clearOverlayContainer();
            this.oncomplete();
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
                    _loc_2.text = "";
                }
            }
            else if (_loc_2.text == "")
            {
                _loc_2.defaultTextFormat = new TextFormat(null, null, 10066329);
                _loc_2.text = this.defaulttext[_loc_2.name];
            }
            return;
        }// end function

        protected function handleUsername(event:KeyboardEvent = null) : void
        {
            var event:* = event;
            if (this.connection == null)
            {
                Global.base.getRPCConnection(function (param1:Connection) : void
            {
                connection = param1;
                param1.addMessageHandler("checkUsername", handleUsernameCheck);
                handleUsername();
                return;
            }// end function
            );
            }
            var username:* = inpname.text;
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
            this.connection.send("checkUsername", username);
            return;
        }// end function

        private function handleUsernameCheck(param1:Message, param2:String, param3:Boolean) : void
        {
            if (inpname.text == param2)
            {
                if (param3)
                {
                    this.chosen_name = param2;
                    this.enableOkButton(true);
                }
                else
                {
                    this.chosen_name = null;
                    bg_name.gotoAndStop(2);
                    errors.text = "Username already taken";
                    this.enableOkButton(false);
                }
            }
            return;
        }// end function

        private function enableOkButton(param1:Boolean) : void
        {
            btnOk.gotoAndStop(param1 ? (1) : (2));
            btnOk.mouseEnabled = param1;
            btnOk.mouseChildren = false;
            btnOk.buttonMode = param1;
            return;
        }// end function

    }
}
