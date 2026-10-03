package ui.profile
{
    import data.*;
    import flash.display.*;
    import flash.events.*;
    import items.*;
    import playerio.*;
    import sample.ui.components.*;

    public class MyProfile extends Sprite
    {
        private var profile:Box;
        private var profile_smiley:Box;
        private var profilestatus:Label;
        private var smileybitmap:Bitmap;

        public function MyProfile()
        {
            this.profile = new Box();
            this.profile_smiley = new Box();
            this.profile.margin(10, 10, 10, 10);
            this.profile_smiley.margin(0, NaN, NaN, 0);
            this.profile.add(this.profile_smiley);
            var _loc_1:* = Global.playerObject;
            var _loc_2:* = new Label(_loc_1.name.toUpperCase(), 20, "left", _loc_1.isModerator ? (Config.mod_color) : (16777215), false, "system");
            this.profile.add(new Box().margin(0, NaN, NaN, 50).add(_loc_2));
            var _loc_3:* = new Box().margin(_loc_2.height, NaN, NaN, 50);
            var _loc_4:* = new Label("Max Energy: " + (_loc_1.maxEnergy ? (_loc_1.maxEnergy) : ("200")), 12, "left", 16777215, false, "system");
            _loc_3.add(_loc_4);
            this.profile.add(_loc_3);
            var _loc_5:* = new Box().margin(NaN, 0, 0, NaN);
            this.profilestatus = new Label("tmp", 8, "right", 10066329, false, "system");
            this.profilestatus.addEventListener(TextEvent.LINK, this.handleChangeStatus, false, 0, true);
            _loc_5.add(this.profilestatus);
            if (!Global.player_is_guest)
            {
                this.profile.add(_loc_5);
            }
            this.handleRequestCallback(_loc_1.visible);
            this.setSmiley(Global.playerObject.smiley || 0);
            addChild(this.profile);
            return;
        }// end function

        public function setSmiley(param1:int) : void
        {
            if (this.smileybitmap != null)
            {
                this.profile_smiley.removeChild(this.smileybitmap);
            }
            var _loc_2:* = new FriendSmiley(ItemManager.smiliesBMD);
            _loc_2.frame = param1;
            this.smileybitmap = _loc_2.getAsBitmap(2);
            this.smileybitmap.x = 5;
            this.profile_smiley.addChild(this.smileybitmap);
            this.profile_smiley.add();
            return;
        }// end function

        protected function handleChangeStatus(event:TextEvent) : void
        {
            var event:* = event;
            Global.base.requestRemoteMethod("toggleProfile", function (param1:Message) : void
            {
                handleRequestCallback(param1.getBoolean(0));
                return;
            }// end function
            , event.text != "true");
            return;
        }// end function

        private function handleRequestCallback(param1:Boolean) : void
        {
            this.profilestatus.htmlText = "Profile is <u><a href=\'event:" + param1 + "\'>" + (param1 ? ("public") : ("private")) + "</a></u>";
            this.profile.reset();
            return;
        }// end function

        private function handleLogout(event:MouseEvent) : void
        {
            (event.target as MovieClip).removeEventListener(MouseEvent.MOUSE_DOWN, this.handleLogout);
            var _loc_2:* = new NavigationEvent(NavigationEvent.LOGOUT, true, false);
            dispatchEvent(_loc_2);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.profile.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.profile.height = param1;
            return;
        }// end function

    }
}
