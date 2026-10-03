package ui
{
    import flash.events.*;

    public class Tab extends asset_tab
    {
        private var _selected:Boolean = false;
        private var _width:Number;
        private var _id:int;
        public static const ICON_CROWN:uint = 1;
        public static const ICON_SMILEY:uint = 2;
        public static const ICON_BRICK:uint = 3;
        public static const ICON_WORLD:uint = 4;
        public static const ICON_BOOK:uint = 5;
        public static const ICON_LIGHTNING:uint = 6;
        public static const ICON_POTION:uint = 7;

        public function Tab(param1:int, param2:String, param3:int)
        {
            mouseEnabled = true;
            mouseChildren = false;
            useHandCursor = true;
            buttonMode = true;
            this._id = param1;
            tf_label.text = param2;
            this.icon.gotoAndStop(param3);
            bg.stop();
            addEventListener(MouseEvent.MOUSE_OVER, this.handleMouse, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.handleMouse, false, 0, true);
            return;
        }// end function

        protected function handleMouse(event:Event) : void
        {
            if (!this._selected)
            {
                bg.gotoAndStop(event.type == MouseEvent.MOUSE_OVER ? (2) : (1));
            }
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            bg.gotoAndStop(this._selected ? (2) : (1));
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this.redraw();
            return;
        }// end function

        public function redraw() : void
        {
            bg.width = this._width;
            tf_label.width = this._width - tf_label.x;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

    }
}
