package ui
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;

    public class TabBar extends Sprite
    {
        private var _spacing:Number = 0;
        private var tabs:Vector.<Tab>;
        private var _width:Number = 100;

        public function TabBar()
        {
            mouseEnabled = false;
            this.tabs = new Vector.<Tab>;
            addEventListener(MouseEvent.MOUSE_DOWN, this.handleTab, false, 0, true);
            return;
        }// end function

        protected function handleTab(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as Tab;
            this.setSelected(_loc_2.id);
            return;
        }// end function

        public function addTab(param1:int, param2:String, param3:int) : Tab
        {
            var _loc_4:* = new Tab(param1, param2, param3);
            this.tabs.push(_loc_4);
            addChild(_loc_4);
            return _loc_4;
        }// end function

        public function setSelected(param1:int, param2:Boolean = true) : void
        {
            if (param2)
            {
                this.deselectAll();
            }
            this.getTab(param1).selected = true;
            return;
        }// end function

        public function deselectAll() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.tabs.length)
            {
                
                this.tabs[_loc_1].selected = false;
                _loc_1++;
            }
            return;
        }// end function

        public function getTab(param1:int) : Tab
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.tabs.length)
            {
                
                if (this.tabs[_loc_2].id == param1)
                {
                    return this.tabs[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function redraw() : void
        {
            var _loc_1:* = this._width;
            var _loc_2:* = (this._width - (this.tabs.length - 1) * this._spacing) / this.tabs.length;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < this.tabs.length)
            {
                
                this.tabs[_loc_4].x = (_loc_2 + this._spacing) * _loc_4 >> 0;
                this.tabs[_loc_4].width = _loc_2;
                _loc_4++;
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this.redraw();
            return;
        }// end function

        public function get spacing() : Number
        {
            return this._spacing;
        }// end function

        public function set spacing(param1:Number) : void
        {
            this._spacing = param1;
            return;
        }// end function

    }
}
