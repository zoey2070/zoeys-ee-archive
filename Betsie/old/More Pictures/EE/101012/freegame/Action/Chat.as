package 
{
    import Chat.*;
    import __AS3__.vec.*;
    import blitter.*;
    import flash.display.*;
    import flash.filters.*;
    import io.player.tools.*;

    public class Chat extends BlContainer
    {
        protected var microchatimage:Class;
        private var microchat:BlSprite;
        private var chats:Vector.<ChatBubble>;
        private var name:BlText;
        private var color:uint;
        public static var queue:Array = [];

        public function Chat(param1:String)
        {
            this.microchatimage = Chat_microchatimage;
            this.microchat = BlSprite.createFromBitmapData(new this.microchatimage().bitmapData);
            this.chats = new Vector.<ChatBubble>;
            this.name = new BlText(14, 160, Player.isAdmin(param1) ? (16767097) : (16777215), "center", "visitor");
            this.name.filters = [new GlowFilter(0, 2, 2, 2, 2, 3)];
            this.name.x = -80 + 8;
            this.name.y = 15;
            this.name.text = param1;
            return;
        }// end function

        public function set textColor(param1:uint) : void
        {
            this.color = param1;
            var _loc_2:* = this.name.text;
            this.name = new BlText(14, 160, this.color, "center", "visitor");
            this.name.filters = [new GlowFilter(0, 2, 2, 2, 2, 3)];
            this.name.x = -80 + 8;
            this.name.y = 15;
            this.name.text = _loc_2;
            return;
        }// end function

        public function say(param1:String) : void
        {
            var _loc_4:ChatBubble = null;
            if (param1.length > 80)
            {
                param1 = param1.substring(0, 80);
            }
            param1 = Chat.filter(param1);
            var _loc_2:* = new ChatBubble(this.name.text, param1);
            var _loc_3:int = 0;
            while (_loc_3 < this.chats.length)
            {
                
                _loc_4 = this.chats[_loc_3] as ChatBubble;
                (this.chats[_loc_3] as ChatBubble).y = _loc_4.y - (_loc_2.height - 5);
                _loc_3++;
            }
            this.chats.push(_loc_2);
            if (this.chats.length > 3)
            {
                this.chats.shift();
            }
            return;
        }// end function

        override public function enterFrame() : void
        {
            var _loc_2:ChatBubble = null;
            var _loc_3:Number = NaN;
            var _loc_1:int = 0;
            while (_loc_1 < this.chats.length)
            {
                
                _loc_2 = this.chats[_loc_1] as ChatBubble;
                _loc_3 = new Date().getTime() - _loc_2.time.getTime();
                _loc_2.age(_loc_3);
                if (_loc_3 > 15000)
                {
                    this.chats.shift();
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function drawChat(param1:BitmapData, param2:Number, param3:Number, param4:Boolean) : void
        {
            var _loc_5:int = 0;
            if (param4)
            {
                this.name.draw(param1, param2, param3);
            }
            if (param4)
            {
                _loc_5 = 0;
                while (_loc_5 < this.chats.length)
                {
                    
                    if (this.chats[_loc_5].text == "")
                    {
                        this.microchat.draw(param1, param2 + 8, param3 - 5);
                    }
                    else
                    {
                        this.addToQueue(this.chats[_loc_5], param1, param2, param3);
                    }
                    _loc_5++;
                }
            }
            else if (this.chats.length > 0)
            {
                this.microchat.draw(param1, param2 + 8, param3 - 5);
            }
            return;
        }// end function

        private function addToQueue(param1:ChatBubble, param2:BitmapData, param3:Number, param4:Number) : void
        {
            var c:* = param1;
            var target:* = param2;
            var ox:* = param3;
            var oy:* = param4;
            queue.push({t:c.time.getTime(), m:function () : void
            {
                c.draw(target, ox, oy);
                return;
            }// end function
            });
            return;
        }// end function

        public static function filter(param1:String) : String
        {
            if (param1 == null)
            {
                return param1;
            }
            param1 = Badwords.Filter(param1);
            return param1;
        }// end function

        public static function drawAll() : void
        {
            var _loc_1:Object = null;
            queue.sortOn(["t"], Array.NUMERIC);
            while (queue.length)
            {
                
                _loc_1 = queue.shift();
                _loc_1.m();
            }
            return;
        }// end function

    }
}
