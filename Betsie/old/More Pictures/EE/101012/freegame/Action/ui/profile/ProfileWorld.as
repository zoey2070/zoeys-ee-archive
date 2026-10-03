package ui.profile
{
    import flash.display.*;
    import playerio.*;
    import sample.ui.components.*;

    public class ProfileWorld extends Box
    {
        public var key:String;
        public var plays:int = 0;
        private var bm:Bitmap;
        private var label:Label;

        public function ProfileWorld(param1:DatabaseObject)
        {
            var _loc_3:BitmapData = null;
            this.plays = param1.plays || 2;
            this.key = param1.key || "";
            border(1, 3355443, 1);
            fill(1118481, 1, 5);
            var _loc_2:* = new World(false);
            _loc_2.deserializeFromDatabaseObject(param1);
            this.label = new Label(param1.name + "\nplayed by " + ((param1.plays || 0) < 2 ? (2) : (param1.plays)) + " players", 12, "left", 16777215, false, "visitor");
            addChild(this.label);
            _loc_3 = new BitmapData(param1.width, param1.height, false, 3355443);
            this.bm = new Bitmap(_loc_3, "auto", true);
            addChild(this.bm);
            var _loc_4:* = new MiniMap(_loc_2, param1.width, param1.height);
            this.bm.x = 0;
            _loc_4.drawDirect(_loc_3);
            addChild(this.label);
            _loc_2 = null;
            _loc_4 = null;
            this.width = width + 6;
            this.height = this.bm.height + 6 + this.label.height + 1;
            this.bm.x = 3;
            this.bm.y = this.label.height + 3;
            this.useHandCursor = true;
            this.buttonMode = true;
            this.label.x = 2;
            this.label.y = 2;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            this.bm.width = Math.min(this.bm.width, param1 - 6);
            this.label.x = 2;
            this.label.y = 2;
            this.bm.x = 3;
            this.bm.y = this.label.height + 3;
            return;
        }// end function

    }
}
