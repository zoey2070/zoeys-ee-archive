package ui.profile
{
    import flash.display.*;
    import flash.events.*;
    import gameanalytics.*;
    import playerio.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class MyFriends extends Sprite
    {
        private var friends:Box;
        private var friendslist:Rows;
        private var friendsscrollbox:ScrollBox;
        private var friend_refresh:Date;
        private var is_loading:Boolean = false;
        private var invitationitems:Array;
        private var frienditems:Array;
        private var pendingitems:Array;
        private var blockeditems:Array;
        private static const UPDATE:int = 3000;

        public function MyFriends()
        {
            addEventListener(FriendItem.DELETE, this.handleFrienditemDeleted, false, 0, true);
            return;
        }// end function

        private function refreshContentFriends(param1:Function = null) : void
        {
            var callback:* = param1;
            var ready:* = function () : void
            {
                is_loading = false;
                var _loc_1:* = frienditems.length + pendingitems.length;
                renderFriendContent(invitationitems, frienditems, pendingitems);
                callback.call();
                return;
            }// end function
            ;
            this.friend_refresh = new Date();
            this.is_loading = true;
            if (this.friends)
            {
                removeChild(this.friends);
            }
            this.friends = new Box();
            addChild(this.friends);
            this.friends.margin(0, 0, 0, 0);
            this.friendslist = new Rows();
            this.friendslist.spacing(5);
            this.friendslist.addEventListener(Event.REMOVED, this.handleFriendItemRemoved, false, 0, true);
            this.friendslist.addEventListener(Event.CHANGE, this.handleFriendItemRemoved, false, 0, true);
            var topbar:* = new FillBox(3, 5);
            topbar.addChild(new asset_friendrequest());
            topbar.addChild(new asset_showfriends());
            topbar.addChild(new asset_showpending());
            topbar.addChild(new asset_showblocked());
            topbar.addEventListener(MouseEvent.MOUSE_DOWN, this.handleTopBarButton, false, 0, true);
            this.friends.add(new Box().margin(2, 2, 0, 0).add(topbar));
            this.friendsscrollbox = new ScrollBox().margin(0, 0, 0, 0).add(new Box().margin(0, 0, 0, 0).add(this.friendslist));
            this.friends.add(new Box().margin(25, 0, 0, 0).add(this.friendsscrollbox));
            this.invitationitems = [];
            this.frienditems = [];
            this.pendingitems = [];
            this.blockeditems = [];
            var loaded:int;
            Global.base.requestRemoteMethod("getInvitesToMe", function (param1:Message) : void
            {
                var _loc_3:FriendItem = null;
                var _loc_2:uint = 0;
                while (_loc_2 < param1.length)
                {
                    
                    if (!param1.getBoolean((_loc_2 + 1)))
                    {
                        _loc_3 = new FriendItem(FriendItem.INVITATION, param1.getString(_loc_2));
                    }
                    else
                    {
                        _loc_3 = new FriendItem(FriendItem.INVITATION_DELETED, param1.getString(_loc_2));
                        _loc_3.setSendTo(param1.getString(_loc_2 + 2));
                    }
                    invitationitems.push(_loc_3);
                    _loc_2 = _loc_2 + 3;
                }
                if (++loaded == 4)
                {
                    ready();
                }
                return;
            }// end function
            );
            Global.base.requestRemoteMethod("getFriends", function (param1:Message) : void
            {
                var itm:FriendItem;
                var msg:* = param1;
                var i:uint;
                while (i < msg.length)
                {
                    
                    itm = new FriendItem(FriendItem.FRIEND, msg.getString(i + 0));
                    itm.setOnlineStatus(msg.getBoolean((i + 1)), msg.getInt(i + 4), msg.getString(i + 2), msg.getString(i + 3));
                    frienditems.push(itm);
                    i = i + 5;
                }
                frienditems.sort(function (param1:FriendItem, param2:FriendItem) : int
                {
                    if (param1.onlineInWorld && !param2.onlineInWorld)
                    {
                        return -1;
                    }
                    if (!param1.onlineInWorld && param2.onlineInWorld)
                    {
                        return 1;
                    }
                    if (param1.online && !param2.online)
                    {
                        return -1;
                    }
                    if (!param1.online && param2.online)
                    {
                        return 1;
                    }
                    return 0;
                }// end function
                );
                GameAnalytics.newEvent(EventCategory.USER, {friendCount:frienditems.length});
                if (++loaded == 4)
                {
                    ready();
                }
                return;
            }// end function
            );
            Global.base.requestRemoteMethod("getPending", function (param1:Message) : void
            {
                var _loc_3:FriendItem = null;
                var _loc_2:uint = 0;
                while (_loc_2 < param1.length)
                {
                    
                    _loc_3 = new FriendItem(FriendItem.PENDING, param1.getString(_loc_2));
                    pendingitems.push(_loc_3);
                    _loc_2 = _loc_2 + 1;
                }
                if (++loaded == 4)
                {
                    ready();
                }
                return;
            }// end function
            );
            Global.base.requestRemoteMethod("getBlockedUsers", function (param1:Message) : void
            {
                var _loc_3:FriendItem = null;
                var _loc_2:uint = 0;
                while (_loc_2 < param1.length)
                {
                    
                    _loc_3 = new FriendItem(FriendItem.BLOCKED, param1.getString(_loc_2), param1.getString((_loc_2 + 1)));
                    blockeditems.push(_loc_3);
                    _loc_2 = _loc_2 + 2;
                }
                if (++loaded == 4)
                {
                    ready();
                }
                return;
            }// end function
            );
            return;
        }// end function

        protected function handleTopBarButton(event:MouseEvent) : void
        {
            var _loc_3:uint = 0;
            var _loc_4:FriendItem = null;
            var _loc_5:int = 0;
            while (this.friendslist.numChildren > 0)
            {
                
                this.friendslist.removeChildAt(0);
            }
            var _loc_2:Array = [];
            if (event.target is asset_friendrequest)
            {
                _loc_4 = new FriendItem(FriendItem.INVITE);
                this.pendingitems.unshift(_loc_4);
                _loc_2.push(_loc_4);
            }
            else if (event.target is asset_showfriends)
            {
                _loc_2 = this.invitationitems.concat(this.frienditems);
                if (_loc_2.length == 0)
                {
                    _loc_2.push(new Box().fill(10066329, 1).margin(15, NaN, NaN, 5).add(new Label("Invite friends by clicking +Add", 12, "left", 16777215, false, "system")));
                }
            }
            else if (event.target is asset_showpending)
            {
                _loc_5 = 0;
                while (_loc_5 < this.pendingitems.length)
                {
                    
                    if ((this.pendingitems[_loc_3] as FriendItem).type == FriendItem.INVITE)
                    {
                        this.pendingitems.splice(_loc_3, 1);
                    }
                    _loc_5++;
                }
                _loc_2 = this.pendingitems;
            }
            else if (event.target is asset_showblocked)
            {
                _loc_2 = this.blockeditems;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3] != null)
                {
                    this.friendslist.addChild(_loc_2[_loc_3]);
                }
                _loc_3 = _loc_3 + 1;
            }
            this.friendsscrollbox.refresh();
            return;
        }// end function

        protected function handleFrienditemDeleted(event:Event) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_2:* = event.target as FriendItem;
            switch(_loc_2.type)
            {
                case FriendItem.FRIEND:
                {
                    _loc_4 = 0;
                    while (_loc_4 < this.frienditems.length)
                    {
                        
                        if (this.frienditems[_loc_4] == _loc_2)
                        {
                            this.frienditems.splice(_loc_4, 1);
                        }
                        break;
                        _loc_4++;
                    }
                    break;
                }
                case FriendItem.INVITE:
                case FriendItem.PENDING:
                {
                    _loc_5 = 0;
                    while (_loc_5 < this.pendingitems.length)
                    {
                        
                        if (this.pendingitems[_loc_5] == _loc_2)
                        {
                            this.pendingitems.splice(_loc_5, 1);
                        }
                        break;
                        _loc_5++;
                    }
                    break;
                }
                case FriendItem.INVITATION:
                {
                    _loc_6 = 0;
                    while (_loc_6 < this.invitationitems.length)
                    {
                        
                        if (this.invitationitems[_loc_6] == _loc_2)
                        {
                            this.invitationitems.splice(_loc_6, 1);
                        }
                        break;
                        _loc_6++;
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

        protected function handleFriendItemRemoved(event:Event) : void
        {
            addEventListener(Event.EXIT_FRAME, this.handleExitFrame, false, 0, true);
            return;
        }// end function

        protected function handleExitFrame(event:Event) : void
        {
            removeEventListener(Event.EXIT_FRAME, this.handleExitFrame);
            this.friendslist.spacing(5);
            this.friendsscrollbox.refresh();
            return;
        }// end function

        private function renderFriendContent(param1:Array, param2:Array, param3:Array) : void
        {
            var _loc_4:uint = 0;
            while (_loc_4 < param1.length)
            {
                
                this.friendslist.addChild(param1[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:uint = 0;
            while (_loc_5 < param2.length)
            {
                
                this.friendslist.addChild(param2[_loc_5]);
                _loc_5 = _loc_5 + 1;
            }
            if (param1.length + param2.length == 0)
            {
                this.friendslist.addChild(new Box().fill(10066329, 1).margin(15, NaN, NaN, 5).add(new Label("Invite friends by clicking +Add", 12, "left", 16777215, false, "system")));
            }
            return;
        }// end function

        protected function handleAddFriend(event:MouseEvent) : void
        {
            var _loc_2:* = new FriendItem(FriendItem.INVITE);
            this.friendslist.addChildAt(_loc_2, 0);
            this.friendsscrollbox.refresh();
            return;
        }// end function

        public function refresh(param1:Function) : void
        {
            if (!this.is_loading && this.friend_refresh == null || new Date().time - this.friend_refresh.time > UPDATE)
            {
                this.refreshContentFriends(param1);
            }
            else
            {
                param1.call();
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.friends.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.friends.height = param1;
            return;
        }// end function

    }
}
