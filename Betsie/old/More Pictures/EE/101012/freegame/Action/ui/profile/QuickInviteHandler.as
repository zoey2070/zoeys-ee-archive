package ui.profile
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import items.*;
    import playerio.*;
    import sample.ui.components.*;

    public class QuickInviteHandler extends Sprite
    {
        protected var img_ee:Class;
        protected var img_kongregate:Class;
        protected var img_armor:Class;
        private var inviteid:String;
        private var block:Boolean;
        private var base:Box;
        private var content:Box;
        private var btn_ee:Box;
        private var btn_kongregate:Box;
        private var btn_armorgames:Box;

        public function QuickInviteHandler(param1:String, param2:Boolean = false)
        {
            var _loc_3:Box = null;
            var _loc_4:Box = null;
            var _loc_5:FriendSmiley = null;
            var _loc_6:Bitmap = null;
            var _loc_7:Box = null;
            this.img_ee = QuickInviteHandler_img_ee;
            this.img_kongregate = QuickInviteHandler_img_kongregate;
            this.img_armor = QuickInviteHandler_img_armor;
            this.base = new Box();
            this.content = new Box();
            this.block = param2;
            this.inviteid = param1;
            this.base.margin(10, 0, 0, 0);
            this.base.add(new Box().fill(2236962, 0.8, 10).margin(5, 5, 5, 5).add(this.content));
            this.base.filters = [new GlowFilter(0, 1, 20, 20, 2)];
            addChild(this.base);
            PlayerIO.quickConnect.simpleConnect(Global.stage, Config.playerio_game_id, "guest", "guest", this.handleConnectedToService, this.handleError);
            if (param2)
            {
                this.content.margin(0, 0, 0, 0);
                this.content.addChild(new Box().add(new Label("You will no longer recieve emails from Everybody Edits", 20, "center", 16777215, false, "system")));
            }
            else
            {
                if (Global.sharedCookie.data.inviteid)
                {
                    Global.sharedCookie.data.inviteid = Global.sharedCookie.data.inviteid + ("," + param1);
                }
                else
                {
                    Global.sharedCookie.data.inviteid = param1;
                }
                this.content.margin(40);
                _loc_3 = new Box();
                _loc_3.margin(20, 0, 0, 0);
                _loc_3.fill(3355443, 1, 10);
                _loc_3.width = 615;
                _loc_3.height = 390;
                _loc_3.filters = [new GlowFilter(0, 0.3, 20, 20, 2)];
                this.content.add(_loc_3);
                _loc_4 = new Box();
                _loc_4.margin(0, NaN, NaN, NaN);
                _loc_5 = new FriendSmiley(ItemManager.smiliesBMD);
                _loc_5.frame = 0;
                _loc_6 = _loc_5.getAsBitmap(2);
                _loc_4.addChild(_loc_6);
                _loc_3.add(_loc_4);
                _loc_3.add(new Box().margin(65, 0, 0, 0).add(new Label("The friend request is now activated.\nPlease log into Everybody Edits to view it:", 15, "center", 16777215, false, "system")));
                this.btn_ee = new Box().margin(0, 0, 0, 0).add(new Box().add(new Label("Play on:", 10, "center", 16777215, false, "system")), new Box().add(new this.img_ee()));
                this.btn_ee.buttonMode = true;
                this.btn_ee.mouseEnabled = true;
                this.btn_ee.mouseChildren = false;
                this.btn_ee.useHandCursor = true;
                this.btn_kongregate = new Box().margin(0, 0, 0, 0).add(new Box().add(new Label("Play on:", 10, "center", 16777215, false, "system")), new Box().margin(15).add(new this.img_kongregate()));
                this.btn_armorgames = new Box().margin(0, 0, 0, 0).add(new Box().add(new Label("Play on:", 10, "center", 16777215, false, "system")), new Box().margin(15).add(new this.img_armor()));
                var _loc_8:* = [new DropShadowFilter(3, 45, 0, 0.4, 10, 10)];
                this.btn_armorgames.filters = [new DropShadowFilter(3, 45, 0, 0.4, 10, 10)];
                this.btn_kongregate.filters = _loc_8;
                var _loc_8:Boolean = true;
                this.btn_armorgames.buttonMode = true;
                this.btn_kongregate.buttonMode = _loc_8;
                var _loc_8:Boolean = true;
                this.btn_armorgames.mouseEnabled = true;
                this.btn_kongregate.mouseEnabled = _loc_8;
                var _loc_8:Boolean = false;
                this.btn_armorgames.mouseChildren = false;
                this.btn_kongregate.mouseChildren = _loc_8;
                var _loc_8:Boolean = true;
                this.btn_armorgames.useHandCursor = true;
                this.btn_kongregate.useHandCursor = _loc_8;
                _loc_7 = new Box().margin(0, 0, 0, 0);
                _loc_7.add();
                _loc_7.width = 615;
                _loc_7.height = 400;
                _loc_7.add(new Box().margin(0, NaN, NaN, NaN).add(this.btn_ee));
                _loc_7.add(new Box().margin(this.btn_ee.height + 15, NaN, NaN, NaN).add(new Box().add(this.btn_armorgames, new Box().margin(NaN, NaN, NaN, this.btn_kongregate.width + 20).add(this.btn_kongregate))));
                _loc_3.add(new Box().margin(130, 0, 0, 0).add(_loc_7));
                _loc_7.addEventListener(MouseEvent.MOUSE_DOWN, this.handleButton, false, 0, true);
                _loc_7.addEventListener(MouseEvent.MOUSE_OVER, this.handleButtonState, false, 0, true);
                _loc_7.addEventListener(MouseEvent.MOUSE_OUT, this.handleButtonState, false, 0, true);
            }
            var _loc_8:* = this.base;
            var _loc_9:* = this.base.height + 1;
            _loc_8.height = _loc_9;
            this.handleResize();
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            return;
        }// end function

        protected function handleButtonState(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function handleButton(event:MouseEvent) : void
        {
            var _loc_2:String = "";
            switch(event.target)
            {
                case this.btn_ee:
                {
                    _loc_2 = "http://everybodyedits.com/";
                    break;
                }
                case this.btn_kongregate:
                {
                    _loc_2 = "http://www.kongregate.com/games/QRious/everybody-edits/";
                    break;
                }
                case this.btn_armorgames:
                {
                    _loc_2 = "http://armorgames.com/play/11986/everybody-edits";
                    break;
                }
                default:
                {
                    break;
                }
            }
            navigateToURL(new URLRequest(_loc_2), "_top");
            return;
        }// end function

        private function handleConnectedToService(param1:Client) : void
        {
            if (Config.use_debug_server)
            {
                param1.multiplayer.developmentServer = Config.developer_server;
            }
            var _loc_2:Object = {inviteid:this.inviteid, block:this.block};
            param1.multiplayer.createJoinRoom("$service-room$", Config.server_type_blacklistroom, false, {}, _loc_2, this.handleConnected, this.handleError);
            return;
        }// end function

        private function handleConnected(param1:Connection) : void
        {
            return;
        }// end function

        private function handleError(param1:PlayerIOError) : void
        {
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            stage.addEventListener(Event.RESIZE, this.handleResize);
            this.handleResize();
            return;
        }// end function

        private function handleResize(event:Event = null) : void
        {
            if (stage != null)
            {
                this.base.x = 0;
                this.base.y = 0;
                this.base.width = Global.width - 20;
                this.base.height = Global.height - 20;
            }
            return;
        }// end function

    }
}
