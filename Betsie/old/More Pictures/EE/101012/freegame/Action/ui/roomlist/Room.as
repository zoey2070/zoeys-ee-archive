package ui.roomlist
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Room extends asset_roominstance
    {

        public function Room(param1:String, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean, param8:Object, param9:Function)
        {
            var key:* = param1;
            var title:* = param2;
            var online:* = param3;
            var plays:* = param4;
            var myworld:* = param5;
            var saved:* = param6;
            var needskey:* = param7;
            var me:* = param8;
            var callback:* = param9;
            ltitle.embedFonts = true;
            ltitle.defaultTextFormat = new TextFormat(new system().fontName, 11);
            ltitle.text = title;
            ltitle.antiAliasType = AntiAliasType.ADVANCED;
            lonline.antiAliasType = AntiAliasType.ADVANCED;
            lonline.embedFonts = true;
            lonline.defaultTextFormat = new TextFormat(new system().fontName, 9, 10066329);
            lonline.text = online + " Online - Played by " + this.toScoreFormat(plays) + (plays == 1 ? (" person") : (" people"));
            var tf:* = new TextFormat(new system().fontName, 9, 8607744);
            lonline.setTextFormat(tf, (online + " Online ").length, lonline.text.length);
            if (online == 0)
            {
                lonline.visible = false;
            }
            if (!saved || true)
            {
                ownedicon.visible = false;
                ltitle.x = ltitle.x - 14;
                pathlock.x = pathlock.x - 14;
            }
            if (!myworld)
            {
                mine.visible = false;
                lonline.x = lonline.x - 30;
            }
            if (!needskey || true)
            {
                pathlock.visible = false;
                ltitle.x = ltitle.x - 14;
            }
            full.gotoAndStop(online >= 45 ? (2) : (1));
            addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                callback(key, title, me);
                return;
            }// end function
            );
            bg.visible = false;
            return;
        }// end function

        public function setAsTutorial() : void
        {
            bg.visible = true;
            bg.height = 38;
            divider.y = bg.height - 1;
            return;
        }// end function

        public function greyOut() : void
        {
            var _loc_1:* = new Sprite();
            _loc_1.mouseEnabled = false;
            _loc_1.graphics.beginFill(0, 0.5);
            _loc_1.graphics.drawRect(0, 0, width, height);
            addChild(_loc_1);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            full.x = param1 - full.width - 2;
            divider.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
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

    }
}
