package ui.profile
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import io.player.tools.*;
    import items.*;
    import playerio.*;

    public class FriendItem extends asset_friend
    {
        public var type:String;
        public var id:String;
        public var id2:String;
        public var online:Boolean;
        public var onlineInWorld:Boolean;
        private var smileygx:FriendSmiley;
        private var smileybitmap:Bitmap;
        private var smileynum:int;
        private var send_to_mail:String;
        private var smileyholder:MovieClip;
        private var worldid:String;
        private var worldname:String;
        public static const FRIEND:String = "friend";
        public static const CONFIRM:String = "confirm";
        public static const INVITE:String = "invite";
        public static const PENDING:String = "pending";
        public static const INVITATION:String = "invitation";
        public static const INVITATION_DELETED:String = "invitation_deleted";
        public static const BLOCKED:String = "blocked";
        public static const WAITING:String = "waiting";
        public static const RELOAD:String = "reload";
        public static const DELETE:String = "delete";

        public function FriendItem(param1:String, param2:String = "", param3:String = "")
        {
            this.id = param2;
            this.id2 = param3;
            divider.mouseEnabled = false;
            this.smileyholder = new MovieClip();
            this.smileyholder.mouseChildren = false;
            this.smileyholder.mouseEnabled = false;
            this.smileyholder.x = 5;
            addChild(this.smileyholder);
            this.init(param1);
            addEventListener(MouseEvent.MOUSE_OVER, this.handleMouse, false, 0, true);
            return;
        }// end function

        protected function init(param1:String) : void
        {
            this.type = param1;
            gotoAndStop(param1);
            this.height = 55;
            switch(param1)
            {
                case FRIEND:
                {
                    tf_name.text = this.id.toUpperCase();
                    tf_online.text = "";
                    tf_playing.text = "";
                    btn_play.visible = false;
                    btn_delete.visible = false;
                    btn_delete.addEventListener(MouseEvent.MOUSE_DOWN, this.handleDeleteFriend, false, 0, true);
                    this.worldid = "";
                    this.worldname = "";
                    break;
                }
                case CONFIRM:
                {
                    btn_confirmcancel.addEventListener(MouseEvent.MOUSE_DOWN, this.handleCancelDelete, false, 0, true);
                    btn_confirmdelete.addEventListener(MouseEvent.MOUSE_DOWN, this.handleConfirmDelete, false, 0, true);
                    break;
                }
                case INVITE:
                {
                    tf_error.text = "";
                    tf_error.autoSize = TextFieldAutoSize.LEFT;
                    tf_usermail.text = "";
                    btn_send.addEventListener(MouseEvent.MOUSE_DOWN, this.handleSendInvite, false, 0, true);
                    btn_cancel.addEventListener(MouseEvent.MOUSE_DOWN, this.handleCancelInvite, false, 0, true);
                    this.height = 84;
                    break;
                }
                case PENDING:
                {
                    this.send_to_mail = this.id;
                    tf_mail.text = "Pending response:\n" + this.send_to_mail;
                    btn_delete.visible = false;
                    btn_delete.addEventListener(MouseEvent.MOUSE_DOWN, this.handleDeleteInvite, false, 0, true);
                    break;
                }
                case INVITATION:
                {
                    tf_error.text = "";
                    tf_mail.text = this.id.toUpperCase() + " would like to be your friend.";
                    btn_block.addEventListener(MouseEvent.MOUSE_DOWN, this.handleAnswerBlock, false, 0, true);
                    btn_accept.addEventListener(MouseEvent.MOUSE_DOWN, this.handleAnswerInvitation, false, 0, true);
                    btn_ignore.addEventListener(MouseEvent.MOUSE_DOWN, this.handleAnswerInvitation, false, 0, true);
                    break;
                }
                case INVITATION_DELETED:
                {
                    tf_mail.text = "Sorry, the invitation from " + this.id.toUpperCase() + " no longer exist.";
                    btn_ok.addEventListener(MouseEvent.MOUSE_DOWN, this.handleInviteDeletedOk, false, 0, true);
                    break;
                }
                case BLOCKED:
                {
                    tf_message.text = this.id + ":\nIs blocking " + this.id2.toUpperCase();
                    btn_unblock.addEventListener(MouseEvent.MOUSE_DOWN, this.handleUnblock, false, 0, true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            dispatchEvent(new Event(Event.CHANGE, true, false));
            return;
        }// end function

        public function setSmiley(param1:int) : void
        {
            this.smileynum = param1;
            if (this.smileybitmap != null)
            {
                this.smileyholder.removeChild(this.smileybitmap);
            }
            this.smileygx = new FriendSmiley(ItemManager.smiliesBMD);
            this.smileygx.frame = param1;
            this.smileybitmap = this.smileygx.getAsBitmap(2);
            this.smileyholder.addChild(this.smileybitmap);
            return;
        }// end function

        public function setOnlineStatus(param1:Boolean, param2:int, param3:String, param4:String) : void
        {
            var _loc_5:Sprite = null;
            this.onlineInWorld = false;
            this.online = param1;
            if (param1)
            {
                tf_online.text = "Online";
                if (param3 && param4)
                {
                    this.worldid = param3;
                    this.worldname = Badwords.Filter(param4);
                    this.onlineInWorld = true;
                    btn_play.visible = true;
                    btn_play.addEventListener(MouseEvent.MOUSE_DOWN, this.handleJoinWorld, false, 0, true);
                    tf_online.text = tf_online.text + " - Playing in: ";
                    tf_playing.autoSize = TextFieldAutoSize.LEFT;
                    tf_playing.text = this.worldname;
                    _loc_5 = new Sprite();
                    _loc_5.x = tf_playing.x;
                    _loc_5.y = tf_playing.y;
                    _loc_5.graphics.beginFill(0, 0);
                    _loc_5.graphics.drawRect(-3, -3, tf_playing.textWidth + 6, tf_playing.textHeight + 6);
                    addChild(_loc_5);
                    _loc_5.useHandCursor = true;
                    _loc_5.buttonMode = true;
                    _loc_5.addEventListener(MouseEvent.MOUSE_DOWN, this.handleJoinWorld, false, 0, true);
                }
                tf_online.setTextFormat(new TextFormat(null, null, 65280), 0, 6);
            }
            else
            {
                btn_play.visible = false;
                tf_online.text = "Offline";
            }
            this.setSmiley(param2);
            return;
        }// end function

        public function setSendTo(param1:String) : void
        {
            this.send_to_mail = param1;
            return;
        }// end function

        protected function handleJoinWorld(event:MouseEvent) : void
        {
            var _loc_2:* = new NavigationEvent(NavigationEvent.JOIN_WORLD, true, false);
            _loc_2.world_id = this.worldid;
            dispatchEvent(_loc_2);
            return;
        }// end function

        protected function handleDeleteFriend(event:MouseEvent) : void
        {
            this.init(CONFIRM);
            return;
        }// end function

        protected function handleCancelDelete(event:MouseEvent) : void
        {
            this.init(FRIEND);
            this.setOnlineStatus(this.online, this.smileynum, this.worldid, this.worldname);
            return;
        }// end function

        protected function handleConfirmDelete(event:MouseEvent) : void
        {
            gotoAndStop(WAITING);
            Global.base.requestRemoteMethod("deleteFriend", this.handleFriendDeleted, this.id);
            return;
        }// end function

        protected function handleFriendDeleted(param1:Message) : void
        {
            dispatchEvent(new Event(FriendItem.DELETE, true, false));
            parent.removeChild(this);
            return;
        }// end function

        protected function handleDeleteInvite(event:MouseEvent) : void
        {
            gotoAndStop(WAITING);
            Global.base.requestRemoteMethod("deletePending", this.handleInviteDeleted, this.send_to_mail);
            return;
        }// end function

        protected function handleInviteDeleted(param1:Message) : void
        {
            dispatchEvent(new Event(FriendItem.DELETE, true, false));
            parent.removeChild(this);
            return;
        }// end function

        protected function handleSendInvite(event:MouseEvent) : void
        {
            var _loc_2:* = /([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})""([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})/;
            if (_loc_2.test(tf_usermail.text))
            {
                Global.base.requestRemoteMethod("createInvite", this.handleInvitationSend, tf_usermail.text);
            }
            else
            {
                tf_error.text = "Please enter a valid e-mail address";
            }
            return;
        }// end function

        protected function handleCancelInvite(event:MouseEvent) : void
        {
            var _loc_2:* = (event.target as SimpleButton).parent as FriendItem;
            dispatchEvent(new Event(FriendItem.DELETE, true, false));
            parent.removeChild(this);
            return;
        }// end function

        protected function handleInvitationSend(param1:Message) : void
        {
            if (param1.getBoolean(0))
            {
                this.id = tf_usermail.text;
                this.init(PENDING);
            }
            else
            {
                tf_error.text = param1.getString(1);
            }
            return;
        }// end function

        protected function handleInviteDeletedOk(event:MouseEvent) : void
        {
            var _loc_2:* = event.target == btn_accept;
            Global.base.requestRemoteMethod("answerInvite", this.handleInviteDeletedReject, this.id, false);
            gotoAndStop(WAITING);
            return;
        }// end function

        protected function handleInviteDeletedReject(param1:Message) : void
        {
            dispatchEvent(new Event(FriendItem.DELETE, true, false));
            parent.removeChild(this);
            return;
        }// end function

        protected function handleAnswerInvitation(event:MouseEvent) : void
        {
            var _loc_2:* = event.target == btn_accept;
            Global.base.requestRemoteMethod("answerInvite", this.handleInvitationAnswered, this.id, _loc_2);
            gotoAndStop(WAITING);
            if (!_loc_2)
            {
                dispatchEvent(new Event(FriendItem.DELETE, true, false));
                parent.removeChild(this);
            }
            return;
        }// end function

        private function handleInvitationAnswered(param1:Message) : void
        {
            if (param1.getBoolean(0))
            {
                this.init(FRIEND);
                this.setSmiley(0);
                dispatchEvent(new Event(FriendItem.RELOAD, true, false));
            }
            else
            {
                this.init(INVITATION);
                tf_error.text = param1.getString(1);
            }
            return;
        }// end function

        protected function handleAnswerBlock(event:MouseEvent) : void
        {
            Global.base.requestRemoteMethod("blockInvite", null, this.id);
            Global.base.requestRemoteMethod("answerInvite", null, this.id, false);
            dispatchEvent(new Event(FriendItem.DELETE, true, false));
            parent.removeChild(this);
            return;
        }// end function

        protected function handleUnblock(event:MouseEvent) : void
        {
            Global.base.requestRemoteMethod("unblockInvite", null, this.id, this.id2);
            dispatchEvent(new Event(FriendItem.DELETE, true, false));
            parent.removeChild(this);
            return;
        }// end function

        protected function handleMouse(event:MouseEvent) : void
        {
            var _loc_2:Boolean = false;
            if (event.type == MouseEvent.MOUSE_OVER)
            {
                removeEventListener(MouseEvent.MOUSE_OVER, this.handleMouse);
                stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouse, false, 0, true);
            }
            else
            {
                _loc_2 = getBounds(this).contains(mouseX, mouseY);
                this.showMouseOver(_loc_2);
                if (!_loc_2)
                {
                    try
                    {
                        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouse);
                    }
                    catch (e:Error)
                    {
                    }
                    addEventListener(MouseEvent.MOUSE_OVER, this.handleMouse, false, 0, true);
                }
            }
            return;
        }// end function

        private function showMouseOver(param1:Boolean) : void
        {
            if (currentLabel == WAITING)
            {
                return;
            }
            switch(this.type)
            {
                case FRIEND:
                {
                    btn_delete.visible = param1;
                    break;
                }
                case CONFIRM:
                {
                    break;
                }
                case INVITE:
                {
                    break;
                }
                case PENDING:
                {
                    btn_delete.visible = param1;
                    break;
                }
                case INVITATION_DELETED:
                {
                    break;
                }
                case INVITATION:
                {
                    break;
                }
                case BLOCKED:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            eventarea.height = param1;
            divider.y = param1 - divider.height;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            var _loc_5:uint = 0;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_2:int = 45;
            var _loc_3:int = 10;
            eventarea.width = param1;
            divider.width = param1 - 4;
            var _loc_4:int = 8;
            divider_v.x = param1 - 2 * _loc_3 - _loc_2;
            divider_v.visible = true;
            if (currentLabel == WAITING)
            {
                return;
            }
            switch(this.type)
            {
                case FRIEND:
                {
                    btn_delete.x = divider_v.x + _loc_3;
                    btn_play.x = divider_v.x + _loc_3;
                    tf_name.width = divider_v.x - tf_name.x - _loc_3;
                    tf_online.width = divider_v.x - tf_online.x - _loc_3;
                    tf_playing.width = divider_v.x - tf_playing.x - _loc_3;
                    _loc_5 = 0;
                    if (this.worldname != null && this.worldname.length > 0)
                    {
                        tf_playing.text = this.worldname;
                        while (tf_playing.numLines > 1 && _loc_5 < this.worldname.length)
                        {
                            
                            _loc_5 = _loc_5 + 1;
                            tf_playing.text = this.worldname.substring(0, this.worldname.length - _loc_5).concat("...");
                        }
                    }
                    break;
                }
                case CONFIRM:
                {
                    divider_v.visible = false;
                    tf_msg.width = param1 - tf_msg.x;
                    btn_confirmcancel.x = param1 / 2 - btn_confirmcancel.width - 5;
                    btn_confirmdelete.x = param1 / 2 + 5;
                    break;
                }
                case INVITE:
                {
                    btn_send.x = divider_v.x + _loc_3;
                    btn_cancel.x = divider_v.x + _loc_3;
                    tf_mail.width = divider_v.x - tf_mail.x - _loc_3;
                    tf_usermail.width = divider_v.x - tf_usermail.x - _loc_3;
                    bg_mail.width = divider_v.x - bg_mail.x - _loc_3;
                    tf_error.width = divider_v.x - tf_error.x - _loc_3;
                    tf_moreinfo.width = divider_v.x - tf_error.x - _loc_3;
                    break;
                }
                case PENDING:
                {
                    btn_delete.x = divider_v.x + _loc_3;
                    tf_mail.width = divider_v.x - tf_mail.x - _loc_3;
                    _loc_6 = "Pending response:\n" + this.send_to_mail;
                    tf_mail.text = _loc_6;
                    while (tf_mail.numLines > 3 && _loc_5 < _loc_6.length)
                    {
                        
                        _loc_5 = _loc_5 + 1;
                        tf_mail.text = _loc_6.substring(0, _loc_6.length - _loc_5).concat("...");
                    }
                    break;
                }
                case INVITATION_DELETED:
                {
                    btn_ok.x = divider_v.x + _loc_3;
                    tf_mail.width = divider_v.x - tf_mail.x - _loc_3;
                    _loc_6 = "Sorry, the invitation from " + this.id.toUpperCase() + " no longer exist.";
                    tf_mail.text = _loc_6;
                    while (tf_mail.numLines > 3 && _loc_5 < _loc_6.length)
                    {
                        
                        _loc_5 = _loc_5 + 1;
                        tf_mail.text = _loc_6.substring(0, _loc_6.length - _loc_5).concat("...");
                    }
                    break;
                }
                case INVITATION:
                {
                    btn_accept.x = divider_v.x + _loc_3;
                    btn_ignore.x = divider_v.x + _loc_3;
                    btn_block.x = divider_v.x + _loc_3;
                    tf_mail.width = divider_v.x - tf_mail.x - _loc_3;
                    tf_error.width = divider_v.x - tf_error.x - _loc_3;
                    _loc_7 = this.id.toUpperCase() + " would like to be your friend.";
                    tf_mail.text = _loc_7;
                    while (tf_mail.numLines > 2 && _loc_5 < _loc_7.length)
                    {
                        
                        _loc_5 = _loc_5 + 1;
                        tf_mail.text = _loc_7.substring(0, _loc_7.length - _loc_5).concat("...");
                    }
                    break;
                }
                case BLOCKED:
                {
                    btn_unblock.x = divider_v.x + _loc_3;
                    tf_message.width = divider_v.x - tf_message.x - _loc_3;
                    _loc_8 = this.id + " is blocking: " + this.id2.toUpperCase();
                    tf_message.text = _loc_8;
                    while (tf_message.numLines > 3 && _loc_5 < _loc_8.length)
                    {
                        
                        _loc_5 = _loc_5 + 1;
                        tf_message.text = _loc_8.substring(0, _loc_8.length - _loc_5).concat("...");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
