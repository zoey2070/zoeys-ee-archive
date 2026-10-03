package ui.chat
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import sample.ui.components.*;

    public class UserlistItem extends Box
    {
        protected var pImage:Class;
        public var username:String;
        public var time:Number;
        private var _count:int = 0;
        public var canchat:Boolean = false;
        public var isguest:Boolean = false;
        public var isfriend:Boolean = false;
        private var pimage:Bitmap;
        private var bm:Bitmap;
        private var clone:BlText;
        private var renderClone:BitmapData;

        public function UserlistItem(param1:String, param2:Boolean, param3:Boolean = false)
        {
            var un:* = param1;
            var canchat:* = param2;
            var isfriend:* = param3;
            this.pImage = UserlistItem_pImage;
            this.time = new Date().getTime();
            this.pimage = new this.pImage();
            this.canchat = canchat;
            this.isguest = un.indexOf("-") != -1;
            this.isfriend = isfriend;
            margin(0, 0, 0, 0);
            this.username = un;
            var chatcolor:Number;
            if (!canchat)
            {
                chatcolor;
            }
            if (this.isguest)
            {
                chatcolor = Config.guest_color;
            }
            if (isfriend)
            {
                chatcolor = Config.friend_color;
            }
            if (Player.isAdmin(un))
            {
                chatcolor = Config.admin_color;
            }
            var tf:* = new BlText(14, 195, chatcolor, "left", "visitor");
            tf.text = un;
            add(new Box().margin(0, NaN, NaN, 0).add(new Bitmap(tf.clone())));
            this.clone = new BlText(14, 20, chatcolor, "right", "visitor");
            this.renderClone = this.clone.clone();
            add(new Box().margin(0, 25, NaN, NaN).add(new Bitmap(this.renderClone)));
            var btn:* = new Sprite();
            btn.addChild(this.pimage);
            btn.buttonMode = true;
            btn.useHandCursor = true;
            btn.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
            {
                var _loc_2:NavigationEvent = null;
                if (event.shiftKey)
                {
                    navigateToURL(new URLRequest("http://everybodyedits.com/profiles/?/" + un), "_blank");
                }
                else
                {
                    _loc_2 = new NavigationEvent(NavigationEvent.SHOW_PROFILE, true);
                    _loc_2.username = un;
                    dispatchEvent(_loc_2);
                }
                return;
            }// end function
            );
            if (!this.isguest)
            {
                add(new Box().margin(3, 0, 0, NaN).add(btn));
            }
            return;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            this.clone.text = this._count < 2 ? ("") : (this._count.toString());
            this.renderClone.fillRect(this.renderClone.rect, 0);
            this.renderClone.draw(this.clone.clone());
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

    }
}
