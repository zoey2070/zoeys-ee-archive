package ui
{
    import blitter.*;
    import flash.events.*;
    import playerio.*;

    public class LobbyLoginBox extends LobbyLoginBox_Asset
    {
        private var base:EverybodyEdits;
        private var profileVisible:Boolean;

        public function LobbyLoginBox(param1:EverybodyEdits)
        {
            var base:* = param1;
            this.base = base;
            login_btn.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                base.showMainLogin();
                return;
            }// end function
            );
            return;
        }// end function

        private function handleRequestCallback(param1:Boolean) : void
        {
            this.profileVisible = param1;
            if (param1)
            {
                profilestate.htmlText = "Profile is <u><a href=\'event:blank\'>public</a></u>";
            }
            else
            {
                profilestate.htmlText = "Profile is <u><a href=\'event:blank\'>private</a></u>";
            }
            return;
        }// end function

        public function ShowLogout() : void
        {
            var self:LobbyLoginBox;
            gotoAndStop(2);
            this.base.requestRemoteMethod("getProfile", function (param1:Message) : void
            {
                handleRequestCallback(param1.getBoolean(0));
                return;
            }// end function
            );
            profilestate.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                base.requestRemoteMethod("toggleProfile", function (param1:Message) : void
                {
                    handleRequestCallback(param1.getBoolean(0));
                    return;
                }// end function
                , !profileVisible);
                return;
            }// end function
            );
            logininfo.htmlText = "Logged in as " + "<u><a href=\'event:" + Global.playerObject.name + "\'>" + Global.playerObject.name + "</a></u>";
            logininfo.addEventListener(TextEvent.LINK, this.handleLinkClicked, false, 0, true);
            self;
            logout_btn.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                self.parent.removeChild(self);
                base.logout();
                return;
            }// end function
            );
            if (Global.playing_on_armorgames || Global.playing_on_faceboook || Bl.data.iskongregate)
            {
                logout_btn.visible = false;
            }
            return;
        }// end function

        protected function handleLinkClicked(event:TextEvent) : void
        {
            var _loc_2:* = new NavigationEvent(NavigationEvent.SHOW_PROFILE, true);
            _loc_2.username = event.text;
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
