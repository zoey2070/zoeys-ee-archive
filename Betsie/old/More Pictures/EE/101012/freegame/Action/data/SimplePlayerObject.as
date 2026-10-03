package data
{

    public class SimplePlayerObject extends Object
    {
        public var name:String;
        public var smiley:int;
        public var maxEnergy:int;
        public var chatbanned:Boolean;
        public var haveSmileyPackage:Boolean;
        public var isModerator:Boolean;
        public var room0:String;
        public var betaonlyroom:String;
        public var roomkeys:Array;
        public var roomids:Array;
        public var rooms:Object;
        public var roomnames:Object;
        public var visible:Boolean;
        public var banned:Boolean;
        public var woot:int;

        public function SimplePlayerObject()
        {
            return;
        }// end function

        public function setRooms(param1:Array, param2:Array, param3:Array) : void
        {
            this.roomkeys = param1;
            this.roomids = param2;
            this.rooms = {};
            this.roomnames = {};
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                this.rooms[param1[_loc_4]] = param2[_loc_4];
                this.roomnames[param1[_loc_4]] = param3[_loc_4];
                _loc_4++;
            }
            return;
        }// end function

    }
}
