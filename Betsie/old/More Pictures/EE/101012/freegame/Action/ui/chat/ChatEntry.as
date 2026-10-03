package ui.chat
{
    import flash.display.*;
    import flash.text.*;

    public class ChatEntry extends Sprite
    {
        private var t:TextField;

        public function ChatEntry(param1:String, param2:String, param3:Number, param4:Number)
        {
            this.t = new TextField();
            this.t.multiline = true;
            this.t.selectable = true;
            this.t.wordWrap = true;
            this.t.width = 190;
            this.t.height = 500;
            this.t.sharpness = 1;
            this.t.condenseWhite = true;
            var _loc_5:* = Player.isAdmin(param1);
            if (param3 != 0)
            {
                this.t.background = true;
                this.t.backgroundColor = param3;
            }
            var _loc_6:* = new TextFormat("Tahoma", 9, _loc_5 ? (8947848) : (8947848), false, false, false);
            new TextFormat("Tahoma", 9, _loc_5 ? (8947848) : (8947848), false, false, false).indent = -8;
            _loc_6.blockIndent = 8;
            _loc_6.align = TextFormatAlign.LEFT;
            this.t.defaultTextFormat = _loc_6;
            var _loc_7:* = _loc_5 ? (Config.admin_color) : (param4);
            this.t.text = param1.toUpperCase() + ": " + param2;
            this.t.setTextFormat(new TextFormat(null, null, _loc_7), 0, (param1 + ": ").length);
            this.t.x = 2;
            this.t.y = 1;
            this.t.height = this.t.textHeight + 5;
            addChild(this.t);
            this.cacheAsBitmap = true;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.t.width = param1;
            this.t.height = 200;
            this.t.height = this.t.textHeight + 5;
            return;
        }// end function

    }
}
