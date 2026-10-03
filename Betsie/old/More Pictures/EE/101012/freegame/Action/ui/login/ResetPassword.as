package ui.login
{
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import playerio.*;

    public class ResetPassword extends assets_resetpassword
    {
        private var defaulttext:Object;

        public function ResetPassword()
        {
            this.defaulttext = {};
            gotoAndStop(1);
            filters = [new DropShadowFilter(0, 45, 0, 1, 40, 40, 1, 1)];
            addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.defaulttext[inpemail.name] = inpemail.text;
            inpemail.addEventListener(FocusEvent.FOCUS_IN, this.handleFocus, false, 0, true);
            inpemail.addEventListener(FocusEvent.FOCUS_OUT, this.handleFocus, false, 0, true);
            close.addEventListener(MouseEvent.CLICK, this.handleClose, false, 0, true);
            btn_send.addEventListener(MouseEvent.CLICK, function () : void
            {
                errors.text = "";
                if (inpemail.text == defaulttext[inpemail.name] || inpemail.text.search("@") < 0)
                {
                    errors.text = "Please fill in an email adress";
                    return;
                }
                PlayerIO.quickConnect.simpleRecoverPassword(Config.playerio_game_id, inpemail.text, function () : void
                {
                    gotoAndStop(2);
                    return;
                }// end function
                , function (param1:PlayerIOError) : void
                {
                    errors.text = param1.message;
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        protected function handleClose(event:MouseEvent) : void
        {
            Global.base.showMainLogin();
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

        override public function get width() : Number
        {
            return bg.width;
        }// end function

    }
}
