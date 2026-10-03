package ui.chat
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import io.player.tools.*;
    import playerio.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class SideChat extends Sprite
    {
        protected var CHATBG:Class;
        private var ucontainer:Rows;
        private var userlist:ScrollBox;
        private var ccontainer:Rows;
        private var chatbox:ScrollBox;
        private var labelName:Label;
        private var labelBy:Label;
        private var bg:Sprite;
        private var returntolobbybtn:asset_return_to_lobby;
        private var loginbtn:asset_login_now;
        private var friendsonline:Boolean = false;
        private var myname:String = "";
        private var chats:Array;
        private var users:Object;
        private var names:Object;
        private var guests:Object;

        public function SideChat(param1:Connection)
        {
            var c:* = param1;
            this.CHATBG = SideChat_CHATBG;
            this.ucontainer = new Rows().spacing(0);
            this.ccontainer = new Rows().spacing(0);
            this.labelName = new Label("", 20, "left", 16777215, false, "visitor");
            this.labelBy = new Label("", 12, "left", 11184810, false, "visitor");
            this.bg = new Sprite();
            this.returntolobbybtn = new asset_return_to_lobby();
            this.loginbtn = new asset_login_now();
            this.chats = [];
            this.users = {};
            this.names = {};
            this.guests = {};
            this.returntolobbybtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                Global.base.ShowLobby();
                return;
            }// end function
            );
            this.loginbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                var _loc_1:* = new NavigationEvent(NavigationEvent.LOGOUT, true, false);
                dispatchEvent(_loc_1);
                return;
            }// end function
            );
            c.addMessageHandler("add", function (param1:Message, param2:int, param3:String, param4:int, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:int = 0, param11:Boolean = false) : void
            {
                addUser(param2.toString(), param3, param9, param11);
                return;
            }// end function
            );
            c.addMessageHandler("left", function (param1:Message, param2:int) : void
            {
                removeUser(param2.toString());
                return;
            }// end function
            );
            c.addMessageHandler("updatemeta", function (param1:Message, param2:String, param3:String, param4:int) : void
            {
                setMetaData(param2, param3, param4);
                Global.currentLevelname = param3;
                return;
            }// end function
            );
            c.addMessageHandler("say", function (param1:Message, param2:int, param3:String, param4:Boolean) : void
            {
                if (param3.length > 0)
                {
                    addChat(param2.toString(), param3, param4);
                }
                return;
            }// end function
            );
            c.addMessageHandler("say_old", function (param1:Message, param2:String, param3:String, param4:Boolean) : void
            {
                var _loc_5:* = param4 ? (Config.friend_color_dark) : (Config.default_color_dark);
                addLine(param2, param3, _loc_5);
                return;
            }// end function
            );
            c.addMessageHandler("write", function (param1:Message, param2:String, param3:String) : void
            {
                addLine(param2, param3, 16777215);
                return;
            }// end function
            );
            this.bg.graphics.beginFill(0, 1);
            this.bg.graphics.drawRect(0, 0, 100, 500);
            this.bg.x = 3;
            addChild(this.bg);
            addChild(new this.CHATBG());
            this.userlist = new ScrollBox().margin(1, 1, 1, 1).add(this.ucontainer);
            this.userlist.border(1, 1118481, 1);
            this.userlist.width = Global.width - 640 - 5;
            this.userlist.x = 3;
            this.userlist.y = 30;
            addChild(this.userlist);
            this.chatbox = new ScrollBox().margin(1, 1, 1, 1).add(this.ccontainer);
            this.chatbox.border(1, 1118481, 1);
            this.chatbox.height = 347;
            this.chatbox.x = 3;
            this.chatbox.y = 152;
            addChild(this.chatbox);
            this.labelName.x = 3;
            this.labelName.y = 0;
            addChild(this.labelName);
            this.labelBy.x = 4;
            this.labelBy.y = 15;
            addChild(this.labelBy);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemove);
            return;
        }// end function

        public function handleAttach(event:Event) : void
        {
            stage.addEventListener(Event.RESIZE, this.handleResize);
            this.handleResize();
            return;
        }// end function

        public function handleRemove(event:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, this.handleResize);
            return;
        }// end function

        private function handleResize(event:Event = null) : void
        {
            var _loc_2:int = 0;
            this.bg.width = Global.width - 640;
            this.userlist.width = Global.width - 640 - 5;
            this.chatbox.width = Global.width - 640 - 5;
            if (Global.player_is_guest)
            {
                addChild(this.returntolobbybtn);
                addChild(this.loginbtn);
                _loc_2 = Math.min(Math.max(this.bg.width - 5, 50), 182.25);
                this.returntolobbybtn.width = _loc_2;
                this.returntolobbybtn.height = _loc_2 * 0.12;
                this.returntolobbybtn.x = 5;
                this.returntolobbybtn.y = 120 + 347 + 32 - this.returntolobbybtn.height;
                this.loginbtn.width = _loc_2;
                this.loginbtn.height = _loc_2 * 0.12;
                this.loginbtn.x = 5;
                this.loginbtn.y = 120 + 347 + 32 - this.returntolobbybtn.height - 2 - this.loginbtn.height;
                this.userlist.height = 120 + 347 - this.returntolobbybtn.height - 4 - this.loginbtn.height;
            }
            else
            {
                this.userlist.height = 120;
                if (this.returntolobbybtn && this.returntolobbybtn.parent)
                {
                    this.returntolobbybtn.parent.removeChild(this.returntolobbybtn);
                }
                if (this.loginbtn && this.loginbtn.parent)
                {
                    this.returntolobbybtn.parent.removeChild(this.loginbtn);
                }
            }
            return;
        }// end function

        public function setMe(param1:String, param2:String, param3:Boolean) : void
        {
            this.myname = param2;
            this.addUser(param1, param2, param3);
            this.redrawUserlist();
            return;
        }// end function

        public function setMetaData(param1:String, param2:String, param3:int) : void
        {
            var ownername:* = param1;
            var levelname:* = param2;
            var plays:* = param3;
            Bl.data.roomname = Badwords.Filter(levelname);
            this.labelName.text = Badwords.Filter(levelname);
            Global.setPath("Play " + Badwords.Filter(levelname) + " in Everybody Edits!");
            var labelButton:* = new Sprite();
            if (ownername)
            {
                this.labelBy.text = "By " + ownername + " - " + this.toScoreFormat(plays) + (plays == 1 ? (" play") : (" plays"));
                this.labelBy.setTextFormat(new TextFormat(null, null, 16777215), 3, 3 + ownername.length);
                labelButton.graphics.beginFill(16711935, 0);
                labelButton.graphics.drawRect(0, 0, this.labelBy.width, this.labelBy.height);
                labelButton.x = this.labelBy.x;
                labelButton.y = this.labelBy.y;
                labelButton.buttonMode = true;
                addChild(labelButton);
            }
            else
            {
                this.labelBy.text = this.toScoreFormat(plays) + (plays == 1 ? (" play") : (" plays"));
            }
            labelButton.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                var _loc_2:NavigationEvent = null;
                if (Bl.shiftKey)
                {
                    navigateToURL(new URLRequest("http://everybodyedits.com/profiles/?/" + ownername), "_blank");
                }
                else
                {
                    _loc_2 = new NavigationEvent(NavigationEvent.SHOW_PROFILE, true);
                    _loc_2.username = ownername;
                    dispatchEvent(_loc_2);
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function addChat(param1:String, param2:String, param3:Boolean) : void
        {
            var _loc_4:uint = 0;
            if ((param3 || Global.canchat) && this.users[param1])
            {
                _loc_4 = param3 ? (Config.friend_color) : (Config.default_color);
                this.addLine(this.users[param1].username, param2, _loc_4);
            }
            return;
        }// end function

        public function addLine(param1:String, param2:String, param3:Number) : void
        {
            var _loc_6:Number = NaN;
            param2 = Chat.filter(param2);
            var _loc_4:* = (" " + param2 + " ").replace(/[^a-z0-9 ]""[^a-z0-9 ]/gi, "").toLowerCase().indexOf(" " + this.myname.toLowerCase() + " ") != -1;
            var _loc_5:* = this.chatbox.scrollHeight - this.chatbox.scrollY < 50;
            this.ccontainer.addChild(new ChatEntry(param1, param2, _loc_4 ? (2236962) : (0), param3));
            if (this.ccontainer.numChildren > 50)
            {
                _loc_6 = this.chatbox.scrollHeight;
                this.ccontainer.removeChild(this.ccontainer.getChildAt(0));
                if (!_loc_5)
                {
                    this.chatbox.refresh();
                    this.chatbox.scrollY = this.chatbox.scrollY + (this.chatbox.scrollHeight - _loc_6);
                }
            }
            this.chatbox.refresh();
            if (_loc_5)
            {
                this.chatbox.scrollY = 100000;
            }
            return;
        }// end function

        public function addUser(param1:String, param2:String, param3:Boolean, param4:Boolean = false) : void
        {
            var _loc_5:UserlistItem = null;
            if (this.names[param2] == null)
            {
                _loc_5 = new UserlistItem(param2, param3, param4);
                this.names[param2] = _loc_5;
                this.ucontainer.addChild(_loc_5);
                this.userlist.refresh();
            }
            this.users[param1] = this.names[param2];
            var _loc_6:* = this.names[param2];
            var _loc_7:* = this.names[param2].count + 1;
            _loc_6.count = _loc_7;
            this.redrawUserlist();
            return;
        }// end function

        public function getUsers() : Object
        {
            var _loc_2:String = null;
            var _loc_1:Object = {};
            for (_loc_2 in this.names)
            {
                
                _loc_1[_loc_2.toUpperCase()] = true;
            }
            return _loc_1;
        }// end function

        public function removeUser(param1:String) : void
        {
            if (this.users[param1])
            {
                var _loc_2:* = this.users[param1];
                _loc_2.count = this.users[param1].count - 1;
                if (--this.users[param1].count == 0)
                {
                    delete this.names[this.users[param1].username];
                    this.ucontainer.removeChild(this.users[param1]);
                    this.userlist.refresh();
                }
                delete this.users[param1];
                this.redrawUserlist();
            }
            return;
        }// end function

        private function toScoreFormat(param1:int) : String
        {
            var _loc_2:* = param1.toString().split("");
            var _loc_3:int = 0;
            var _loc_4:* = _loc_2.length;
            while (_loc_4 >= 0)
            {
                
                if (_loc_3 > 0 && _loc_4 > 0 && _loc_3 % 3 == 0)
                {
                    _loc_2.splice(_loc_4, 0, ["."]);
                }
                _loc_3++;
                _loc_4 = _loc_4 - 1;
            }
            return _loc_2.join("");
        }// end function

        private function redrawUserlist() : void
        {
            var x:String;
            var item:UserlistItem;
            var tusers:Array;
            this.friendsonline = true;
            var _loc_2:int = 0;
            var _loc_3:* = this.users;
            while (_loc_3 in _loc_2)
            {
                
                x = _loc_3[_loc_2];
                item = this.users[x];
                this.friendsonline = this.friendsonline && item.isfriend;
                tusers.push(item);
            }
            while (this.ucontainer.numChildren > 0)
            {
                
                this.ucontainer.removeChild(this.ucontainer.getChildAt(0));
            }
            tusers.sort(function (param1:UserlistItem, param2:UserlistItem) : Number
            {
                if (!param1.isfriend && param2.isfriend)
                {
                    return 1;
                }
                if (param1.isfriend && !param2.isfriend)
                {
                    return -1;
                }
                if (param1.isguest && !param2.isguest)
                {
                    return 1;
                }
                if (!param1.isguest && param2.isguest)
                {
                    return -1;
                }
                if (param1.canchat && !param2.canchat)
                {
                    return -1;
                }
                if (!param1.canchat && param2.canchat)
                {
                    return 1;
                }
                return param1.time < param2.time ? (1) : (-1);
            }// end function
            );
            var a:int;
            while (a < tusers.length)
            {
                
                this.ucontainer.addChild(tusers[a]);
                a = (a + 1);
            }
            this.userlist.scrollY = this.userlist.scrollY;
            return;
        }// end function

    }
}
