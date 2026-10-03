package ui.roomlist
{
    import flash.display.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class RoomList extends asset_roomlist
    {
        private var container:Rows;
        private var rooms:Array;
        private var callback:Function;
        private var base:ScrollBox;
        private var preferred_height:int;
        private var history:String = "notsettosomething";
        public var showopen:Boolean = false;
        public var showlocked:Boolean = false;
        public var showmyworlds:Boolean = false;
        public var betaonly:Boolean = false;

        public function RoomList(param1:int, param2:Function)
        {
            this.container = new Rows();
            this.rooms = [];
            this.base = new ScrollBox().margin(0, 1, 1, 1).add(this.container);
            this.container.spacing(0);
            this.base.scrollMultiplier = 5;
            addChild(this.base);
            this.callback = param2;
            this.preferred_height = param1;
            this.doRender(true);
            this.base.width = 301 - 3;
            this.base.height = param1 - 3;
            this.base.x = 2;
            this.base.y = 2;
            bg.height = param1 + 1;
            return;
        }// end function

        public function setRooms(param1:Array) : void
        {
            var rooms:* = param1;
            this.rooms = rooms;
            rooms.sort(function (param1:Object, param2:Object) : int
            {
                var _loc_5:String = null;
                var _loc_6:String = null;
                if (param1.data.tutorial && param2.data.tutorial)
                {
                    return parseInt(param1.id) < parseInt(param2.id) ? (-1) : (1);
                }
                if (param1.data.tutorial)
                {
                    return param1.data.tutorialseen ? (1) : (-1);
                }
                if (param2.data.tutorial)
                {
                    return param2.data.tutorialseen ? (-1) : (1);
                }
                if (param1.data.myworld && !param2.data.myworld)
                {
                    return -1;
                }
                if (!param1.data.myworld && param2.data.myworld)
                {
                    return 1;
                }
                var _loc_3:* = param1.onlineUsers >= 40 ? (0) : (param1.onlineUsers);
                var _loc_4:* = param2.onlineUsers >= 40 ? (0) : (param2.onlineUsers);
                if (_loc_3 == _loc_4)
                {
                    _loc_5 = param1.data.name || param1.id;
                    _loc_6 = param2.data.name || param2.id;
                    return _loc_5 < _loc_6 ? (-1) : (1);
                }
                return _loc_3 > _loc_4 ? (-1) : (1);
            }// end function
            );
            return;
        }// end function

        public function render(param1:String = "", param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false) : void
        {
            this.history = param1;
            this.showopen = param2;
            this.showlocked = param3;
            this.showmyworlds = param4;
            this.betaonly = param5;
            this.doRender();
            return;
        }// end function

        public function doRender(param1:Boolean = false) : void
        {
            var _loc_6:Object = null;
            var _loc_7:String = null;
            var _loc_8:Room = null;
            var _loc_2:* = new Date();
            while (this.container.numChildren)
            {
                
                this.container.removeChild(this.container.getChildAt(0));
            }
            var _loc_3:int = 0;
            var _loc_4:Boolean = false;
            var _loc_5:int = 0;
            while (_loc_5 < this.rooms.length)
            {
                
                _loc_6 = this.rooms[_loc_5];
                _loc_7 = _loc_6.data.name || _loc_6.id;
                if ((this.history == "" || _loc_7.toLocaleLowerCase().indexOf(this.history.toLocaleLowerCase()) != -1) && (!this.containsBadwords(_loc_7) || _loc_6.data.myworld))
                {
                    if (!this.showlocked && _loc_6.data.needskey && !this.showmyworlds)
                    {
                    }
                    else if (!this.showopen && !_loc_6.data.needskey)
                    {
                    }
                    else if (this.showmyworlds && !_loc_6.data.myworld)
                    {
                    }
                    else if (!this.showmyworlds && (_loc_6.data.myworld && !_loc_6.data.plays))
                    {
                    }
                    else if (_loc_6.data.beta && !Global.player_is_beta_member)
                    {
                    }
                    else if (this.betaonly && !_loc_6.data.beta)
                    {
                    }
                    else
                    {
                        _loc_8 = new Room(_loc_6.id, this.makePrettyName(_loc_7), _loc_6.onlineUsers, parseInt(_loc_6.data.plays) || 1, _loc_6.data.myworld ? (true) : (false), _loc_6.data.owned, _loc_6.data.needskey || false, _loc_6, this.callback);
                        if (_loc_6.data.tutorial)
                        {
                            _loc_8.setAsTutorial();
                        }
                        _loc_3++;
                        this.container.addChild(_loc_8);
                    }
                }
                _loc_5++;
            }
            if (_loc_3 == 0)
            {
                this.container.addChild(param1 ? (new loadingrooms()) : (new norooms()));
            }
            this.base.refresh();
            this.base.scrollY = 1;
            return;
        }// end function

        private function containsBadwords(param1:String) : Boolean
        {
            if (Chat.filter(param1) != param1)
            {
                return true;
            }
            return false;
        }// end function

        private function makePrettyName(param1:String) : String
        {
            return param1.replace(/[ |\	t]{2,}""[ |\t]{2,}/gi, " ");
        }// end function

    }
}
