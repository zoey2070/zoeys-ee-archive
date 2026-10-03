package ui.profile
{
    import flash.display.*;

    public class FillBox extends Sprite
    {
        private var _width:Number = 100;
        private var ss:int = 0;
        private var hs:int = 2;
        private var forcescale:Boolean = false;

        public function FillBox(param1:int, param2:int = 0)
        {
            this.ss = param1;
            this.hs = param2;
            return;
        }// end function

        public function set forceScale(param1:Boolean) : void
        {
            this.forcescale = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1;
            this.redraw();
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            return;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            super.addChild(param1);
            this.redraw();
            return param1;
        }// end function

        private function redraw() : void
        {
            var _loc_5:DisplayObject = null;
            var _loc_1:Number = 0;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            while (_loc_4 < numChildren)
            {
                
                _loc_5 = getChildAt(_loc_4);
                if (_loc_1 + _loc_5.width + 2 > this._width)
                {
                    _loc_1 = 0;
                    _loc_2 = _loc_2 + (_loc_3 + this.ss);
                    _loc_3 = 0;
                }
                if (this.forcescale && _loc_1 + _loc_5.width + 2 > this._width)
                {
                    _loc_5.width = this._width - 2;
                }
                _loc_5.x = _loc_1;
                _loc_5.y = _loc_2;
                if (_loc_5.height > _loc_3)
                {
                    _loc_3 = _loc_5.height;
                }
                _loc_1 = _loc_1 + (_loc_5.width + this.hs);
                _loc_4++;
            }
            return;
        }// end function

    }
}
